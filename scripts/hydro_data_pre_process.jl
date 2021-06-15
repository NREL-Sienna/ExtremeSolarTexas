using PlotlyJS
using Dates
using HDF5

include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

hydro_data, hydro_file_names = hydro_files(hydro_time_series)
hydro = CSV.read(hydro_mapping, DataFrames.DataFrame)
hydro_bus_data_real_time = Dict()
hydro_bus_data_day_ahead = Dict()
# 2018 SCED data seems incomplete. Use 2017 instead
year_num = 2017

for (ix, row) in enumerate(eachrow(hydro))
    bus_name = row.bus_name
    if row.file_name == "ROR"
        hydro_bus_data_real_time[bus_name] = 0.5 * ones(8772 * 12)
        hydro_bus_data_day_ahead[bus_name] = 0.5 * ones(8772)
        continue
    end
    raw_hydro_data = hydro_data[row.file_name].Telemetered_Net_Output
    time_hydro = process_time(hydro_data[row.file_name].SCED_Time_Stamp)
    @assert length(raw_hydro_data) == length(time_hydro)
    hydro_bus_data_real_time[bus_name] =
        interpolate_data(time_hydro, raw_hydro_data, year_num)
    hydro_bus_data_real_time[bus_name] = hydro_bus_data_real_time[bus_name]/maximum(hydro_bus_data_real_time[bus_name])
    hydro_bus_data_day_ahead[bus_name] = upsample_data(hydro_bus_data_real_time[bus_name])
end

time_stamp_hour = range(DateTime("2018-01-01"), length = 8773, step = Hour(1))
data = hydro_bus_data_day_ahead["FALCON HEIGHTS 1 2"]
hour_trace = PlotlyJS.scatter(;
    x = time_stamp_hour,
    y = data,
    name = "DA",
    mode = "lines",
    line_shape = "hv",
)

time_stamp_rt = range(DateTime("2018-01-01"), length = 8760 * 12, step = Minute(5))
data = hydro_bus_data_real_time["FALCON HEIGHTS 1 2"]
intrahour_trace =
    PlotlyJS.scatter(; x = time_stamp_rt, y = data, name = "actuals", mode = "lines")

# Check time-scaling
PlotlyJS.plot([intrahour_trace, hour_trace])

initial_time = DateTime("2018-01-01")
da_interval = Hour(24)
da_horizon = 36
plant_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in hydro_bus_data_day_ahead
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = v
    for ix in 1:day_count
        current_ix = 1 + da_interval.value * (ix - 1)
        forecast = data[current_ix:(current_ix + da_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == da_horizon
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = forecast
    end
    plant_forecast[k] = day_ahead_forecast
end

time_stamp_ha = range(DateTime("2018-03-30"), length = 36, step = Hour(1))
da = plant_forecast["FALCON HEIGHTS 1 2"][DateTime("2018-03-30")]
da_trace = PlotlyJS.scatter(;
    x = time_stamp_ha,
    y = da,
    name = "da_trace",
    mode = "lines",
    line_shape = "hv",
)

PlotlyJS.plot([hour_trace, intrahour_trace, da_trace])

file_name = "hydro_power_da.h5"
h5open(file_name, "w") do file
    for (k, v) in plant_forecast
        data = sort(collect(v), by = x -> x[1])
        A = Matrix{Float64}(undef, length(data[1][2]), length(data))
        for (ix, forecast) in enumerate(data)
            A[:, ix] = forecast[2]
        end
        write(file, k, A)
    end
end

real_time_interval = Minute(5)
real_time_horizon = 24
real_time_plant_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in hydro_bus_data_real_time
    real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = v
    for current_ix in 1:(day_count * 24 * 12)
        forecast = data[current_ix:(current_ix + real_time_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == real_time_horizon
        real_time_forecast[initial_time + (current_ix - 1) * real_time_interval] = forecast
    end
    real_time_plant_forecast[k] = real_time_forecast
end
time_stamp_rt = range(DateTime("2018-03-30"), length = 36 * 12, step = Minute(5))
rt = [real_time_plant_forecast["FALCON HEIGHTS 1 2"][date][1] for date in time_stamp_rt]
rt_trace = PlotlyJS.scatter(; x = time_stamp_rt, y = rt, name = "rt_trace", mode = "lines")
PlotlyJS.plot([hour_trace, intrahour_trace, da_trace, rt_trace])

file_name = "hydro_power_rt.h5"
h5open(file_name, "w") do file
    for (k, v) in real_time_plant_forecast
        data = sort(collect(v), by = x -> x[1])
        A = Matrix{Float64}(undef, length(data[1][2]), length(data))
        for (ix, forecast) in enumerate(data)
            A[:, ix] = forecast[2]
        end
        write(file, k, A)
    end
end

initial_time = DateTime("2018-01-01")
ha_interval = Hour(1)
ha_horizon = 24
ha_plant_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in hydro_bus_data_real_time
    ha_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = v
    for ix in 1:(day_count * 24)
        current_ix = 1 + (12) * (ix - 1)
        forecast = data[current_ix:(current_ix + ha_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == real_time_horizon
        ts = initial_time + (ix - 1) * Hour(1)
        ha_forecast[ts] = forecast
        @assert all(ha_forecast[ts] .== real_time_plant_forecast[k][ts])
    end
    ha_plant_forecast[k] = ha_forecast
end
time_stamp_ha = range(DateTime("2018-03-30"), length = 36 * 12, step = Minute(5))
ha_ = [
    ha_plant_forecast["FALCON HEIGHTS 1 2"][date][1:12] for
    date in range(DateTime("2018-03-30"), length = 36, step = Hour(1))
]
ha = Vector{Float64}()
for i in 1:36
    push!(ha, ha_[i]...)
end
ha_trace = PlotlyJS.scatter(; x = time_stamp_ha, y = ha, name = "ha_trace", mode = "lines")
PlotlyJS.plot([hour_trace, intrahour_trace, da_trace, rt_trace, ha_trace])

file_name = "hydro_power_ha.h5"
h5open(file_name, "w") do file
    for (k, v) in ha_plant_forecast
        data = sort(collect(v), by = x -> x[1])
        A = Matrix{Float64}(undef, length(data[1][2]), length(data))
        for (ix, forecast) in enumerate(data)
            A[:, ix] = forecast[2]
        end
        write(file, k, A)
    end
end
