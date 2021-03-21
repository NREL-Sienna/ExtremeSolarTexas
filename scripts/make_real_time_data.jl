using PowerSystems
const PSY = PowerSystems

include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

sys = System("DA_sys.json")
clear_time_series!(sys)
PSY.IS.assign_new_uuid!(sys)

####################################### Load Time Series ###################################
h5open(load_time_series_realtime, "r") do file
   for area in get_components(Area, sys)
      real_time_load_forecast = Dict{Dates.DateTime, Vector{Float64}}()
      area_name = get_name(area)
      group_name = area_name_number_map[area_name]
      full_table = read(file, group_name)
      area_peak_load = maximum(full_table[:, 1])
      set_peak_active_power!(area, area_peak_load)
      for ix in 1:size(full_table)[1]
         real_time_load_forecast[initial_time + (ix - 1)*real_time_interval] = full_table[ix, :]./area_peak_load
      end
      forecast_data = Deterministic(
                     name = "max_active_power",
                     resolution = real_time_resolution,
                     data = real_time_load_forecast,)
      loads = collect(get_components(PowerLoad,
                                 sys,
                                 x-> get_area(get_bus(x)) == area))
      add_time_series!(sys,
                     vcat(loads, area),
                     forecast_data
                     )
   end
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
####################################### Hydro Time Series ##################################
hydro_data, hydro_file_names = hydro_files(hydro_time_series)
hydro = CSV.read(hydro_mapping, DataFrames.DataFrame)
hydro_bus_data_real_time = Dict()
# 2018 SCED data seems incomplete. Use 2017 instead
year_num = 2017

for (ix, row) in enumerate(eachrow(hydro))
   bus_name = row.bus_name
   if row.file_name == "ROR"
      hydro_bus_data_real_time[bus_name] = 0.5*ones(8772*12)
      continue
   end
   raw_hydro_data = hydro_data[row.file_name].Telemetered_Net_Output
   time_hydro = process_time(hydro_data[row.file_name].SCED_Time_Stamp)
   @assert length(raw_hydro_data) == length(time_hydro)
   hydro_bus_data_real_time[bus_name] = interpolate_data(time_hydro, raw_hydro_data, year_num)
end

for gen in get_components(HydroGen, sys)
   real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
   @show get_name(gen)
   bus_name = get_name(get_bus(gen))
   data = hydro_bus_data_real_time[bus_name]
   gen_peak = maximum(data)
   @assert gen_peak > 0
   for current_ix in 1:day_count*24*12
     forecast = data[current_ix:(current_ix + real_time_horizon - 1)]
     @assert !all(isnan.(forecast))
     @assert length(forecast) == real_time_horizon
     real_time_forecast[initial_time + (current_ix - 1)*real_time_interval] = forecast./gen_peak
   end
   forecast_data = Deterministic(
                    name = "max_active_power",
                    resolution = real_time_resolution,
                    data = real_time_forecast)
   add_time_series!(sys,
               gen,
               forecast_data
               )
end

for hy in get_components(HydroGen, sys)
   set_active_power_limits!(hy, (min = 0.0, max = hy.active_power_limits.max))
end

for hy in get_components(HydroGen, sys)
    ap = get_active_power(hy)
    p_lims_min = get_active_power_limits(hy).min
    if ap <= p_lims_min
        set_active_power!(hy, ap)
    end
    set_reactive_power!(hy, 0.0)
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
####################################### Wind Time Series ##################################
wind = CSV.read(wind_time_series, DataFrames.DataFrame)
load_zones = names(wind)[2:end]
year_data = wind[year.(wind.Time).== 2018, :]
unique!(year_data)
wind_data_real_time = Dict()
for lz in load_zones
   wind_data_real_time[lz] = year_data[!, lz]
   clean_up_nan!(wind_data_real_time[lz])
   @assert all(.!isnan.(wind_data_real_time[lz]))
   temp_data = upsample_data(year_data[!, lz])
   @assert all(.!isnan.(wind_data_real_time[lz]))
end

for (k, v) in wind_data_real_time
   wind_data_real_time[k] = vcat(v, v[105120 - 24:end])
end

for (k, v) in area_number_wind_map
   area = get_component(Area, sys, k)
   real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
   data = wind_data_real_time[v]
   area_peak = maximum(data)
   @assert area_peak > 0
   for current_ix in 1:day_count*24*12
     #current_ix = ix + (real_time_interval.value - 1)*(ix - 1)
     forecast = data[current_ix:(current_ix + real_time_horizon -1)]
     @assert !all(isnan.(forecast))
     @assert length(forecast) == real_time_horizon
     real_time_forecast[initial_time + (current_ix - 1)*real_time_interval] = forecast./area_peak
   end
   forecast_data = Deterministic(
                    name = "max_active_power",
                    resolution = real_time_resolution,
                    data = real_time_forecast)
   wind_gens = get_components(RenewableGen,
               sys,
               x -> (get_area(get_bus(x)) == area && get_prime_mover(x) == PrimeMovers.WT))
   add_time_series!(sys,
               wind_gens,
               forecast_data
               )
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
####################################### Solar Time Series ##################################
file_names = readdir("/Volumes/VM_WIN/Quantile data")
for gen in get_components(RenewableGen, sys, x -> get_prime_mover(x) == PrimeMovers.PVe)
   plant_name = get_name(gen)
   if occursin(r"^gen", plant_name)
      _, number_ = split(plant_name, '-')
      number = parse(Int, number_) - 1
      file_name = "solar$(number).h5"
   else
      file_name = "$(plant_name).h5"
   end
   if file_name  ∉ file_names
      @show plant_name
   end

   power_output = h5open(joinpath("/Volumes/VM_WIN/Quantile data", file_name), "r") do file
      return read(file, "Power")[:,  :, 50]
   end
   power_output = vcat(power_output, power_output[end-59:end,:])

   peak_power = maximum(power_output)
   @assert peak_power > 0
   @assert get_base_power(gen) <= get_base_power(gen)
   set_rating!(gen, peak_power/get_base_power(gen))
   normalized_power = power_output./maximum(power_output)
   real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
   for ix in 1:size(power_output)[1]
      real_time_forecast[initial_time + (ix - 1)*real_time_interval] = normalized_power[ix, :]
   end
   forecast_data = Deterministic(
               name = "max_active_power",
               resolution = real_time_resolution,
               data = real_time_forecast)
   add_time_series!(sys,
               gen,
               forecast_data
               )
end

for g in get_components(RenewableGen, sys)
   @assert has_time_series(g)
end

to_json(sys, "intermediate_sys.json", force = true)

regup_reserve = CSV.read(reg_up_reserve, DataFrame)
regdn_reserve = CSV.read(reg_dn_reserve, DataFrame)
spin = CSV.read(spin_reserve, DataFrame)
nonspin = CSV.read(nonspin_reserve, DataFrame)

date_range = range(DateTime("2018-01-01T00:00:00"), step = Minute(5), length = 365*25*12)

regup_reserve_ts = Vector{Float64}(undef, 365*25*12)
regdn_reserve_ts = Vector{Float64}(undef, 365*25*12)
spin_ts = Vector{Float64}(undef, 365*25*12)
nonspin_ts = Vector{Float64}(undef, 365*25*12)

for (ix, datetime) in enumerate(date_range)
   regup_reserve_ts[ix] = regup_reserve[hour(datetime) + 1, month(datetime) + 1]
   regdn_reserve_ts[ix] = regdn_reserve[hour(datetime) + 1, month(datetime) + 1]
   spin_ts[ix] = spin[hour(datetime) + 1, month(datetime) + 1]
   nonspin_ts[ix] = nonspin[hour(datetime) + 1, month(datetime) + 1]
end

reserve_map = Dict(
    ("REG_UP", VariableReserve{ReserveUp}) =>  regup_reserve_ts,
    ("SPIN", VariableReserve{ReserveUp}) => spin_ts,
    ("REG_DN", VariableReserve{ReserveDown}) => regdn_reserve_ts,
    ("NONSPIN", VariableReserveNonSpinning) => nonspin_ts
)

for ((name, T), ts) in reserve_map
    peak = maximum(ts)
    real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for current_ix in 1:day_count*24*12
        forecast = regup_reserve_ts[current_ix:(current_ix + real_time_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == real_time_horizon
        real_time_forecast[initial_time + (current_ix - 1)*real_time_interval] = forecast./peak
    end
    forecast_data = Deterministic(
                    name = "requirement",
                    resolution = real_time_resolution,
                    data = real_time_forecast)
    res = get_component(T, sys, name)
    add_time_series!(sys,
                res,
                forecast_data
                )
end

to_json(sys, "RT_sys.json", force = true)
