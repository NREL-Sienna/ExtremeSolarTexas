using PowerSystems
using HDF5
using TimeSeries
using Dates
using CSV
using DataFrames
using Statistics
using Logging
import Interpolations: LinearInterpolation
using Random
using Shapefile
using ProgressMeter
const PSY = PowerSystems
using JuMP
using CPLEX
using HDF5
using Plots
using JSON

function complete_lines_characteristic_impedance!(line_params, sys)
    z_c_data =
        Dict(115.0 => Float64[], 161.0 => Float64[], 230.0 => Float64[], 500.0 => Float64[])
    for br in get_components(Line, sys)
        base_voltage = get_arc(br) |> get_from |> get_base_voltage
        z_base = base_voltage^2 / 100
        Bc = 2 * get_b(br).from / z_base
        Zc = sqrt(get_x(br) * z_base / (Bc))
        push!(z_c_data[base_voltage], Zc)
    end

    for (voltage, params) in line_params
        if params.z_c === nothing
            params.z_c = tuple(quantile!(z_c_data[voltage], [0.1, 0.9])...)
        end
    end
end

function add_bus_coords(sys, shapefile)
    table = Shapefile.Table(shapefile)
    for row in table
        bus = get_component(Bus, sys, row.Name)
        isnothing(bus) && continue
        @assert Int(row.Number) == get_number(bus)
        get_ext(bus)["x"] = Shapefile.shape(row).x
        get_ext(bus)["y"] = Shapefile.shape(row).y
    end
end

function write_lines_geo_data(sys, file_name)
    df = DataFrame(name = String[], line = String[], voltage = Float64[])
    for b in get_components(ACBranch, sys)
        arc = get_arc(b)
        voltage = get_base_voltage(get_from(arc))
        from_coords = (get_ext(get_from(arc))["x"], get_ext(get_from(arc))["y"])
        to_coords = (get_ext(get_to(arc))["x"], get_ext(get_to(arc))["y"])
        line = "LINESTRING ($(from_coords[1]) $(from_coords[2]), $(to_coords[1]) $(to_coords[2])"
        push!(df, [get_name(b), line, voltage])
    end
    CSV.write("$file_name.csv", df)
end

function write_gen_buses_geo_data(sys, file_name)
    df_gens = DataFrame(
        bus_name = String[],
        gen_name = String[],
        point = String[],
        fuel = String[],
        capacity = Float64[],
    )
    for g in get_components(Generator, sys)
        bus = get_bus(g)
        push!(
            df_gens,
            [
                get_name(bus),
                get_name(g),
                "POINT ($(get_ext(bus)["x"]) $(get_ext(bus)["y"]))",
                string(get_prime_mover(g)),
                get_base_power(g),
            ],
        )
    end
    CSV.write("$file_name.csv", df_gens)
end

function get_line(sys, bus_name::String)
    bus_ = get_component(Bus, sys, bus_name)
    branch = get_components(
        Line,
        sys,
        x -> (get_from(get_arc(x)) == bus_) || (get_to(get_arc(x)) == bus_),
    )
    return collect(branch)
end

function get_transformer(sys, bus_name::String)
    bus_ = get_component(Bus, sys, bus_name)
    branch = get_components(
        ACBranch,
        sys,
        x -> (get_from(get_arc(x)) == bus_) || (get_to(get_arc(x)) == bus_),
    )
    return collect(branch)
end

function get_line(sys, bus_number::Int)
    bus_ = first(get_components(Bus, sys, x -> get_number(x) == bus_number))
    branch = get_components(
        Line,
        sys,
        x -> (get_from(get_arc(x)) == bus_) || (get_to(get_arc(x)) == bus_),
    )
    return collect(branch)
end

function get_line(sys, bus_numbers::Tuple)
    bus_1 = first(get_components(Bus, sys, x -> get_number(x) == bus_numbers[1]))
    bus_2 = first(get_components(Bus, sys, x -> get_number(x) == bus_numbers[2]))
    branch_1 = get_components(
        Line,
        sys,
        x -> (get_from(get_arc(x)) == bus_1) && (get_to(get_arc(x)) == bus_2),
    )
    if isempty(branch_1)
        branch_1 = get_components(
            Line,
            sys,
            x -> (get_from(get_arc(x)) == bus_2) && (get_to(get_arc(x)) == bus_1),
        )
    end
    @assert !isempty(branch_1) bus_numbers
    @assert length(branch_1) < 2 bus_numbers
    return collect(branch_1)[1]
end

function drop_arc!(sys, a::Tuple)
    line = get_line(sys, a)
    set_available!(line, false)
    try
        Ybus(sys)
        remove_component!(sys, line)
        remove_component!(sys, get_arc(line))
        @info "removed $(get_name(line))"
    catch e
        @show e
        error("Failed to remove $(get_name(line))")
        set_available!(line, true)
    end
end

function make_new_bus(bus_numer, bus_data, voltage_set_point)
    return Bus(
        number = bus_numer,
        name = bus_data[2],
        bustype = bus_data[4],
        angle = 0.01,
        magnitude = voltage_set_point,
        voltage_limits = (min = 0.9, max = 1.1),
        base_voltage = bus_data[1],
        area = get_component(Area, sys, "$(Int(bus_data[3]/1000))"),
        load_zone = nothing,
    )
end

function get_bc(x, base_voltage, data)
    z_base = base_voltage^2 / 100
    X = x * z_base
    Bc = X / data.z_c[2]^2
    b = Bc * z_base
    return (from = b / 2, to = b / 2)
end

function add_line!(sys, new_arc::Tuple)
    @assert new_arc[4] > 1
    try
        from_bus = get_component(Bus, sys, new_arc[2])
        to_bus = get_component(Bus, sys, new_arc[3])
        if isnothing(from_bus)
            voltage_set_point = isnothing(to_bus) ? 1.0 : get_magnitude(to_bus)
            from_bus_data = [b for b in new_buses if b[2] == new_arc[2]][1]
            end_bus_nums[from_bus_data[3]] = end_bus_nums[from_bus_data[3]] + 1 #add 1 to the last number
            from_bus = make_new_bus(
                end_bus_nums[from_bus_data[3]],
                from_bus_data,
                voltage_set_point,
            )
            @info "adding a new bus $(get_name(from_bus)), $(get_number(from_bus))"
            add_component!(sys, from_bus)
        end
        if isnothing(to_bus)
            voltage_set_point = isnothing(from_bus) ? 1.0 : get_magnitude(from_bus)
            to_bus_data = [b for b in new_buses if b[2] == new_arc[3]][1]
            end_bus_nums[to_bus_data[3]] = end_bus_nums[to_bus_data[3]] + 1 #add 1 to the last number
            to_bus =
                make_new_bus(end_bus_nums[to_bus_data[3]], to_bus_data, voltage_set_point)
            @info "adding a new bus $(get_name(to_bus)), $(get_number(to_bus))"
            add_component!(sys, to_bus)
        end
        @assert get_base_voltage(from_bus) == get_base_voltage(to_bus)
        base_voltage = get_base_voltage(from_bus)
        data = line_params[base_voltage]
        get_ext(sys)["last_line"] += 1
        last_line = get_ext(sys)["last_line"]
        new_line = Line(
            name = string("$(get_name(from_bus)) - $(get_name(to_bus)) - $last_line"),
            available = true,
            active_power_flow = 0.0,
            reactive_power_flow = 0.0,
            arc = Arc(from_bus, to_bus),
            r = data.impedance[2] * new_arc[4] / data.xr_ratio[2],
            x = data.impedance[2] * new_arc[4],
            b = get_bc(data.impedance[2] * new_arc[4], base_voltage, data),
            rate = 42.40 * (new_arc[4] / 1.6)^(-0.6595),
            angle_limits = (-π / 4, π / 4),
        )
        add_component!(sys, new_line)
    catch e
        @error(e)
    end
end

function add_transformer!(sys, new_arc)
    try
        from_bus = get_component(Bus, sys, new_arc[3])
        to_bus = get_component(Bus, sys, new_arc[4])
        if isnothing(from_bus)
            voltage_set_point = isnothing(to_bus) ? 1.0 : get_magnitude(to_bus)
            from_bus_data = [b for b in new_buses if b[2] == new_arc[3]][1]
            end_bus_nums[from_bus_data[3]] = end_bus_nums[from_bus_data[3]] + 1 #add 1 to the last number
            from_bus = make_new_bus(
                end_bus_nums[from_bus_data[3]],
                from_bus_data,
                voltage_set_point,
            )
            @info "adding a new bus $(get_name(from_bus)), $(get_number(from_bus))"
            add_component!(sys, from_bus)
        end
        if isnothing(to_bus)
            voltage_set_point = isnothing(from_bus) ? 1.0 : get_magnitude(from_bus)
            to_bus_data = [b for b in new_buses if b[2] == new_arc[4]][1]
            end_bus_nums[to_bus_data[3]] = end_bus_nums[to_bus_data[3]] + 1 #add 1 to the last number
            to_bus =
                make_new_bus(end_bus_nums[to_bus_data[3]], to_bus_data, voltage_set_point)
            @info "adding a new bus $(get_name(to_bus)), $(get_number(to_bus))"
            add_component!(sys, to_bus)
        end
        get_ext(sys)["last_line"] += 1
        last_line = get_ext(sys)["last_line"]
        high_side_voltage = get_base_voltage(from_bus)
        @assert high_side_voltage > get_base_voltage(to_bus)
        data = transformer_params[high_side_voltage]
        new_transformer = TapTransformer(
            name = string("$(get_name(from_bus)) - $(get_name(to_bus)) - $last_line"),
            available = true,
            active_power_flow = 0.0,
            reactive_power_flow = 0.0,
            arc = Arc(from_bus, to_bus),
            r = data.impedance[2] / data.xr_ratio[2],
            x = data.impedance[2],
            primary_shunt = 0.0,
            tap = 1.0,
            rate = 2000.0,
        )
        add_component!(sys, new_transformer)
    catch e
        @error(e)
    end
end

function add_pv_plant!(sys, plant::Tuple)
    @info "added" plant[1]
    data = solar[solar.site_ids .== plant[1], :]
    @assert !isempty(data)
    gen_bus = get_component(Bus, sys, plant[2])

    shunts = get_components(FixedAdmittance, sys, x -> get_bus(x) == gen_bus)
    gens = get_components(RenewableGen, sys, x -> get_bus(x) == gen_bus)

    if !isempty(shunts)
        for e in shunts
            remove_component!(sys, e)
            @info "removed shunt $(get_name(e)) in bus $(get_name(gen_bus))"
        end
    end

    if !isempty(gens)
        for g in gens
            set_active_power!(g, 0.0)
            if occursin(r"gen", get_name(g)) || get_prime_mover(g) != PrimeMovers.PVe
                remove_component!(sys, g)
                @info "removed generator $(get_name(g)) in bus $(get_name(gen_bus))"
            end
        end
    end

    set_bustype!(gen_bus, BusTypes.PV)
    pv_gen = RenewableDispatch(;
        name = data.site_ids[1],
        available = true,
        bus = gen_bus,
        active_power = 0.2,
        reactive_power = 0.01,
        rating = 1.0,
        prime_mover = PSY.PrimeMovers.PVe,
        reactive_power_limits = (min = -99.0, max = 99.0),
        power_factor = 1.0,
        base_power = data.AC_capacity_MW[1],
        operation_cost = TwoPartCost(nothing),
    )
    add_component!(sys, pv_gen)
    get_ext(sys)["added_power"] += data.AC_capacity_MW[1] * 0.2 / 100
end

function add_hydro_plant!(sys, plant::Tuple)
    @show "added" plant[1]
    data = hydro[hydro.plant_name .== plant[1], :]
    if data.existing == 1
        return
    end
    @assert !isempty(data)
    gen_bus = get_component(Bus, sys, plant[2])
    shunts = get_components(FixedAdmittance, sys, x -> get_bus(x) == gen_bus)
    if !isempty(shunts)
        for e in shunts
            remove_component!(sys, e)
            @info "removed shunt $(get_name(e)) in bus $(get_name(gen_bus))"
        end
    end
    set_bustype!(gen_bus, BusTypes.PV)
    hydro_gen = HydroDispatch(;
        name = plant[1],
        available = true,
        bus = gen_bus,
        active_power = 0.2,
        reactive_power = 0.01,
        rating = 1.0,
        active_power_limits = (min = 0.0, max = 0.9),
        prime_mover = PSY.PrimeMovers.HY,
        reactive_power_limits = (min = -0.9, max = 0.9),
        operation_cost = TwoPartCost(VariableCost(0), 0),
        base_power = data.AC_capacity[1],
        ramp_limits = nothing,
        time_limits = nothing,
    )
    add_component!(sys, hydro_gen)
    get_ext(sys)["added_power"] += data.AC_capacity[1] * 0.2 / 100
end

function get_bus_result(res, bus_no)
    return res["bus_results"][res["bus_results"].bus_number .== bus_no, :]
end

function check_pf_vm_results(res)
    return isempty(res["bus_results"][res["bus_results"].Vm .< 0.1, :])
end

function check_pf_va_results(res)
    return isempty(res["bus_results"][.!(-1.6 .< res["bus_results"].θ .< 1.6), :])
end

function check_pf_results(res)
    return .&(check_pf_vm_results(res), check_pf_va_results(res))
end

function hydro_files(hydro_path)
    hydro_files = collect(readdir(hydro_path))
    hydro_data_dict = Dict()
    hydro_list = []
    for file in hydro_files
        name, ext = splitext(file)
        if ext == ".csv"
            hydro_data_dict["$name"] = CSV.read(joinpath(hydro_path, file), DataFrame)
            hydro_list = push!(hydro_list, name)
        end
    end
    return hydro_data_dict, sort!(hydro_list)
end

function process_time(time_array::Array)
    new_time_array = Vector{DateTime}()
    for time in time_array
        date, clock = split(time, " ")
        clock_ = split(clock, ":")
        if length(clock_) == 2
            hour, minute = clock_
        elseif length(clock_) == 3
            hour, minute, second = clock_
        else
            error()
        end
        month, day, year_ = split(date, "/")
        if length(year_) == 2
            year = "20$(year_)"
        elseif length(year_) == 4
            year = year_
        else
            error()
        end
        new_time_array =
            push!(new_time_array, DateTime("$year-$month-$(day)T$hour:$minute:00"))
    end
    return sort!(new_time_array)
end

function clean_up_nan!(data::Vector{Float64})
    for (ix, val) in enumerate(data)
        ix == 1 && continue
        if isnan(val)
            if all(isnan.(data[ix:end]))
                data[ix:end] .= 0.0
                break
            end
            previous_val = data[ix - 1]
            if isnan(previous_val)
                error("$(ix)")
            end
            nan_counter = 1
            for jx in (ix + 1):length(data)
                if isnan(data[jx])
                    nan_counter += 1
                elseif isa(data[jx], Number)
                    next_val = data[jx]
                    data[ix:(ix + nan_counter - 1)]
                    @assert all(isnan.(data[ix:(ix + nan_counter - 1)]))
                    data[ix:(ix + nan_counter - 1)] .= (previous_val + next_val) / 2
                    break
                else
                    error()
                end
            end
        end
    end
    return nothing
end

function interpolate_data(time_::Vector{DateTime}, data::Vector{Float64}, year_num::Int64)
    df = DataFrames.DataFrame(:Date => time_, :Data => data)
    _year_data = df[year.(df.Date) .== year_num, :]
    unique!(_year_data) # remove repetitive entries
    length(_year_data.Data)
    full_year = range(DateTime("$(year_num)-01-01"), length = 8772 * 4, step = Minute(15))
    data = Vector{Float64}(undef, 8772 * 4)
    jx = 1
    for (ix, date) in enumerate(full_year)
        if date ∈ _year_data.Date
            data[ix] = _year_data.Data[jx]
            jx += 1
        else
            data[ix] = NaN
        end
    end
    clean_up_nan!(data)
    @assert all(.!isnan.(data))
    t_stamps =
        full_year =
            range(DateTime("$(year_num)-01-01"), length = 8772 * 12, step = Minute(5))
    _vals = range(1, length(data); length = length(t_stamps))
    interp_vals = LinearInterpolation(1:length(data), data)(_vals)
    return interp_vals
end

function upsample_data(data::Vector{Float64}, ratio = 12)
    data_size = Int(length(data) / ratio)
    upsampled_data = Vector{Float64}(undef, data_size)
    for ix in eachindex(upsampled_data)
        current_ix = ix + (ratio - 1) * (ix - 1)
        data_ = data[current_ix:(current_ix + ratio - 1)]
        upsampled_data[ix] = mean(data_)
    end
    return upsampled_data
end

function convert_to_pwl(device::PSY.ThermalStandard)
    var_cost = device.operation_cost.variable
    a = var_cost.cost[1]
    b = var_cost.cost[2]
    pmin = device.active_power_limits.min * device.base_power
    pmax = device.active_power_limits.max * device.base_power
    if isapprox(a, 0.0)
        @info get_name(device) "has linear cost function"
        break_points = [pmin, pmax]
        pwl_points = [(p^2 * a + p * b, p) for p in break_points]
    elseif a > 0.0
        @info get_name(device) "has quadratic cost function"
        break_points =
            [pmin, pmin + 1 / 3 * (pmax - pmin), pmin + 2 / 3 * (pmax - pmin), pmax]
        pwl_points = [(p^2 * a + p * b, p) for p in break_points]
    else
        error()
    end
    new_var_cost = PSY.VariableCost(pwl_points)
    PSY.set_variable!(device.operation_cost, new_var_cost)
    return
end

function get_tranche_count(df)
    col_names = names(df)
    tranche_count = 0
    for i in 10:-1:1
        for col_ in filter(x -> occursin(r"Submitted_TPO_Price", x), col_names)
            if occursin("Submitted_TPO_Price$(i)", col_)
                tranche_count = i
                return tranche_count
            end
        end
    end
    @assert tranche_count > 0
end

function make_variable_cost(f::Function, pmin, pmax, tranches::Int = 4)
    break_points = [pmin + i / tranches * (pmax - pmin) for i in 0:tranches]
    pwl_points = [(f(p), p) for p in break_points]
    new_var_cost = PSY.VariableCost([(c - f(pmin), p - pmin) for (c, p) in pwl_points])
    slopes = get_slopes(new_var_cost)
    for ix in 1:(length(slopes) - 1)
        if slopes[ix] > slopes[ix + 1]
            error("pwl_slopes not convex")
        end
    end
    return new_var_cost
end

function make_wind_units(system, device::PSY.RenewableDispatch)
    plant_name = strip(replace(get_name(get_bus(device)), r"[0-9]" => ""))
    for i in 1:100
        @show name = "$(plant_name)_$i"
        if get_component(RenewableDispatch, system, name) === nothing
            set_name!(system, device, name)
            break
        end
    end

    # Temporary while https://github.com/NREL-SIIP/PowerSystems.jl/pull/765 gets merged
    set_base_power!(device, round(device.base_power))
    set_rating!(device, sqrt(device.reactive_power_limits.max^2 + device.rating^2))
end

function make_start_up_costs(sced_data)
    cold_ = [0.0]
    warm_ = [0.0]
    hot_ = [0.0]
    if hasproperty(sced_data, :Start_Up_Cold_Offer)
        cold_ = sced_data.Start_Up_Cold_Offer[.!isnan.(sced_data.Start_Up_Cold_Offer)]
        cold_ = isempty(cold_[cold_ .> 0.0]) ? [0.0] : cold_[cold_ .> 0.0]
    end
    if hasproperty(sced_data, :Start_Up_Inter_Offer)
        warm_ = sced_data.Start_Up_Inter_Offer[.!isnan.(sced_data.Start_Up_Inter_Offer)]
        warm_ = isempty(warm_[warm_ .> 0.0]) ? [0.0] : warm_[warm_ .> 0.0]
    end
    if hasproperty(sced_data, :Start_Up_Hot_Offer)
        hot_ = sced_data.Start_Up_Hot_Offer[.!isnan.(sced_data.Start_Up_Hot_Offer)]
        hot_ = isempty(hot_[hot_ .> 0.0]) ? [0.0] : hot_[hot_ .> 0.0]
    end

    cold = median(cold_)
    warm = median(warm_)
    hot = median(hot_)
    @assert cold - warm >= -1 && warm - hot >= -10 cold warm hot
    return (hot = hot, warm = warm, cold = cold)
end

function get_cost_data_from_sced(sced_data, name, LSL, HSL)
    quad_terms, linear_terms, intercepts, points_cache =
        get_quadratic_terms(sced_data, LSL, HSL)
    start_up = make_start_up_costs(sced_data)
    if isempty(quad_terms)
        return start_up, -99.0, VariableCost(nothing)
    end
    quad_f_median =
        x -> median(intercepts) + median(linear_terms) * x + median(quad_terms) * x^2
    quad_f_mean = x -> mean(intercepts) + mean(linear_terms) * x + mean(quad_terms) * x^2
    _write_cost_function_data(name, [median(quad_terms), median(linear_terms)], median(intercepts))
    variable_cost = make_variable_cost(quad_f_median, LSL, HSL)
    var_points = variable_cost.cost
    no_load = quad_f_median(LSL)
    xlim = [minimum(vcat(points_cache.gen, LSL - 1)), maximum(vcat(points_cache.gen, HSL))]
    p = plot(legend = :outertopright, xlim = xlim)
    scatter!(p, points_cache.gen, points_cache.price, label = false)
    plot!(p, quad_f_median, xlim = xlim, label = "median cost")
    plot!(p, quad_f_mean, xlim = xlim, label = "mean cost")
    pwl = [(power + LSL, price + no_load) for (price, power) in var_points]
    plot!(p, pwl, label = "PWL")
    plot!(p, [(LSL, 0), (LSL, quad_f_median(HSL))], label = "LSL")
    plot!(p, [(HSL, 0), (HSL, quad_f_median(HSL))], label = "HSL")
    plot!(p, xlabel = "Power [MW]", ylabel = "Price [\$]")
    savefig(p, joinpath(COST_FUNCTION_PATHS, "$(name).pdf"))
    return start_up, no_load, variable_cost
end

function get_cost_data_from_sced_linear(sced_data, name, LSL, HSL)
    _, linear_terms, intercepts, points_cache =
        get_quadratic_terms(sced_data, LSL, HSL, false)

    quad_f_median = x -> median(intercepts) + median(linear_terms) * x
    quad_f_mean = x -> mean(intercepts) + mean(linear_terms) * x
    _write_cost_function_data(name, [0.0, median(linear_terms)], median(intercepts))
    start_up = make_start_up_costs(sced_data)
    variable_cost = make_variable_cost(quad_f_mean, LSL, HSL, 1)
    no_load = quad_f_median(LSL)
    xlim = [minimum(vcat(points_cache.gen, LSL - 1)), maximum(vcat(points_cache.gen, HSL))]
    p = plot(legend = :outertopright, xlim = xlim)
    scatter!(p, points_cache.gen, points_cache.price, label = false)
    plot!(p, quad_f_median, xlim = xlim, label = "median cost")
    plot!(p, quad_f_mean, xlim = xlim, label = "mean cost")
    plot!(p, [(LSL, 0), (LSL, quad_f_median(HSL))], label = "LSL")
    plot!(p, [(HSL, 0), (HSL, quad_f_median(HSL))], label = "HSL")
    plot!(p, xlabel = "Power [MW]", ylabel = "Price [\$]")
    plot!(p, title = "Linear Model for GSREH plants that are non-convex")
    savefig(p, joinpath(COST_FUNCTION_PATHS, "$(name).pdf"))
    return start_up, no_load, variable_cost
end

function _write_cost_function_data(name, polynomial_points, fixed_cost)
    vals = Dict("a" => polynomial_points[1], "b" => polynomial_points[2], "c" => fixed_cost)
    open(cost_function_file, "a") do file
        results = Dict(name => vals)
        write(file, JSON.json(results))
        write(file, "\n")
    end
end

function get_cost_data_from_gen(gen, name, LSL, HSL)
    gen_cost = get_operation_cost(gen)
    polynomial_points = get_variable(gen_cost) |> get_cost
    quad_f =
        x ->
            (polynomial_points[1] / 100^2) * x^2 +
            (polynomial_points[2] / 100) * x +
            get_fixed(gen_cost)
    _write_cost_function_data(name, polynomial_points, get_fixed(gen_cost))
    new_var_cost = make_variable_cost(quad_f, LSL, HSL)
    p = plot(legend = :outertopright)
    plot!(p, quad_f, xlim = [LSL, HSL], label = "quadratic_model")
    plot!(p, [(LSL, 0), (LSL, quad_f(HSL))], label = "LSL")
    plot!(p, [(HSL, 0), (HSL, quad_f(HSL))], label = "HSL")
    plot!(p, xlabel = "Power [MW]", ylabel = "Price [\$]")
    savefig(p, joinpath(COST_FUNCTION_PATHS, "$name.pdf"))
    start_up = (hot = 0.0, warm = 0.0, cold = 0.0)
    return start_up, quad_f(LSL), new_var_cost
end

function _get_coal_key(size)
    size <= coal_size_lims["SMALL"] && return ("CLLIG", "SMALL")
    coal_size_lims["SMALL"] < size < coal_size_lims["LARGE"] && return ("CLLIG", "LARGE")
    size > coal_size_lims["LARGE"] && return ("CLLIG", "SUPER")
end

function _get_key_for_missing_ercot_fuel(prime_mover, fuel, size)
    cross_map = key_remaps[(prime_mover, fuel)]
    if length(cross_map) > 1
        key = size < 90 ? cross_map[1] : cross_map[2]
    elseif cross_map[1] == "CLLIG"
        key = _get_coal_key(size)
    else
        key = cross_map[1]
    end

    return key
end

function _get_duration_limits(prime_mover, fuel, ercot_fuel, size)
    if ercot_fuel == "CLLIG"
        key = _get_coal_key(size)
    elseif ercot_fuel ∈ ["CCLE90", "CCGT90"]
        if prime_mover == "CC_CT"
            key = size > 90 ? "SCGT90" : "SCLE90"
        elseif prime_mover == "CC_CA"
            key = ercot_fuel
        else
            @assert false prime_mover, fuel, ercot_fuel, size
        end
    elseif ercot_fuel === nothing
        key = _get_key_for_missing_ercot_fuel(prime_mover, fuel, size)
    else
        key = ercot_fuel
    end
    return duration_lims[key]
end

function _get_ramp_limits(prime_mover, fuel, ercot_fuel, size)
    key = (prime_mover, fuel)
    lims = ramp_limits[key]
    noise_up = round(randn()/1000;  digits = 4)
    noise_down = round(randn()/1000;  digits = 4)
    noise_down = abs(noise_down) > 0.1 ? 0.0 : noise_down
    noise_up = abs(noise_up) > 0.1 ? 0.0 : noise_up
    return (up = round(lims.up + noise_up, sigdigits = 5), down = round(lims.down + noise_down, sigdigits = 5))
end

function _get_start_time_limits(prime_mover, fuel, ercot_fuel, size)
    if ercot_fuel == "CLLIG"
        key = _get_coal_key(size)
    elseif ercot_fuel ∈ ["CCLE90", "CCGT90"]
        if prime_mover == "CC_CT"
            key = size > 90 ? "SCGT90" : "SCLE90"
        elseif prime_mover == "CC_CA"
            key = ercot_fuel
        else
            @assert false prime_mover, fuel, ercot_fuel, size
        end
    elseif ercot_fuel === nothing
        key = _get_key_for_missing_ercot_fuel(prime_mover, fuel, size)
    else
        key = ercot_fuel
    end
    return start_time_limits[key]
end

function _get_start_types(prime_mover, fuel, ercot_fuel, size, start_up)
    key = (prime_mover, fuel)
    if key == ("ST", "NG")
        return max(1, sum([v > 0.0 for v in start_up]))
    else
        return start_types[key]
    end
end

function _get_power_trajectory(prime_mover, fuel, ercot_fuel, p_limits, size)
    base_values = power_trajectory[(prime_mover, fuel)]
    return (
        startup = max(base_values.startup * p_limits.max, p_limits.min),
        shutdown = max(base_values.shutdown * p_limits.max, p_limits.min)
    )
end

function make_thermal_gen(
    original_gen::ThermalStandard;
    name,
    prime_mover,
    fuel,
    LSL,
    HSL,
    sced_data = nothing,
    ercot_fuel = nothing,
)
    if LSL > HSL
        error("LSL > HSL")
    end
    temp_gen = ThermalMultiStart(nothing)
    p_limits, q_limits, rating, base_power = _rescale_power(original_gen, LSL, HSL)
    set_name!(temp_gen, uppercase(replace(name, " " => "_")))
    set_available!(temp_gen, true)
    set_bus!(temp_gen, get_bus(original_gen))
    original_set_point = get_active_power(original_gen) / base_power
    set_point = original_set_point > p_limits.max ? p_limits.max : original_set_point
    set_active_power!(temp_gen, max(set_point, p_limits.min))
    set_status!(temp_gen, get_active_power(original_gen) > 0.0)
    original_set_point = get_reactive_power(original_gen) / base_power
    set_point = original_set_point > q_limits.max ? q_limits.max : original_set_point
    set_reactive_power!(temp_gen, max(set_point, q_limits.min))
    set_rating!(temp_gen, rating)
    set_prime_mover!(temp_gen, prime_mover_map[prime_mover])
    set_fuel!(temp_gen, fuel_map[fuel])
    set_active_power_limits!(temp_gen, p_limits)
    set_reactive_power_limits!(temp_gen, q_limits)
    set_time_at_status!(temp_gen, 8760)
    set_base_power!(temp_gen, base_power)
    op_cost = MultiStartCost(nothing)

    if sced_data !== nothing
        start_up, no_load, variable_cost =
            get_cost_data_from_sced(sced_data, name, LSL, HSL)
        if no_load == -99
            _, no_load, variable_cost = get_cost_data_from_gen(gen, name, LSL, HSL)
        end
    else
        start_up, no_load, variable_cost = get_cost_data_from_gen(gen, name, LSL, HSL)
    end
    set_start_up!(op_cost, start_up)
    set_shut_down!(op_cost, 0.2 * start_up.hot)
    set_variable!(op_cost, variable_cost)
    set_no_load!(op_cost, no_load)
    set_operation_cost!(temp_gen, op_cost)

    duration_limits = _get_duration_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_time_limits!(temp_gen, duration_limits)

    ramp_limits = _get_ramp_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_ramp_limits!(temp_gen, ramp_limits)

    start_time_limits = _get_start_time_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_start_time_limits!(temp_gen, start_time_limits)

    start_types = _get_start_types(prime_mover, fuel, ercot_fuel, base_power, start_up)
    set_start_types!(temp_gen, start_types)

    power_trajectory =
        _get_power_trajectory(prime_mover, fuel, ercot_fuel, p_limits, base_power)
    set_power_trajectory!(temp_gen, power_trajectory)

    @info "$(name)"
    temp_gen.ext["ERCOT_FUEL"] = ercot_fuel !== nothing ? ercot_fuel : "Missing"
    return temp_gen
end

function make_thermal_gen_nuc(
    original_gen::ThermalStandard;
    name,
    prime_mover,
    fuel,
    LSL,
    HSL,
)
    temp_gen = ThermalMultiStart(nothing)
    p_limits_, q_limits, rating, base_power = _rescale_power(original_gen, LSL, HSL)
    p_limits = (min = p_limits_.max * 0.95, max = p_limits_.max)
    set_name!(temp_gen, replace(name, " " => "_"))
    set_available!(temp_gen, true)
    set_status!(temp_gen, true)
    set_bus!(temp_gen, get_bus(original_gen))
    set_active_power!(temp_gen, p_limits.max)
    set_reactive_power!(temp_gen, 0.0)
    set_rating!(temp_gen, rating)
    set_prime_mover!(temp_gen, prime_mover_map[prime_mover])
    set_fuel!(temp_gen, fuel_map[fuel])
    set_active_power_limits!(temp_gen, p_limits)
    set_reactive_power_limits!(temp_gen, q_limits)
    set_ramp_limits!(temp_gen, (up = 0.0001, down = 0.0001))
    set_power_trajectory!(temp_gen, (startup = 0.5, shutdown = 0.5))
    set_time_limits!(temp_gen, (up = 8760, down = 8760))
    set_start_time_limits!(temp_gen, (hot = 100, warm = 100, cold = 100))
    set_start_types!(temp_gen, 3)
    set_time_at_status!(temp_gen, 8760)
    set_base_power!(temp_gen, base_power)
    op_cost = MultiStartCost(nothing)
    set_start_up!(op_cost, (hot = 1e6, warm = 1e6, cold = 1e6))
    set_shut_down!(op_cost, 1e6)
    new_var_cost = make_variable_cost(x -> 0.01 * x + 0.01 * LSL, LSL, HSL, 1)
    set_variable!(op_cost, new_var_cost)
    set_no_load!(op_cost, 0.0)
    set_operation_cost!(temp_gen, op_cost)
    set_must_run!(temp_gen, true)
    temp_gen.ext["ERCOT_FUEL"] = "NUC"
    @info "$(name)"
    return temp_gen
end

function make_thermal_gen_st(
    original_gen::ThermalStandard;
    name,
    prime_mover,
    fuel,
    LSL,
    HSL,
    sced_data = nothing,
    ercot_fuel = nothing,
)
    if LSL > HSL
        error("LSL > HSL")
    end
    temp_gen = ThermalMultiStart(nothing)
    p_limits, q_limits, rating, base_power = _rescale_power(original_gen, LSL, HSL)
    set_name!(temp_gen, uppercase(replace(name, " " => "_")))
    set_available!(temp_gen, true)
    set_status!(temp_gen, true)
    set_bus!(temp_gen, get_bus(original_gen))
    set_active_power!(temp_gen, p_limits.min)
    set_reactive_power!(temp_gen, 0.0)
    set_rating!(temp_gen, rating)
    set_prime_mover!(temp_gen, prime_mover_map[prime_mover])
    set_fuel!(temp_gen, fuel_map[fuel])
    set_active_power_limits!(temp_gen, p_limits)
    set_reactive_power_limits!(temp_gen, q_limits)
    set_time_at_status!(temp_gen, 8760)
    set_base_power!(temp_gen, base_power)
    op_cost = MultiStartCost(nothing)

    if sced_data !== nothing
        start_up, no_load, variable_cost =
            get_cost_data_from_sced_linear(sced_data, name, LSL, HSL)
    else
        start_up, no_load, variable_cost = get_cost_data_from_gen(gen, name, LSL, HSL)
    end

    duration_limits = _get_duration_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_time_limits!(temp_gen, duration_limits)

    ramp_limits = _get_duration_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_ramp_limits!(temp_gen, ramp_limits)

    start_time_limits = _get_start_time_limits(prime_mover, fuel, ercot_fuel, base_power)
    set_start_time_limits!(temp_gen, start_time_limits)

    start_types = _get_start_types(prime_mover, fuel, ercot_fuel, base_power, start_up)
    set_start_types!(temp_gen, start_types)

    power_trajectory =
        _get_power_trajectory(prime_mover, fuel, ercot_fuel, p_limits, base_power)
    set_power_trajectory!(temp_gen, power_trajectory)

    set_start_up!(op_cost, start_up)
    set_shut_down!(op_cost, 0.2 * start_up.hot)
    set_variable!(op_cost, variable_cost)
    set_no_load!(op_cost, no_load)
    set_operation_cost!(temp_gen, op_cost)
    temp_gen.ext["ERCOT_FUEL"] = ercot_fuel !== nothing ? ercot_fuel : "Missing"
    @info "$(name)"
    return temp_gen
end

function _rescale_power(original_gen::ThermalStandard, LSL, HSL)
    gen_base_power = get_base_power(original_gen)
    gen_max_active_power = get_max_active_power(original_gen)
    q_lims = get_reactive_power_limits(original_gen)
    ratio_base_to_max = gen_base_power / gen_max_active_power
    new_base_power = round(HSL * ratio_base_to_max)
    active_power_limits = (min = LSL / new_base_power, max = HSL / new_base_power)
    reactive_power_ratio =
        q_lims.min / gen_max_active_power, q_lims.max / gen_max_active_power
    reactive_power_limits = (
        min = round(active_power_limits.min * reactive_power_ratio[1], sigdigits = 2),
        max = round(active_power_limits.max * reactive_power_ratio[2], sigdigits = 2),
    )
    rating = sqrt(
        active_power_limits.max^2 +
        max(abs(reactive_power_limits.min), abs(reactive_power_limits.max))^2,
    )
    @assert rating >= active_power_limits.max
    @assert new_base_power > rating
    return active_power_limits, reactive_power_limits, round(rating, sigdigits = 2),new_base_power
end

function make_storage(original_gen::ThermalStandard; name)
    temp = GenericBattery(nothing)
    base_power = get_base_power(original_gen)
    if base_power < 10
        base_power = base_power * 50
    elseif base_power < 100
        base_power = base_power * 10
    else
        @info name base power
    end
    set_base_power!(temp, base_power)
    set_name!(temp, replace(name, " " => "_"))
    set_available!(temp, true)
    set_bus!(temp, get_bus(original_gen))
    set_prime_mover!(temp, PrimeMovers.BA)
    gen_max_active_power = get_max_active_power(original_gen) / base_power
    c_rating = randperm!([2, 3, 4])[1]
    set_initial_energy!(temp, 0.0)
    set_state_of_charge_limits!(temp, (min = 0.0, max = gen_max_active_power * c_rating))
    set_active_power!(temp, get_active_power(original_gen) / base_power)
    set_reactive_power!(temp, 0.0)
    set_input_active_power_limits!(temp, (min = 0.0, max = gen_max_active_power))
    set_output_active_power_limits!(temp, (min = 0.0, max = gen_max_active_power))
    eff_data = (in = 0.83 + 0.05 * rand(), out = 0.91 - 0.05 * rand())
    set_efficiency!(temp, eff_data)
    qlims = get_reactive_power_limits(original_gen)
    set_reactive_power_limits!(
        temp,
        (min = -qlims.max / base_power, max = qlims.max / base_power),
    )
    set_rating!(temp, sqrt((gen_max_active_power)^2 + (qlims.max / base_power)^2))
    return temp
end

######################## Code to process SCED Cost function data ###########################
function get_gen_price_pairs(row, tranche_count)
    gen = fill(NaN, tranche_count)
    price = fill(NaN, tranche_count)
    for i in 1:tranche_count
        row["Submitted_TPO_MW$i"] > row["HSL"] && continue
        row["Submitted_TPO_Price$i"] < 0 && continue
        min_gen_cost = 0
        if hasproperty(row, "Min_Gen_Cost") && !isnan(row["Min_Gen_Cost"])
            min_gen_cost = row["Min_Gen_Cost"]
        end
        power = row["Submitted_TPO_MW$i"]
        total_cost = row["Submitted_TPO_Price$i"] * power + min_gen_cost * row["LSL"]
        gen[i] = row["Submitted_TPO_MW$i"]
        price[i] = total_cost
    end
    gen = Vector{Float64}(gen[.!isnan.(price)])
    price = Vector{Float64}(price[.!isnan.(price)])
    return gen, price
end

function get_sced_data(file_name, name)
    h5open(file_name, "r") do file
        if haskey(file, name)
            fuel = read(attributes(file[name])["ERCOT_FUEL"])
            return fuel, DataFrame(read(file, name))
        else
            return "NA", DataFrame()
        end
    end
end

function get_quadratic_model(gen, price, quad_term::Bool = true)
    m = Model(CPLEX.Optimizer)
    JuMP.set_silent(m)
    n_bp = length(price)
    @variable(m, var_price[1:n_bp] >= 0)
    @variable(m, quad_mult >= 0)
    !quad_term && fix(quad_mult, 0.0; force = true)
    @variable(m, linear_mult >= 0)
    @variable(m, intercept >= 0)
    @constraint(
        m,
        [i in 1:n_bp],
        var_price[i] == intercept + linear_mult * gen[i] + quad_mult * gen[i]^2
    )
    @objective(m, Min, sum((price[i] - var_price[i])^2 for i in 1:n_bp))
    optimize!(m)
    return value(quad_mult), value(linear_mult), value(intercept)
end

function skip_row(row)
    skip = false
    skip = !occursin("ON", row."Telemetered_Resource_Status")
    return skip
end

function get_quadratic_terms(df::DataFrames.DataFrame, LSL, HSL, quad_t = true)
    points_cache = (gen = Vector{Float64}(), price = Vector{Float64}())
    linear_terms = Vector{Float64}()
    quad_terms = Vector{Float64}()
    intercepts = Vector{Float64}()
    isempty(df) && return quad_terms, linear_terms, intercepts, points_cache
    tranche_count_ = get_tranche_count(df)
    for (ix, row) in enumerate(eachrow(df))
        skip_row(row) && continue
        gen_, price = get_gen_price_pairs(row, tranche_count_)
        select = .&(gen_ .>= LSL, gen_ .<= HSL)
        gen = gen_[select]
        price = price[select]
        isempty(gen) && continue
        all(iszero(gen)) && all(iszero(price)) && continue
        @assert gen[1] > 0 ix
        quad, lin, inter = get_quadratic_model(gen, price, true)
        @assert all([!isnan(quad), !isnan(lin), !isnan(inter)])
        push!(quad_terms, quad)
        push!(linear_terms, lin)
        push!(intercepts, inter)
        push!(points_cache.gen, gen...)
        push!(points_cache.price, price...)
    end
    return quad_terms, linear_terms, intercepts, points_cache
end

function finalize_system(sys)
    to_json(sys, "base_sys.json"; force = true)
    sys = System("base_sys.json")
    if isa(sys, System)
        rm("intermediate_sys.json")
        rm("intermediate_sys_time_series_storage.h5")
        rm("intermediate_sys_validation_descriptors.json")
    end
end
