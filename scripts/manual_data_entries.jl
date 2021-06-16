end_bus_nums = Dict(
    1000 => 1091,
    2000 => 2133,
    3000 => 3147,
    4000 => 4197,
    5000 => 5485,
    6000 => 6360,
    7000 => 7432,
    8000 => 8160,
)

const LAST_LINE = 3205

# https://scholarspace.manoa.hawaii.edu/bitstream/10125/50237/paper0350.pdf
# https://www.mdpi.com/1996-1073/10/8/1233/htm
mutable struct ArcParams
    impedance::Tuple
    xr_ratio::Tuple
    limits::Tuple
    z_c::Union{Nothing, Tuple}
end

function ArcParams(; impedance, xr_ratio, limits, z_c = nothing)
    return ArcParams(impedance, xr_ratio, limits, z_c)
end

line_params = Dict(
    115.0 => ArcParams(
        impedance = (0.000796, 0.003398, 0.006387),
        xr_ratio = (8.3, 4.6, 2.5),
        limits = (255, 160, 92),
    ),
    161.0 => ArcParams(
        impedance = (0.000517, 0.001828, 0.003780),
        xr_ratio = (10.0, 6.0, 4.1),
        limits = (410, 265, 176),
    ),
    230.0 => ArcParams(
        impedance = (0.000343, 0.000945, 0.001550),
        xr_ratio = (12.5, 9.0, 6.4),
        limits = (797, 541, 327),
        z_c = (365, 395),
    ),
    500.0 => ArcParams(
        impedance = (0.000121, 0.000155, 0.000210),
        xr_ratio = (26.0, 17.0, 11.0),
        limits = (3464, 2598, 1732),
        z_c = (233, 294),
    ),
)

transformer_params = Dict(
    115.0 => ArcParams(
        impedance = (0.05, 0.12, 0.2),
        xr_ratio = (48, 25, 16),
        limits = (140, 53, 22),
    ),
    161.0 => ArcParams(
        impedance = (0.05, 0.12, 0.2),
        xr_ratio = (68, 32, 18),
        limits = (276, 100, 48),
    ),
    230.0 => ArcParams(
        impedance = (0.05, 0.12, 0.2),
        xr_ratio = (84, 44, 25),
        limits = (470, 203, 63),
    ),
    500.0 => ArcParams(
        impedance = (0.05, 0.12, 0.2),
        xr_ratio = (119, 70, 44),
        limits = (1383, 812, 215),
    ),
)

new_buses = [
    (500, "DAWN_SOLAR 0", 2000, BusTypes.PQ),
    (500, "FRYE_SOLAR 0", 2000, BusTypes.PQ),
    (500, "ANDREWS 0 0", 1000, BusTypes.PQ),
    (500, "EUNICE_SOLAR 0", 1000, BusTypes.PQ),
    (500, "LAMESA 1", 1000, BusTypes.PQ),
    (500, "STANTON 1", 1000, BusTypes.PQ),
    (500, "COLORADO CITY 1", 3000, BusTypes.PQ),
    (500, "SAN ANGELO 1 1", 3000, BusTypes.PQ),
    (500, "MCCAMEY 1 2", 1000, BusTypes.PQ),
    (500, "MISAE_SOLAR 1 0", 2000, BusTypes.PQ),
    (230, "MISAE_SOLAR 1 1", 2000, BusTypes.PQ),
    (230, "MISAE_SOLAR 2 0", 2000, BusTypes.PQ),
    (500, "SHORTON 2", 2000, BusTypes.PQ),
    (115, "RADIAN_INCREASE 1", 5000, BusTypes.PQ),
    (115, "EARLY 1", 5000, BusTypes.PQ),
    (230, "QUEMADO 1", 4000, BusTypes.PQ),
    (230, "TREVINO_SOLAR 1", 4000, BusTypes.PQ),
    (115, "HALF_MOON_SOLAR 1", 4000, BusTypes.PQ),
    (115, "STILLWATER_SOLAR", 4000, BusTypes.PQ),
    (115, "MILLHOUSE_SOLAR", 4000, BusTypes.PQ),
    (115, "GSE_ELEVEN", 8000, BusTypes.PQ),
    (115, "CAUSE_SOLAR", 6000, BusTypes.PQ),
    (115, "SOLEMIO 1", 8000, BusTypes.PQ),
    (161, "RADIAN 0", 5000, BusTypes.PQ),
    (161, "HSHOE_BEND 0", 5000, BusTypes.PQ),
    (161, "OWENS_SOLAR", 5000, BusTypes.PQ),
    (161, "SPECTRUM_SOLAR 0", 5000, BusTypes.PQ),
    (161, "FRENCH_G_SOLAR 1", 5000, BusTypes.PQ),
    (161, "VISION_SOLAR 1", 5000, BusTypes.PQ),
    (161, "SANDINE_SOLAR", 2000, BusTypes.PQ),
    (161, "OBSIDIAN_SOLAR", 2000, BusTypes.PQ),
    (161, "CITRINE_SOLAR", 2000, BusTypes.PQ),
    (161, "SUN_VALLEY 1", 5000, BusTypes.PQ),
    (161, "SUN_VALLEY 2", 5000, BusTypes.PQ),
    (161, "ANGUS_SOLAR", 5000, BusTypes.PQ),
    (161, "MARKUM_SOLAR", 5000, BusTypes.PQ),
    (161, "FRYE_SOLAR 1", 2000, BusTypes.PQ),
    (161, "CASTRO_SOLAR 0", 2000, BusTypes.PQ),
    (161, "NAZARETH_SOLAR 0", 2000, BusTypes.PQ),
    (230, "WEST COLUMBIA 1", 7000, BusTypes.PQ),
    (230, "IMPACT_SOLAR", 8000, BusTypes.PQ),
    (230, "PINE_FOREST_SOLAR 1", 8000, BusTypes.PQ),
    (230, "TRI_COUNTY_SOLAR 1", 1000, BusTypes.PQ),
    (230, "TULSITA_SOLAR 1", 4000, BusTypes.PQ),
    (230, "DIAMONDBACK_SOLAR 1", 4000, BusTypes.PQ),
    (230, "ANGELINA_SOLAR 1", 8000, BusTypes.PQ),
    (230, "SMITHLAND_SOLAR 1", 5000, BusTypes.PQ),
    (230, "WAKE_SOLAR", 2000, BusTypes.PQ),
    (230, "PFLUGERVILLE_SOLAR 2", 6000, BusTypes.PQ),
    (230, "ZORRO_SOLAR", 4000, BusTypes.PQ),
    (230, "CORAZON_SOLAR", 4000, BusTypes.PQ),
    (230, "DOVE_RUN", 4000, BusTypes.PQ),
    (230, "ROSELAND_SOLAR", 8000, BusTypes.PV),
    (230, "RAYOS_DEL_SOL", 4000, BusTypes.PQ),
    (230, "ARROYO_SOLAR", 4000, BusTypes.PQ),
    (230, "FRONTON_SOLAR", 4000, BusTypes.PQ),
    (230, "STARR_SOLAR", 4000, BusTypes.PQ),
    (230, "WESTORIA_SOLAR 1", 7000, BusTypes.PQ),
    (230, "WAGYU_SOLAR 1", 7000, BusTypes.PQ),
    (230, "HOPKINS 1", 8000, BusTypes.PQ),
    (230, "MOUNT VERNON 1", 8000, BusTypes.PQ),
    (161, "SPANISH CROWN 1", 5000, BusTypes.PQ),
    (500, "SAMSON SOLAR 3 0", 2000, BusTypes.PQ),
    (500, "SAMSON SOLAR 1 0", 2000, BusTypes.PQ),
    (500, "NOTREES 1", 1000, BusTypes.PQ),
    (500, "ODESSA 5 1", 1000, BusTypes.PQ),
    (500, "ODESSA 6 1", 1000, BusTypes.PQ),
    (500, "ANDREWS 1", 1000, BusTypes.PQ),
    (500, "MBAR_SOLAR", 1000, BusTypes.PQ),
    (500, "WHATLEY_SOLAR", 1000, BusTypes.PQ),
    (500, "DESERT_ROSE_SOLAR", 1000, BusTypes.PQ),
    (500, "RODEO_SOLAR", 1000, BusTypes.PQ),
    (500, "CHARBRAY_SOLAR", 1000, BusTypes.PQ),
    (115, "NORTON_SOLAR", 3000, BusTypes.PQ),
    (230, "BLUE_BELL 2 0", 3000, BusTypes.PQ),
    (115, "BLUE_BELL 2 1", 3000, BusTypes.PQ),
    (115, "BLUE_BELL", 3000, BusTypes.PQ),
    (115, "PRICKLY_PEAR", 3000, BusTypes.PQ),
    (230, "ODONNELL 1", 1000, BusTypes.PQ),
    (500, "JUNO_SOLAR", 1000, BusTypes.PQ),
    (500, "GREEN_HOLLY", 1000, BusTypes.PQ),
    (500, "OXBOW_SOLAR", 3000, BusTypes.PQ),
    (500, "GOODRANCH_SOLAR", 3000, BusTypes.PQ),
    (500, "RAMSEY_SOLAR", 7000, BusTypes.PQ),
    (230, "QUEEN_SOLAR", 1000, BusTypes.PQ),
    (230, "FIGHTING_JAYS", 7000, BusTypes.PQ),
    (115, "HALLMARK_SOLAR", 5000, BusTypes.PQ),
    (161, "PHOENIX_SOLAR", 2000, BusTypes.PQ),
    (230, "HOLSTEIN 1", 3000, BusTypes.PQ),
    (230, "HOLSTEIN 2", 3000, BusTypes.PQ),
    (230, "THICKGRASS SOLAR", 7000, BusTypes.PQ),
    (161, "HILL_SOLAR", 5000, BusTypes.PQ),
    (115, "BLUE_JAY_SOLAR", 8000, BusTypes.PQ),
    (161, "CONIGLIO_SOlAR", 1000, BusTypes.PQ),
    (230, "SABINAL 1", 3000, BusTypes.PQ),
    (230, "UVALDE 1", 3000, BusTypes.PQ),
    (230, "GLOVE_SOLAR", 3000, BusTypes.PQ),
    (115, "BASALT_SOLAR", 3000, BusTypes.PQ),
    (115, "FLUORITE_SOLAR", 3000, BusTypes.PQ),
    (115, "SPINEL_SOLAR", 6000, BusTypes.PQ),
    (230, "CROWDED_STAR_SOLAR", 3000, BusTypes.PQ),
    (230, "HAMLIN 1", 3000, BusTypes.PQ),
    (115, "INDIGO_SOLAR", 3000, BusTypes.PQ),
    (115, "DISCO_SOLAR", 3000, BusTypes.PQ),
    (230, "ELROND", 3000, BusTypes.PQ),
    (230, "ROCHESTER 1", 2000, BusTypes.PQ),
    (230, "OLNEY 1 3", 5000, BusTypes.PQ),
    (115, "MUSTANG_CREEK", 7000, BusTypes.PQ),
    # Added For Hydropower
    (230, "AMISTAD_HYDRO 0", 4000, BusTypes.PQ),
    (18, "AMISTAD_HYDRO 1 1", 4000, BusTypes.PV),
    (18, "AMISTAD_HYDRO 1 2", 4000, BusTypes.PV),
    (18, "BUCHANAN DAM 1 3", 3000, BusTypes.PV),
    (18, "INKS 1", 3000, BusTypes.PV),
    (18, "MARSHALL FORD 1", 6000, BusTypes.PV),
    (18, "MARSHALL FORD 2", 6000, BusTypes.PV),
    (18, "MARSHALL FORD 3", 6000, BusTypes.PV),
    (18, "WHITNEY DAM 2", 5000, BusTypes.PV),
]

##################################### Time Series Section ##################################
day_count = 365
initial_time = DateTime("2018-01-01")

da_resolution = Hour(1)
real_time_resolution = Minute(5)
hour_ahead_resolution = Minute(5)

da_interval = Hour(24)
real_time_interval = Minute(5)
hour_ahead_interval = Hour(1)

da_horizon = 36
real_time_horizon = 24
hour_ahead_horizon = 24

####################################### Load Time Series ###################################
area_name_number_map = Dict(
    "1" => "FarWest",
    "2" => "North",
    "3" => "West",
    "4" => "Southern",
    "5" => "NorthCentral",
    "6" => "SouthCentral",
    "7" => "Coast",
    "8" => "East",
)

####################################### Wind Time Series ##################################
area_number_wind_map = Dict(
    "FarWest" => "LZ_West",
    "North" => "LZ_North",
    "West" => "West_North",
    "Southern" => "Houston",
    "NorthCentral" => "LZ_North",
    "SouthCentral" => "Houston",
    "Coast" => "Houston",
    "East" => "Houston",
)

#################################### Thermal Fleet Update ##################################
fuel_map = Dict(
    "LIG" => ThermalFuels.COAL,
    "NG" => ThermalFuels.NATURAL_GAS,
    "SUB" => ThermalFuels.COAL,
    "NUC" => ThermalFuels.NUCLEAR,
)

prime_mover_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

ramp_limits_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

power_trajectory_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

time_limits_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

start_time_limits_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

start_types_map = Dict(
    "ST" => PrimeMovers.ST,
    "GT" => PrimeMovers.GT,
    "CC" => PrimeMovers.CC,
    "CC_CT" => PrimeMovers.CT,
    "CC_CA" => PrimeMovers.CC,
)

SCED_keys = [
    "Resource_Name"
    "SCED_Time_Stamp"
    "LDL"
    "HDL"
    "Ancillary_Service_REGUP"
    "Ancillary_Service_REGDN"
    "LASL"
    "HASL"
    "Telemetered_Net_Output"
    "Resource_Type"
    "Telemetered_Resource_Status"
    "Start_Up_Cold_Offer"
    "Start_Up_Hot_Offer"
    "Start_Up_Inter_Offer"
    "Min_Gen_Cost"
]

coal_size_lims = Dict(
    "SMALL" => 300,
    "LARGE" => 900,
    #SUPER" => larger than 900
)

key_remaps = Dict(
    ("ST", "LIG") => ["CLLIG"],
    ("ST", "SUB") => ["CLLIG"],
    ("CC_CA", "NG") => ["CCLE90", "CCGT90"],
    ("CC_CT", "NG") => ["SCLE90", "SCGT90"],
    # Average of the GT
    ("GT", "NG") => ["SCLE90", "SCGT90"],
    ("ST", "NG") => ["GSREH"],
)

# Adapted from https://www.wecc.org/Reliability/1r10726%20WECC%20Update%20of%20Reliability%20and%20Cost%20Impacts%20of%20Flexible%20Generation%20on%20Fossil.pdf Table 2
duration_lims = Dict(
    ("CLLIG", "SMALL") => (up = 12.0, down = 6.0), # Coal and Lignite -> WECC (1) Small coal
    ("CLLIG", "LARGE") => (up = 12.0, down = 8.0), # WECC (2) Large coal
    ("CLLIG", "SUPER") => (up = 24.0, down = 8.0), # WECC (3) Super-critical coal
    "CCGT90" => (up = 2.0, down = 6.0),    # Combined cycle greater than 90 MW -> WECC (7) Typical CC
    "CCLE90" => (up = 2.0, down = 4.0), # Combined cycle less than 90 MW -> WECC (7) Typical CC, modified
    "GSNONR" => (up = 2.0, down = 4.0), # Gas steam non-reheat -> WECC (4) Gas-fired steam (sub- and super-critical)
    "GSREH" => (up = 2.0, down = 4.0), # Gas steam reheat boiler -> WECC (4) Gas-fired steam (sub- and super-critical)
    "GSSUP" => (up = 2.0, down = 4.0), # Gas-steam supercritical -> WECC (4) Gas-fired steam (sub- and super-critical)
    "SCGT90" => (up = 1.0, down = 1.0), # Simple-cycle greater than 90 MW -> WECC (5) Large-frame Gas CT
    "SCLE90" => (up = 1.0, down = 0.0), # Simple-cycle less than 90 MW -> WECC (6) Aero derivative CT
)

# Adapted from https://www.nrel.gov/docs/fy12osti/55433.pdf Table 1-1
start_time_limits = Dict(
    ("CLLIG", "SMALL") => (hot = 0.0, warm = 4.0, cold = 24.0),
    ("CLLIG", "LARGE") => (hot = 0.0, warm = 12.0, cold = 40.0),
    ("CLLIG", "SUPER") => (hot = 0.0, warm = 12.0, cold = 72.0),
    "CCGT90" => (hot = 0.0, warm = 8.0, cold = 24.0),
    "CCLE90" => (hot = 0.0, warm = 5.0, cold = 24.0),
    "GSNONR" => (hot = 0.0, warm = 4.0, cold = 48.0),
    "GSREH" => (hot = 0.0, warm = 4.0, cold = 48.0),
    "GSSUP" => (hot = 0.0, warm = 4.0, cold = 48.0),
    "SCGT90" => (hot = 0.0, warm = 0.0, cold = 1.0),
    "SCLE90" => (hot = 0.0, warm = 0.0, cold = 1.0),
)

start_types = Dict(
    ("ST", "LIG") => 3,
    ("ST", "SUB") => 3,
    ("CC_CA", "NG") => 3,
    ("CC_CT", "NG") => 1,
    ("GT", "NG") => 1,
    # not present in the PDF file
    ("ST", "NG") => 2, # 2 is an initial value, but base it on cost
)

power_trajectory = Dict(
    ("ST", "LIG") => (startup = 0.5, shutdown = 0.5),
    ("ST", "SUB") => (startup = 0.5, shutdown = 0.5),
    ("CC_CA", "NG") => (startup = 0.5, shutdown = 0.5),
    ("CC_CT", "NG") => (startup = 1.0, shutdown = 1.0),
    ("GT", "NG") => (startup = 1.0, shutdown = 1.0),
    ("ST", "NG") => (startup = 0.8, shutdown = 0.5),
)

# Values in pu/min. i.e. they are divided by 100
ramp_limits = Dict(
    ("ST", "LIG") => (up = 0.00264, down = 0.00264),
    ("ST", "SUB") => (up = 0.00264, down = 0.00264),
    ("CC_CA", "NG") => (up = 0.0042, down = 0.0042),
    ("CC_CT", "NG") => (up = 0.14, down = 0.14),
    # Average of the GT
    ("GT", "NG") => (up = 0.2475, down = 0.2475),
    ("ST", "NG") => (up = 0.0054, down = 0.0054),
)

fuels = ["CLLIG", "GSSUP", "GSREH", "GSNONR", "SCLE90", "SCGT90"]
valid = ["ON", "ONREG"]

gen_storage_mapping = Dict(
    "gen-13" => "PERMIAN BASIN STORAGE 1",
    "gen-14" => "PERMIAN BASIN STORAGE 2",
    "gen-15" => "PERMIAN BASIN STORAGE 3",
    "gen-16" => "PERMIAN BASIN STORAGE 4",
    "gen-17" => "PERMIAN BASIN STORAGE 5",
    "gen-18" => "PERMIAN BASIN STORAGE 6",
    "gen-20" => "RANDOM STORAGE",
    "gen-21" => "FREEZE STORAGE",
    "gen-49" => "CHEQUE STORAGE",
    "gen-81" => "MORGAN CREEK STORAGE 1",
    "gen-82" => "MORGAN CREEK STORAGE 2",
    "gen-134" => "MACHETE STORAGE",
    "gen-142" => "VALLEY ACRES STORAGE 1",
    "gen-143" => "VALLEY ACRES STORAGE 2",
    "gen-144" => "VALLEY ACRES STORAGE 3",
    "gen-145" => "VALLEY ACRES STORAGE 4",
    "gen-146" => "VALLEY ACRES STORAGE 5",
    "gen-147" => "VALLEY ACRES STORAGE 6",
    "gen-172" => "SILASRAY1 STORAGE",
    "gen-174" => "SILASRAY2 STORAGE",
    "gen-183" => "BELONG STORAGE",
    "gen-184" => "BUFFET STORAGE",
    "gen-185" => "INJECT STORAGE",
    "gen-195" => "CREATE STORAGE",
    "gen-196" => "MODEST STORAGE",
    "gen-201" => "RUNNER STORAGE",
    "gen-202" => "PALACE STORAGE",
    "gen-217" => "FAMILY STORAGE",
    "gen-233" => "INDOOR STORAGE",
    "gen-243" => "DECORDOVA STORAGE 1",
    "gen-244" => "DECORDOVA STORAGE 2",
    "gen-245" => "DECORDOVA STORAGE 3",
    "gen-246" => "DECORDOVA STORAGE 4",
    "gen-252" => "EXPORT STORAGE",
    "gen-253" => "FORBID STORAGE",
    "gen-269" => "OUTFIT STORAGE",
    "gen-270" => "REDEEM STORAGE",
    "gen-271" => "OUTLET STORAGE",
    "gen-298" => "EXPOSE STORAGE",
    "gen-336" => "CORNER STORAGE",
    "gen-344" => "REWARD STORAGE",
    "gen-345" => "REMARK STORAGE",
    "gen-346" => "BASKET STORAGE",
    "gen-347" => "SILVER STORAGE",
    "gen-348" => "BLOODY STORAGE",
    "gen-357" => "ACCESS STORAGE",
    "gen-362" => "FACTOR STORAGE",
    "gen-390" => "LEADER STORAGE",
    "gen-391" => "PRAISE STORAGE",
    "gen-392" => "SPIRIT STORAGE",
    "gen-402" => "THRONE STORAGE",
    "gen-412" => "CARBON STORAGE",
    "gen-413" => "PLANET STORAGE",
    "gen-414" => "BOMBER STORAGE",
    "gen-415" => "SALMON STORAGE",
    "gen-416" => "PACKET STORAGE",
    "gen-421" => "CHANGE STORAGE",
    "gen-432" => "STRICT STORAGE",
    "gen-433" => "MATRIX STORAGE",
    "gen-488" => "PIERCE STORAGE",
    "gen-532" => "ROSTER STORAGE",
    "gen-538" => "ZOOMMX STORAGE",
)

cc_train_restrictions = Dict(
    "ODESSA_ECTOR_POWER1" => ("ODESSA_ECTOR_POWER1_CC2", "ODESSA_ECTOR_POWER1_CC4"),
    "ODESSA_ECTOR_POWER2" => ("ODESSA_ECTOR_POWER2_CC2", "ODESSA_ECTOR_POWER2_CC4"),
    "QUAIL_RUN_ENERGY1" =>
        ("QUAIL_RUN_ENERGY1_CC1", "QUAIL_RUN_ENERGY1_CC2", "QUAIL_RUN_ENERGY1_CC4"),
    "QUAIL_RUN_ENERGY2" =>
        ("QUAIL_RUN_ENERGY2_CC1", "QUAIL_RUN_ENERGY2_CC2", "QUAIL_RUN_ENERGY2_CC4"),
    "PARIS_ENERGY_CENTER" => ("PARIS_ENERGY_CENTER_CC1", "PARIS_ENERGY_CENTER_CC2"),
    "WICHITA_FALLS_COGEN" => (
        "WICHITA_FALLS_COGEN_CC6",
        "WICHITA_FALLS_COGEN_CC8",
        "WICHITA_FALLS_COGEN_CC9",
    ),
    "PANDA_SHERMAN" => ("PANDA_SHERMAN_CC1", "PANDA_SHERMAN_CC2", "PANDA_SHERMAN_CC3"),
    "LAMAR_ENERGY_CENTER1" => (
        "LAMAR_ENERGY_CENTER1_CC1",
        "LAMAR_ENERGY_CENTER1_CC2",
        "LAMAR_ENERGY_CENTER1_CC4",
    ),
    "LAMAR_ENERGY_CENTER2" => (
        "LAMAR_ENERGY_CENTER2_CC1",
        "LAMAR_ENERGY_CENTER2_CC2",
        "LAMAR_ENERGY_CENTER2_CC4",
    ),
    "INGLESIDE" => (
        "INGLESIDE_CC1",
        "INGLESIDE_CC2",
        "INGLESIDE_CC3",
        "INGLESIDE_CC4",
        "INGLESIDE_CC5",
        "INGLESIDE_CC6",
    ),
    "HIDALGO_ENERGY_CENTER" => (
        "HIDALGO_ENERGY_CENTER_CC1",
        "HIDALGO_ENERGY_CENTER_CC2",
        "HIDALGO_ENERGY_CENTER_CC3",
    ),
    "BARNEY_DAVIS" => ("BARNEY_DAVIS_CC1", "BARNEY_DAVIS_CC2", "BARNEY_DAVIS_CC3"),
    "CAPITOL_GEN" => ("CAPITOL_GEN_CC1", "CAPITOL_GEN_CC2", "CAPITOL_GEN_CC3"),
    "CORPUS_CHRISTI" => ("CORPUS_CHRISTI_CC2", "CORPUS_CHRISTI_CC4"),
    "NUECES_BAY_REPOWER" => ("NUECES_BAY_REPOWER_CC1", "NUECES_BAY_REPOWER_CC2"),
    "SILAS_RAY" => ("SILAS_RAY_CC1", "SILAS_RAY_CC2"),
    "FORNEY_ENERGY_CENTER1" => (
        "FORNEY_ENERGY_CENTER1_CC1",
        "FORNEY_ENERGY_CENTER1_CC2",
        "FORNEY_ENERGY_CENTER1_CC3",
    ),
    "FORNEY_ENERGY_CENTER2" => (
        "FORNEY_ENERGY_CENTER2_CC1",
        "FORNEY_ENERGY_CENTER2_CC2",
        "FORNEY_ENERGY_CENTER2_CC3",
    ),
    "WISE_TRACTEBEL_POWER" => (
        "WISE_TRACTEBEL_POWER_CC1",
        "WISE_TRACTEBEL_POWER_CC2",
        "WISE_TRACTEBEL_POWER_CC3",
    ),
    "PANDA_TEMPLE_I" =>
        ("PANDA_TEMPLE_I_CC1", "PANDA_TEMPLE_I_CC2", "PANDA_TEMPLE_I_CC3"),
    "PANDA_TEMPLE_II" => ("PANDA_TEMPLE_II_CC1", "PANDA_TEMPLE_II_CC2"),
    "WOLF_HOLLOW_1" => ("WOLF_HOLLOW_1_CC1", "WOLF_HOLLOW_1_CC2", "WOLF_HOLLOW_2_CC2"),
    "JACK_COUNTY_GEN_FACILITY_1" => (
        "JACK_COUNTY_GEN_FACILITY_1_CC1",
        "JACK_COUNTY_GEN_FACILITY_1_CC2",
        "JACK_COUNTY_GEN_FACILITY_1_CC3",
    ),
    "JACK_COUNTY_GEN_FACILITY_2" => (
        "JACK_COUNTY_GEN_FACILITY_2_CC1",
        "JACK_COUNTY_GEN_FACILITY_2_CC2",
        "JACK_COUNTY_GEN_FACILITY_2_CC3",
    ),
    "ENNIS_POWER_STATION" => ("ENNIS_POWER_STATION_CC1", "ENNIS_POWER_STATION_CC2"),
    "LOST_PINES_POWER" => ("LOST_PINES_POWER_CC1", "LOST_PINES_POWER_CC2"),
    "GUADALUPE_ENERGY_CENTER1" => (
        "GUADALUPE_ENERGY_CENTER1_CC1",
        "GUADALUPE_ENERGY_CENTER1_CC3",
        "GUADALUPE_ENERGY_CENTER1_CC4",
    ),
    "GUADALUPE_ENERGY_CENTER2" => (
        "GUADALUPE_ENERGY_CENTER2_CC1",
        "GUADALUPE_ENERGY_CENTER2_CC2",
        "GUADALUPE_ENERGY_CENTER2_CC4",
    ),
    "RIO_NOGALES_POWER" => (
        "RIO_NOGALES_POWER_CC1",
        "RIO_NOGALES_POWER_CC2",
        "RIO_NOGALES_POWER_CC3",
        "RIO_NOGALES_POWER_CC4",
    ),
    "ARTHUR_VON_ROSENBERG" => ("ARTHUR_VON_ROSENBERG_CC1", "ARTHUR_VON_ROSENBERG_CC2"),
    "SANDHILL_ENERGY_CENTER" => (
        "SANDHILL_ENERGY_CENTER_CC1",
        "SANDHILL_ENERGY_CENTER_CC2",
        "SANDHILL_ENERGY_CENTER_CC3",
    ),
    "BASTROP_ENERGY_CENTER" => (
        "BASTROP_ENERGY_CENTER_CC1",
        "BASTROP_ENERGY_CENTER_CC2",
        "BASTROP_ENERGY_CENTER_CC3",
    ),
    "CHANNEL_ENERGY_CENTER1" =>
        ("CHANNEL_ENERGY_CENTER1_CC1", "CHANNEL_ENERGY_CENTER1_CC2"),
    "CHANNEL_ENERGY_CENTER2" => (
        "CHANNEL_ENERGY_CENTER2_CC1",
        "CHANNEL_ENERGY_CENTER2_CC3",
        "CHANNEL_ENERGY_CENTER2_CC4",
    ),
    "SAM_RAYBURN" => ("SAM_RAYBURN_CC1", "SAM_RAYBURN_CC2", "SAM_RAYBURN_CC3"),
    "VICTORIA_POWER1" => ("VICTORIA_POWER1_CC1",),
    "VICTORIA_POWER1" => ("VICTORIA_POWER2_CC1",),
    "BAYTOWN_ENERGY1" => ("BAYTOWN_ENERGY1_CC1", "BAYTOWN_ENERGY1_CC2"),
    "BAYTOWN_ENERGY2" => ("BAYTOWN_ENERGY2_CC1", "BAYTOWN_ENERGY2_CC2"),
    "DEER_PARK_ENERGY_CENTER" => (
        "DEER_PARK_ENERGY_CENTER_CC1",
        "DEER_PARK_ENERGY_CENTER_CC2",
        "DEER_PARK_ENERGY_CENTER_CC4",
        "DEER_PARK_ENERGY_CENTER_CC5",
        "DEER_PARK_ENERGY_CENTER_CC6",
    ),
    "TH_WARTON1" => (
        "TH_WARTON1_CC2",
        "TH_WARTON1_CC3",
        "TH_WARTON1_CC4",
        "TH_WARTON1_CC7",
        "TH_WARTON1_CC8",
    ),
    "TH_WARTON2" =>
        ("TH_WARTON2_CC2", "TH_WARTON2_CC4", "TH_WARTON2_CC7", "TH_WARTON2_CC8"),
    "CEDAR_BAYOU" => ("CEDAR_BAYOU_CC1", "CEDAR_BAYOU_CC2", "CEDAR_BAYOU_CC4"),
    "TEXAS_CITY_POWER" => (
        "TEXAS_CITY_POWER_CC9",
        "TEXAS_CITY_POWER_CC1",
        "TEXAS_CITY_POWER_CC3",
        "TEXAS_CITY_POWER_CC6",
        "TEXAS_CITY_POWER_CC7",
    ),
    "COLORADO_BEND_ENERGY_CENTER_1" => ("COLORADO_BEND_ENERGY_CENTER_1_CC2",),
    "COLORADO_BEND_ENERGY_CENTER_2" =>
        ("COLORADO_BEND_ENERGY_CENTER_2_CC1", "COLORADO_BEND_ENERGY_CENTER_2_CC2"),
    "COLORADO_BEND_ENERGY_CENTER_3" =>
        ("COLORADO_BEND_ENERGY_CENTER_3_CC1", "COLORADO_BEND_ENERGY_CENTER_3_CC2"),
    "PASADENA_COGENERATION" =>
        ("PASADENA_COGENERATION_CC1", "PASADENA_COGENERATION_CC2"),
    "BRAZOS_VALLEY" => (
        "BRAZOS_VALLEY_CC1",
        "BRAZOS_VALLEY_CC2",
        "BRAZOS_VALLEY_CC3",
        "BRAZOS_VALLEY_CC4",
    ),
    "POWER_SYSTEMS_ARCO_COGEN1" =>
        ("POWER_SYSTEMS_ARCO_COGEN1_CC1", "POWER_SYSTEMS_ARCO_COGEN1_CC2"),
    "POWER_SYSTEMS_ARCO_COGEN2" =>
        ("POWER_SYSTEMS_ARCO_COGEN2_CC1", "POWER_SYSTEMS_ARCO_COGEN2_CC2"),
    "POWER_SYSTEMS_ARCO_COGEN3" =>
        ("POWER_SYSTEMS_ARCO_COGEN3_CC1", "POWER_SYSTEMS_ARCO_COGEN3_CC2"),
    "CHANNELVIEW_COGENERATION_PLANT" => (
        "CHANNELVIEW_COGENERATION_PLANT_CC1",
        "CHANNELVIEW_COGENERATION_PLANT_CC2",
        "CHANNELVIEW_COGENERATION_PLANT_CC5",
        "CHANNELVIEW_COGENERATION_PLANT_CC6",
    ),
    "GREENS_BAYOU" => ("GREENS_BAYOU_CC2", "GREENS_BAYOU_CC3"),
    "TENASKA_FRONTIER_STATION" => (
        "TENASKA_FRONTIER_STATION_CC1",
        "TENASKA_FRONTIER_STATION_CC4",
        "TENASKA_FRONTIER_STATION_CC9",
        "TENASKA_FRONTIER_STATION_CC12",
    ),
    "FREESTONE_ENERGY_CENTER1" => (
        "FREESTONE_ENERGY_CENTER1_CC1",
        "FREESTONE_ENERGY_CENTER1_CC2",
        "FREESTONE_ENERGY_CENTER1_CC3",
    ),
    "FREESTONE_ENERGY_CENTER2" => (
        "FREESTONE_ENERGY_CENTER2_CC1",
        "FREESTONE_ENERGY_CENTER2_CC2",
        "FREESTONE_ENERGY_CENTER2_CC3",
    ),
    "TENASKA_GATEWAY_STATION" => (
        "TENASKA_GATEWAY_STATION_CC1",
        "TENASKA_GATEWAY_STATION_CC2",
        "TENASKA_GATEWAY_STATION_CC3",
        "TENASKA_GATEWAY_STATION_CC4",
    ),
)
