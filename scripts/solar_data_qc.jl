using PlotlyJS
using Dates
using HDF5
using DataFrames

include("system_build_functions.jl")
include("manual_data_entries.jl")
include("file_pointers.jl")

file_names = readdir(solar_time_series)
plant_day_ahead = Dict{String, Dict{Dates.DateTime, Vector{Float64}}}()
site_names = CSV.read("solar_names.csv", DataFrame)
for gen in eachrow(site_names)
    plant_name = gen.names
    if occursin(r"^gen", plant_name)
        _, number_ = split(plant_name, '-')
        number = parse(Int, number_) - 1
        file_name = "solar$(number).h5"
    else
        file_name = "$(plant_name).h5"
    end
    power_output = h5open(joinpath(solar_time_series, file_name), "r") do file
        return read(file, "Power")[:, :, 50]
    end
    normalized_power = power_output# ./maximum(power_output)
    day_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
    for ix in 1:day_count
        day_ahead_forecast[initial_time + (ix - 1) * da_interval] = normalized_power[ix, :]
    end
    plant_day_ahead[plant_name] = day_ahead_forecast
end

actuals_ts = h5open(
    "/Users/jdlara/cache/blue_texas/input_data/Solar/5-minute solar actuals/Greyhound Solar.h5",
    "r",
) do file
    return read(file, "Power")
end

###### Forecasts #######
date = DateTime("2018-04-01T00:00:00")
look_ahead_hours = 36
day_count = dayofyear(date) - 1
hour = Dates.hour(date)
ix = (day_count * 24 + hour) * 12 + 1
actual = actuals_ts[ix:(ix + (look_ahead_hours * 12) - 1)]
da_forecast = plant_day_ahead["Greyhound Solar"][DateTime("2018-04-01")]

rt_output =
    h5open(joinpath("/Volumes/VM_WIN/Quantile data", "Greyhound Solar.h5"), "r") do file
        return read(file, "Power")[ix:(ix + 36 * 12 - 1), 1, 50]
    end

time_stamp_da = range(date, length = look_ahead_hours, step = Hour(1))
da_trace = PlotlyJS.scatter(;
    x = time_stamp_da,
    y = da_forecast,
    name = "DA",
    mode = "lines",
    line_shape = "hv",
)
PlotlyJS.plot(da_trace)

time_stamp_actuals = range(date, length = (look_ahead_hours * 12), step = Minute(5))
actual_trace =
    PlotlyJS.scatter(; x = time_stamp_actuals, y = actual, model = "Line", name = "Actual")

rt_trace = PlotlyJS.scatter(;
    x = time_stamp_actuals,
    y = rt_output,
    model = "Line",
    name = "Real Time",
)

PlotlyJS.plot([da_trace, actual_trace, rt_trace])

rt_output =
    h5open(joinpath("/Volumes/VM_WIN/Quantile data", "Greyhound Solar.h5"), "r") do file
        return read(file, "Power")[ix:(ix + 36 * 12 - 1), 1, 50]
    end
