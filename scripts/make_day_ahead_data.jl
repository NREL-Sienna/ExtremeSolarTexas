using PowerSystems
const PSY = PowerSystems

include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

sys_base = System("base_sys.json")
clear_time_series!(sys_base)
PSY.IS.assign_new_uuid!(sys_base)
set_units_base_system!(sys_base, "SYSTEM_BASE")

####################################### Load Time Series ###################################
for area in get_components(Area, sys_base)
        day_ahead_load_forecast = Dict{Dates.DateTime, Vector{Float64}}()
        h5open(perfect_load_time_series_da, "r") do file
        @show group_name = get_name(area)
        loads = get_components(PowerLoad, sys_base, x -> get_area(get_bus(x)) == area)
        peak_area_load = sum(get_max_active_power.(loads))
        full_table = read(file, group_name)
        ts_area_peak_load = maximum(full_table[:, 1])
        load_multiplier = 1.01*max(ts_area_peak_load/(get_base_power(sys_base)*peak_area_load), 1.0)
        for ix in 1:size(full_table)[1]
            day_ahead_load_forecast[initial_time + (ix - 1) * da_interval] =
                full_table[ix, :] ./ ts_area_peak_load
        end
        for l in loads
            set_max_active_power!(l, l.max_active_power*load_multiplier)
            set_max_reactive_power!(l, l.max_reactive_power*load_multiplier)
        end
        forecast_data = Deterministic(
            name = "max_active_power",
            resolution = da_resolution,
            data = day_ahead_load_forecast,
            scaling_factor_multiplier = get_max_active_power
        )
        @assert sum(get_max_active_power.(loads)) >= ts_area_peak_load/get_base_power(sys_base) group_name
        set_peak_active_power!(area, sum(get_max_active_power.(loads)))
        add_time_series!(sys_base, vcat(collect(loads), area), forecast_data)
    end
end

####################################### Hydro Time Series ##################################
h5open(hydro_time_series_da, "r") do file
    for gen in get_components(HydroGen, sys_base)
        set_available!(gen, true)
        day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
        bus_name = get_name(get_bus(gen))
        full_table = read(file, bus_name)
        gen_peak = maximum(full_table)
        @assert gen_peak > 0
        for ix in 1:size(full_table)[2]
            day_ahead_forecast[initial_time + (ix - 1) * da_interval] =
                full_table[:, ix] ./ gen_peak
        end
        forecast_data = Deterministic(
            name = "max_active_power",
            resolution = da_resolution,
            data = day_ahead_forecast,
            scaling_factor_multiplier = get_max_active_power
        )
        add_time_series!(sys_base, gen, forecast_data)
        ap = get_active_power(gen)
        p_lims_min = get_active_power_limits(gen).min
        if ap <= p_lims_min
            set_active_power!(gen, ap)
        end
        set_reactive_power!(gen, 0.0)
    end
end

####################################### Wind Time Series ##################################
h5open(wind_time_series_da, "r") do file
    for (k, v) in area_number_wind_map
        area = get_component(Area, sys_base, k)
        day_ahead_wind_forecast = Dict{Dates.DateTime, Vector{Float64}}()
        full_table = max.(0.0, read(file, v))
        area_peak_wind = maximum(full_table)
        set_peak_active_power!(area, area_peak_wind)
        for ix in 1:size(full_table)[2]
            day_ahead_wind_forecast[initial_time + (ix - 1) * da_interval] =
                full_table[:, ix] ./ area_peak_wind
        end
        forecast_data = Deterministic(
            name = "max_active_power",
            resolution = da_resolution,
            data = day_ahead_wind_forecast,
            scaling_factor_multiplier = get_max_active_power
        )
        wind_gens = get_components(
            RenewableGen,
            sys_base,
            x -> (get_area(get_bus(x)) == area && get_prime_mover(x) == PrimeMovers.WT),
        )
        add_time_series!(sys_base, wind_gens, forecast_data)
    end
end

####################################### Reserve Time Series ################################
regup_reserve = CSV.read(reg_up_reserve_2016, DataFrame)
regdn_reserve = CSV.read(reg_dn_reserve_2016, DataFrame)
spin = CSV.read(spin_reserve, DataFrame)
nonspin = CSV.read(nonspin_reserve_2016, DataFrame)

regup_reserve = CSV.read(reg_up_reserve_2016, DataFrame)
regdn_reserve = CSV.read(reg_dn_reserve_2016, DataFrame)
spin = CSV.read(spin_reserve, DataFrame)
nonspin_adj_solar = CSV.read(nonspin_adjustment_solar, DataFrame)
regup_reserve_adj_solar = CSV.read(reg_up_adjustment_solar, DataFrame)
regdn_reserve_adj_solar = CSV.read(reg_dn_adjustment_solar, DataFrame)


date_range = range(DateTime("2018-01-01T00:00:00"), step = da_resolution, length = 8796)

regup_reserve_ts = Vector{Float64}(undef, 8796)
regdn_reserve_ts = Vector{Float64}(undef, 8796)
spin_ts = Vector{Float64}(undef, 8796)
nonspin_ts = Vector{Float64}(undef, 8796)

solar_gens = get_components(
            RenewableGen,
            sys_base,
            x -> get_prime_mover(x) == PrimeMovers.PVe,
        )

total_solar = sum(get_max_active_power.(solar_gens))*0.1 # total in GW.

for (ix, datetime) in enumerate(date_range)
    regup_reserve_ts[ix] = regup_reserve[hour(datetime) + 1, month(datetime) + 1] + regup_reserve_adj_solar[hour(datetime) + 1, month(datetime) + 1].*total_solar
    regdn_reserve_ts[ix] = regdn_reserve[hour(datetime) + 1, month(datetime) + 1] + regdn_reserve_adj_solar[hour(datetime) + 1, month(datetime) + 1].*total_solar
    spin_ts[ix] = spin[hour(datetime) + 1, month(datetime) + 1]
    nonspin_ts[ix] = nonspin[hour(datetime) + 1, month(datetime) + 1] + nonspin_adj_solar[hour(datetime) + 1, month(datetime) + 1].*total_solar
end

reserve_map = Dict(
    ("REG_UP", VariableReserve{ReserveUp}) => regup_reserve_ts,
    ("SPIN", VariableReserve{ReserveUp}) => spin_ts,
    ("REG_DN", VariableReserve{ReserveDown}) => regdn_reserve_ts,
    ("NONSPIN", VariableReserveNonSpinning) => nonspin_ts,
)

for ((name, T), ts) in reserve_map
    peak = maximum(ts)
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for ix in 1:day_count
        current_ix = ix + (da_interval.value - 1) * (ix - 1)
        forecast = ts[current_ix:(current_ix + da_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == da_horizon
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = forecast ./ peak
    end
    forecast_data =
        Deterministic(name = "requirement", resolution = da_resolution, data = day_ahead_forecast,
        scaling_factor_multiplier = get_requirement)
    res = get_component(T, sys_base, name)
    set_requirement!(res, peak / 100)
    add_time_series!(sys_base, res, forecast_data)
end

sys = deepcopy(sys_base)

####################################### Solar Time Series ##################################
file_names = readdir(solar_time_series)
for gen in get_components(RenewableGen, sys, x -> get_prime_mover(x) == PrimeMovers.PVe)
    plant_name = get_name(gen)
    if occursin(r"^gen", plant_name)
        _, number_ = split(plant_name, '-')
        number = parse(Int, number_) - 1
        file_name = "solar$(number).h5"
    else
        file_name = "$(plant_name).h5"
    end
    if file_name ∉ file_names
        @show plant_name
    end
    power_output = h5open(joinpath(solar_time_series, file_name), "r") do file
        return read(file, "Power")[:, :, 50]
    end
    peak_power = maximum(power_output)
    @assert peak_power > 0
    @assert get_base_power(gen) <= get_base_power(gen)
    set_rating!(gen, peak_power / get_base_power(gen))
    normalized_power = power_output ./ maximum(power_output)
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for ix in 1:day_count
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = normalized_power[ix, :]
    end
    forecast_data = Deterministic(
        name = "max_active_power",
        resolution = da_resolution,
        data = day_ahead_forecast,
        scaling_factor_multiplier = get_max_active_power
    )
    add_time_series!(sys, gen, forecast_data)
end

for g in get_components(RenewableGen, sys)
    @assert has_time_series(g)
end

to_json(sys, "/Users/jdlara/Dropbox/texas_data/DA_sys.json", force = true)

############################ Add Scenario Data of UC #############################

sys_solar_scenarios_31 = deepcopy(sys_base)
PSY.IS.assign_new_uuid!(sys_solar_scenarios_31)
ts_data = "/Users/jdlara/cache/blue_texas/input_data/Solar/Trajectory forecasts -- 31 member 36 h horizon/Day ahead solar 31 trajectory mean forecasts"
file_names = readdir(ts_data)
for gen in get_components(RenewableGen, sys_solar_scenarios_31, x -> get_prime_mover(x) == PrimeMovers.PVe)
    !get_available(gen) && continue
    plant_name = get_name(gen)
    if occursin(r"^gen", plant_name)
        _, number_ = split(plant_name, '-')
        number = parse(Int, number_) - 1
        file_name = "solar$(number).h5"
    else
        file_name = "$(plant_name).h5"
    end
    if file_name ∉ file_names
        @show plant_name
    end
    power_output = h5open(joinpath(ts_data, file_name), "r") do file
        return read(file, "Power")
    end
    peak_power = maximum(power_output)
    @assert peak_power > 0
    @assert get_base_power(gen) <= get_base_power(gen)
    set_rating!(gen, peak_power / get_base_power(gen))
    normalized_power = power_output ./ maximum(power_output)
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for ix in 1:day_count
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = normalized_power[ix, :]
    end
    forecast_data = Deterministic(
        name = "max_active_power",
        resolution = da_resolution,
        data = day_ahead_forecast,
        scaling_factor_multiplier = get_max_active_power
    )
    add_time_series!(sys_solar_scenarios_31, gen, forecast_data)
end

for g in get_components(RenewableGen, sys_solar_scenarios_31)
    !get_available(g) && continue
    if !has_time_series(g)
        @show get_name(g)
        @assert false
    end
end

area_forecast = h5open("input_data/Solar/Trajectory forecasts -- 31 member 36 h horizon/day_ahead_ERCOT132_31_trajectories.h5", "r") do file
    return read(file, "Power")
end

hour_ahead_forecast = Dict{Dates.DateTime, Matrix{Float64}}()
for ix in 1:day_count
    hour_ahead_forecast[initial_time + (ix - 1) * da_interval] = area_forecast[ix, :, :]
end

scenario_forecast_data_31 = Scenarios(
    name = "solar_power",
    resolution = da_resolution,
    data = hour_ahead_forecast,
    scenario_count = 31
)
add_time_series!(sys_solar_scenarios_31, get_component(Area, sys_solar_scenarios_31, "FarWest"), scenario_forecast_data_31)

to_json(sys_solar_scenarios_31, "/Users/jdlara/Dropbox/texas_data/DA_sys_31_scenarios.json", force = true)

############################ Add Scenario Data of UC #############################
sys_solar_scenarios_84 = deepcopy(sys_base)
PSY.IS.assign_new_uuid!(sys_solar_scenarios_84)
ts_data = "/Users/jdlara/cache/blue_texas/input_data/Solar/Trajectory forecasts -- 84 member 30 h horizon/Day ahead solar 84 trajectory mean forecasts"
file_names = readdir(ts_data)
for gen in get_components(RenewableGen, sys_solar_scenarios_84, x -> get_prime_mover(x) == PrimeMovers.PVe)
    !get_available(gen) && continue
    plant_name = get_name(gen)
    if occursin(r"^gen", plant_name)
        _, number_ = split(plant_name, '-')
        number = parse(Int, number_) - 1
        file_name = "solar$(number).h5"
    else
        file_name = "$(plant_name).h5"
    end
    if file_name ∉ file_names
        @show plant_name
    end
    power_output_ = h5open(joinpath(ts_data, file_name), "r") do file
        return read(file, "Power")
    end
    power_output = hcat(power_output_, power_output_[:, 1:6])
    peak_power = maximum(power_output)
    @assert peak_power > 0
    @assert get_base_power(gen) <= get_base_power(gen)
    set_rating!(gen, peak_power / get_base_power(gen))
    normalized_power = power_output ./ maximum(power_output)
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for ix in 1:day_count
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = normalized_power[ix, :]
    end
    forecast_data = Deterministic(
        name = "max_active_power",
        resolution = da_resolution,
        data = day_ahead_forecast,
        scaling_factor_multiplier = get_max_active_power
    )
    add_time_series!(sys_solar_scenarios_84, gen, forecast_data)
end


for g in get_components(RenewableGen, sys_solar_scenarios_84)
    !get_available(g) && continue
    if !has_time_series(g)
        @show get_name(g)
        @assert false
    end
end

area_forecast_ = h5open("input_data/Solar/Trajectory forecasts -- 84 member 30 h horizon/day_ahead_ERCOT132_84_trajectories.h5", "r") do file
    return read(file, "Power")
end
area_forecast = hcat(area_forecast_, area_forecast_[:, 1:6, :])

hour_ahead_forecast = Dict{Dates.DateTime, Matrix{Float64}}()
for ix in 1:day_count
    hour_ahead_forecast[initial_time + (ix - 1) * da_interval] = area_forecast[ix, :, :]
end

scenario_forecast_data_84 = Scenarios(
    name = "solar_power",
    resolution = da_resolution,
    data = hour_ahead_forecast,
    scenario_count = 84
)
add_time_series!(sys_solar_scenarios_84, get_component(Area, sys_solar_scenarios_84, "FarWest"), scenario_forecast_data_84)

to_json(sys_solar_scenarios_84, "/Users/jdlara/Dropbox/texas_data/DA_sys_84_scenarios.json", force = true)
