include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

configure_logging(file_level = Logging.Info, console_level = Logging.Info)

sys = System("intermediate_sys.json")

for unit in get_components(HydroDispatch, sys)
    make_hydro_units(sys, unit)
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
