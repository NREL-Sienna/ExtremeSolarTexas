include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

configure_logging(file_level = Logging.Info, console_level = Logging.Info)

sys_base = System("intermediate_sys.json")
clear_time_series!(sys_base)
PSY.IS.assign_new_uuid!(sys_base)
set_units_base_system!(sys_base, "SYSTEM_BASE")

####################################### Load Time Series ###################################
# load_time_series_realization -> has NaN values
h5open(perfect_load_time_series_realtime, "r") do file
    for area in get_components(Area, sys_base)
        hour_ahead_forecast = Dict{Dates.DateTime, Vector{Float64}}()
        @show group_name = get_name(area)
        loads = get_components(PowerLoad, sys_base, x -> get_area(get_bus(x)) == area)
        peak_area_load = sum(get_max_active_power.(loads))
        full_table = read(file, group_name)
        @show ts_area_peak_load = maximum(full_table[:, 1])
        @show load_multiplier = 1.01*max(ts_area_peak_load/(get_base_power(sys_base)*peak_area_load), 1.0)
        for l in loads
            set_max_active_power!(l, l.max_active_power*load_multiplier)
            set_max_reactive_power!(l, l.max_reactive_power*load_multiplier)
        end
        @assert sum(get_max_active_power.(loads)) >= ts_area_peak_load/get_base_power(sys_base)
        set_peak_active_power!(area, sum(get_max_active_power.(loads)))
    end
end

to_json(sys_base, "intermediate_sys.json"; force = true)
