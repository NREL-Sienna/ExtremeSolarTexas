SOURCE_DATA_DIR = "./input_data"
COST_FUNCTION_PATHS = joinpath(SOURCE_DATA_DIR, "Thermal", "cost_function_plots")

# Original Data Files
TAMU_matpower_file = joinpath(SOURCE_DATA_DIR, "ACTIVSg2000", "ACTIVSg2000.m")
TAMU_shp_file = joinpath(SOURCE_DATA_DIR, "ACTIVSg2000", "2000-bus-buses.shp")

# Mapping and Metadadata files
solar_metadata = joinpath(SOURCE_DATA_DIR, "Solar", "plant_metadata.csv")
hydro_mapping = joinpath(SOURCE_DATA_DIR, "Hydropower", "hydro_mapping.csv")
thermal_metada = joinpath(SOURCE_DATA_DIR, "Thermal", "thermal_metadata.csv")

# Time Series Files
wind_time_series_da = joinpath(SOURCE_DATA_DIR, "Wind", "wind_power_da.h5")
wind_time_series_ha = joinpath(SOURCE_DATA_DIR, "Wind", "wind_power_ha.h5")
wind_time_series_rt = joinpath(SOURCE_DATA_DIR, "Wind", "wind_power_rt.h5")

load_time_series_da = joinpath(SOURCE_DATA_DIR, "Load", "day_ahead_load_forecast.h5")
load_time_series_realtime =
    joinpath(SOURCE_DATA_DIR, "Load", "intra-hourly_load_forecast.h5")
load_time_series_realization = joinpath(SOURCE_DATA_DIR, "Load", "5-minute_load_actuals.h5")

perfect_load_time_series_da =
    joinpath(SOURCE_DATA_DIR, "Load", "day_ahead_perfect_load_forecast.h5")
perfect_load_time_series_realtime =
    joinpath(SOURCE_DATA_DIR, "Load", "intra-hourly_perfect_load_forecast.h5")

solar_time_series = joinpath(SOURCE_DATA_DIR, "Solar", "DA_time_series_files")

hydro_time_series_da = joinpath(SOURCE_DATA_DIR, "Hydropower", "hydro_power_da.h5")
hydro_time_series_ha = joinpath(SOURCE_DATA_DIR, "Hydropower", "hydro_power_ha.h5")
hydro_time_series_rt = joinpath(SOURCE_DATA_DIR, "Hydropower", "hydro_power_rt.h5")

solar_time_series_realization = joinpath(SOURCE_DATA_DIR, "Solar")

# Thermal SCED files
thermal_sced_data = joinpath(SOURCE_DATA_DIR, "Thermal", "60d_SCED_Gen_Resource_Data.zip")
thermal_sced_h5_file = joinpath(SOURCE_DATA_DIR, "Thermal", "sced_data_full.h5")
thermal_mapping = joinpath(SOURCE_DATA_DIR, "Thermal", "thermal_mapping.csv")

# Reserve Requirements
reg_up_reserve = joinpath(SOURCE_DATA_DIR, "Reserves", "regup_2021.csv")
reg_dn_reserve = joinpath(SOURCE_DATA_DIR, "Reserves", "regdn_2021.csv")
spin_reserve = joinpath(SOURCE_DATA_DIR, "Reserves", "spin_2021.csv")
nonspin_reserve = joinpath(SOURCE_DATA_DIR, "Reserves", "nonspin_2021.csv")
