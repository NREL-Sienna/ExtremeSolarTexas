include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

configure_logging(file_level = Logging.Info, console_level = Logging.Info)

sys = System("intermediate_sys.json")

wind_units = get_components(RenewableGen, sys, x -> get_prime_mover(x) == PrimeMovers.WT)

for unit in wind_units
    make_wind_units(sys, unit)
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
