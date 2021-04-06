using PlotlyJS
using Dates
using HDF5

actuals_file = h5open("/Users/jdlara/cache/blue_texas/input_data/load/5-minute_load_actuals.h5")
da_load_forecast = h5open("/Users/jdlara/cache/blue_texas/input_data/load/day_ahead_load_forecast.h5")
rt_load_forecast = h5open("/Users/jdlara/cache/blue_texas/input_data/load/intra-hourly_load_forecast.h5")

da_load_forecast_perfect = h5open("/Users/jdlara/cache/blue_texas/input_data/load/day_ahead_perfect_load_forecast.h5")
rt_load_forecast_perfect = h5open("/Users/jdlara/cache/blue_texas/input_data/load/intra-hourly_perfect_load_forecast.h5")

###### Forecasts #######
date = DateTime("2018-04-01T00:00:00")
look_ahead_hours = 36
day_count = dayofyear(date) - 1
hour = Dates.hour(date)
ix = (day_count*24 + hour)*12 + 1
base_line_tl = range(DateTime("2018-01-01T00:00:00"), step=Minute(5), length=365*24*12)
@assert base_line_tl[ix] == date

actuals_ts = read(actuals_file, "ERCOT")
actual = actuals_ts[ix:ix+(look_ahead_hours*12)-1]
time_stamp_actuals = range(date, length = (look_ahead_hours*12), step = Minute(5))
@assert base_line_tl[ix:ix+(look_ahead_hours*12)-1] == time_stamp_actuals
actual_trace = scatter(; x = time_stamp_actuals, y = actual, model = "Line", name = "Actual")
plot(actual_trace)

da_ts = read(da_load_forecast, "ERCOT")
da = da_ts[day_count + 1, :]
time_stamp_da = range(date, length = look_ahead_hours, step = Hour(1))
da_trace = scatter(; x = time_stamp_da, y = da, name = "DA", mode = "lines", line_shape = "hv")
plot(da_trace)

ha_st = read(rt_load_forecast, "ERCOT")
ha_ixs = [(day_count*24 + hour)*12 + 1 for hour in 0:35]
ha_ = ha_st[ha_ixs, 1:12]
time_stamp_ha = range(date, length = (look_ahead_hours*12), step = Minute(5))
ha = Vector{Float64}()
for i in 1:36
    push!(ha, ha_[i,:]...)
end
ha_trace = scatter(; x = time_stamp_ha, y = ha, name = "HA", mode = "lines")

rt_st = read(rt_load_forecast, "ERCOT")
rt = rt_st[ix:ix+(look_ahead_hours*12)-1, 1]
time_stamp_rt = range(date, length = (look_ahead_hours*12), step = Minute(5))
rt_trace = scatter(; x = time_stamp_rt, y = rt, model = "Line", name = "RT")

plot([actual_trace, da_trace, ha_trace, rt_trace],)

########### Perfect data ############
da_ts = read(da_load_forecast_perfect, "ERCOT")
da = da_ts[day_count + 1, :]
time_stamp_da = range(date, length = look_ahead_hours, step = Hour(1))
da_trace = scatter(; x = time_stamp_da, y = da, name = "DA", mode = "lines", line_shape = "hv")

ha_st = read(rt_load_forecast_perfect, "ERCOT")
ha_ixs = [(day_count*24 + hour)*12 + 1 for hour in 0:35]
ha_ = ha_st[ha_ixs, 1:12]
time_stamp_ha = range(date, length = (look_ahead_hours*12), step = Minute(5))
ha = Vector{Float64}()
for i in 1:36
    push!(ha, ha_[i,:]...)
end
ha_trace = scatter(; x = time_stamp_ha, y = ha, name = "HA", mode = "lines")

rt_st = read(rt_load_forecast_perfect, "ERCOT")
rt = rt_st[ix:ix+(look_ahead_hours*12)-1, 1]
time_stamp_rt = range(date, length = (look_ahead_hours*12), step = Minute(5))
rt_trace = scatter(; x = time_stamp_rt, y = rt, model = "Line", name = "RT")

plot([actual_trace, da_trace, ha_trace, rt_trace],)
