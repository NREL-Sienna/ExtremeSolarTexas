using CSV
using PlotlyJS
using DataFrames

include("system_build_functions.jl")
include("manual_data_entries.jl")

SOURCE_DATA_DIR = "./input_data"
wind_time_series = joinpath(SOURCE_DATA_DIR, "Wind", "20172018_winddata_data.csv")

wind = CSV.read(wind_time_series, DataFrames.DataFrame)
load_zones = names(wind)[2:end]
year_data = wind[year.(wind.Time) .== 2018, :]
unique!(year_data)
wind_data_hour = Dict()
wind_data_real_time = Dict()
for lz in load_zones
    wind_data_real_time[lz] = year_data[!, lz]
    clean_up_nan!(wind_data_real_time[lz])
    @assert all(.!isnan.(wind_data_real_time[lz]))
    temp_data = upsample_data(year_data[!, lz])
    wind_data_hour[lz] = vcat(temp_data, temp_data[(end - 12):end])
    @assert all(.!isnan.(wind_data_hour[lz]))
end

time_stamp_hour = range(DateTime("2018-01-01"), length = 8773, step = Hour(1))
data = wind_data_hour["Houston"]
hour_trace = PlotlyJS.scatter(;
    x = time_stamp_hour,
    y = data,
    name = "DA",
    mode = "lines",
    line_shape = "hv",
)

time_stamp_rt = range(DateTime("2018-01-01"), length = 8760 * 12, step = Minute(5))
data = wind_data_real_time["Houston"]
intrahour_trace =
    PlotlyJS.scatter(; x = time_stamp_rt, y = data, name = "actuals", mode = "lines")

# Display Discretization
PlotlyJS.plot([hour_trace, intrahour_trace])

initial_time = DateTime("2018-01-01")
da_interval = Hour(24)
da_horizon = 36
area_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in area_number_wind_map
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = wind_data_hour[v]
    area_peak = 1.0 #maximum(data)
    @assert area_peak > 0
    for ix in 1:365
        current_ix = 1 + da_interval.value * (ix - 1)
        forecast = data[current_ix:(current_ix + da_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == da_horizon
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = forecast ./ area_peak
    end
    area_forecast[v] = day_ahead_forecast
end
time_stamp_ha = range(DateTime("2018-04-01"), length = 36, step = Hour(1))
da = area_forecast["Houston"][DateTime("2018-04-01")]
da_trace = PlotlyJS.scatter(;
    x = time_stamp_ha,
    y = da,
    name = "da_trace",
    mode = "lines",
    line_shape = "hv",
)

PlotlyJS.plot([hour_trace, intrahour_trace, da_trace])

file_name = "wind_power_da.h5"
h5open(file_name, "w") do file
    for (k, v) in area_forecast
        data = sort(collect(v), by = x -> x[1])
        A = Matrix{Float64}(undef, length(data[1][2]), length(data))
        for (ix, forecast) in enumerate(data)
            A[:, ix] = forecast[2]
        end
        write(file, k, A)
    end
end

for (k, v) in wind_data_real_time
    wind_data_real_time[k] = vcat(v, v[(105120 - 24):end])
end

real_time_interval = Minute(5)
real_time_horizon = 24
real_time_area_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in area_number_wind_map
    real_time_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = wind_data_real_time[v]
    area_peak = 1.0 # maximum(data)
    @assert area_peak > 0
    for current_ix in 1:(365 * 24 * 12)
        forecast = data[current_ix:(current_ix + real_time_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == real_time_horizon
        real_time_forecast[initial_time + (current_ix - 1) * real_time_interval] =
            forecast ./ area_peak
    end
    real_time_area_forecast[v] = real_time_forecast
end
time_stamp_rt = range(DateTime("2018-04-01"), length = 36 * 12, step = Minute(5))
rt = [real_time_area_forecast["Houston"][date][1] for date in time_stamp_rt]
rt_trace = PlotlyJS.scatter(; x = time_stamp_rt, y = rt, name = "rt_trace", mode = "lines")
PlotlyJS.plot([hour_trace, intrahour_trace, da_trace, rt_trace])

file_name = "wind_power_rt.h5"
h5open(file_name, "w") do file
    for (k, v) in real_time_area_forecast
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
ha_area_forecast = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
for (k, v) in area_number_wind_map
    ha_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    data = wind_data_real_time[v]
    area_peak = 1.0 # maximum(data)
    @assert area_peak > 0
    for ix in 1:(day_count * 24)
        current_ix = 1 + (12) * (ix - 1)
        forecast = data[current_ix:(current_ix + ha_horizon - 1)]
        @assert !all(isnan.(forecast))
        @assert length(forecast) == real_time_horizon
        ts = initial_time + (ix - 1) * Hour(1)
        ha_forecast[ts] = forecast ./ area_peak
        @assert all(ha_forecast[ts] .== real_time_area_forecast[v][ts])
    end
    ha_area_forecast[v] = ha_forecast
end
time_stamp_ha = range(DateTime("2018-04-01"), length = 36 * 12, step = Minute(5))
ha_ = [
    ha_area_forecast["Houston"][date][1:12] for
    date in range(DateTime("2018-04-01"), length = 36, step = Hour(1))
]
ha = Vector{Float64}()
for i in 1:36
    push!(ha, ha_[i]...)
end
ha_trace = PlotlyJS.scatter(; x = time_stamp_ha, y = ha, name = "ha_trace", mode = "lines")
PlotlyJS.plot([hour_trace, intrahour_trace, da_trace, rt_trace, ha_trace])

file_name = "wind_power_ha.h5"
h5open(file_name, "w") do file
    for (k, v) in ha_area_forecast
        data = sort(collect(v), by = x -> x[1])
        A = Matrix{Float64}(undef, length(data[1][2]), length(data))
        for (ix, forecast) in enumerate(data)
            A[:, ix] = forecast[2]
        end
        write(file, k, A)
    end
end
