include("file_pointers.jl")
include("system_build_functions.jl")
include("manual_data_entries.jl")

plant_metadata = CSV.read(thermal_mapping, DataFrame)
sys = System("intermediate_sys.json")

set_units_base_system!(sys, "NATURAL_UNITS")

gen = get_component(ThermalStandard, sys, "gen-13")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-14")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-15")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-16")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-17")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-18")
sced_data = get_sced_data(thermal_sced_h5_file, "PB2SES_CT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PERMIAN BASIN CTG 6",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-26")
sced_data = get_sced_data(thermal_sced_h5_file, "OECCS_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ODESSA_ECTOR POWER1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-27")
sced_data = get_sced_data(thermal_sced_h5_file, "OECCS_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ODESSA_ECTOR POWER1 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-28")
sced_data = get_sced_data(thermal_sced_h5_file, "OECCS_CC2_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ODESSA_ECTOR POWER2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-29")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY1 CC1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-30")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-31")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC2_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-32")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-33")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC1_4")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW6"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY1 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-34")
sced_data = get_sced_data(thermal_sced_h5_file, "QALSW_CC2_4")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW7"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[.&(sced_data.LSL .> 1, sced_data.Submitted_TPO_MW1 .> 1), :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "QUAIL RUN ENERGY2 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-35")
sced_data = get_sced_data(thermal_sced_h5_file, "OECCS_CC2_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ODESSA_ECTOR POWER2 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-41")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SAVOY STATION ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-42")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SAVOY STATION ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-43")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SAVOY STATION ST3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-46")
sced_data = get_sced_data(thermal_sced_h5_file, "TNSKA_CC1_1")
HSL = median(sced_data[sced_data.HSL .> 1, :][!, "LSL"])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "PARIS ENERGY CENTER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-47")
sced_data = get_sced_data(thermal_sced_h5_file, "TNSKA_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PARIS ENERGY CENTER CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-50")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "WICHITA STATION ST1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-56")
sced_data = get_sced_data(thermal_sced_h5_file, "WFCOGEN_CC1_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = 20.0
new_thermal = make_thermal_gen(
    gen;
    name = "WICHITA FALLS COGEN CC6",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-57")
sced_data = get_sced_data(thermal_sced_h5_file, "WFCOGEN_CC1_8")
HSL = maximum(sced_data[!, "HSL"])
LSL = 20.0
new_thermal = make_thermal_gen(
    gen;
    name = "WICHITA FALLS COGEN CC8",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-58")
sced_data = get_sced_data(thermal_sced_h5_file, "WFCOGEN_CC1_9")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WICHITA FALLS COGEN CC9",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-64")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_S_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA SHERMAN CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-65")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_S_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA SHERMAN CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-66")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_S_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA SHERMAN CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-67")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-68")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-69")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER1 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-70")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-71")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-72")
sced_data = get_sced_data(thermal_sced_h5_file, "LPCCS_CC2_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAMAR ENERGY CENTER2 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-81")
sced_data = get_sced_data(thermal_sced_h5_file, "MGSES_CT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MORGAN CREEK CTG 4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-82")
sced_data = get_sced_data(thermal_sced_h5_file, "MGSES_CT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MORGAN CREEK CTG 5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

# Cost function way off
gen = get_component(ThermalStandard, sys, "gen-83")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "MORGAN CREEK CTG 6 Expanded",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-115")
sced_data = get_sced_data(thermal_sced_h5_file, "MGSES_CT1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW6"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SNYDER CREEK CTG 1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-116")
sced_data = get_sced_data(thermal_sced_h5_file, "MGSES_CT1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW6"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SNYDER CREEK CTG 2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-117")
sced_data = get_sced_data(thermal_sced_h5_file, "MGSES_CT3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SNYDER CREEK CTG 3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-121")
sced_data = get_sced_data(thermal_sced_h5_file, "SANMIGL_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAN MIGUEL U1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-122")
sced_data = get_sced_data(thermal_sced_h5_file, "COLETO_COLETOG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLETO CREEK",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-127")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "KINGSVILLE GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

# TODO: Check the distribution of the power
gen = get_component(ThermalStandard, sys, "gen-128")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_2");
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-129")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_2");
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-130")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_2");
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-131")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_4");
HSL = maximum(sced_data[!, "HSL"])
LSL = 200
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-132")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_4");
HSL = maximum(sced_data[!, "HSL"])
LSL = 200
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC5",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-133")
sced_data = get_sced_data(thermal_sced_h5_file, "INGLCOSW_CC1_4");
HSL = maximum(sced_data[!, "HSL"])
LSL = 200
new_thermal = make_thermal_gen(
    gen;
    name = "INGLESIDE CC6",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-135")
sced_data = get_sced_data(thermal_sced_h5_file, "DUKE_CC1_1");
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HIDALGO ENERGY CENTER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-136")
sced_data = get_sced_data(thermal_sced_h5_file, "DUKE_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HIDALGO ENERGY CENTER CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-137")
sced_data = get_sced_data(thermal_sced_h5_file, "DUKE_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HIDALGO ENERGY CENTER CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-138")
sced_data = get_sced_data(thermal_sced_h5_file, "B_DAVIS_B_DAVIG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "B M DAVIS STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-139")
sced_data = get_sced_data(thermal_sced_h5_file, "B_DAVIS_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "BARNEY DAVIS CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-140")
sced_data = get_sced_data(thermal_sced_h5_file, "B_DAVIS_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "BARNEY DAVIS CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-141")
sced_data = get_sced_data(thermal_sced_h5_file, "B_DAVIS_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BARNEY DAVIS CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-148")
sced_data = get_sced_data(thermal_sced_h5_file, "CTL_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "CAPITOL GEN CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-149")
sced_data = get_sced_data(thermal_sced_h5_file, "CTL_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CAPITOL GEN CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-150")
sced_data = get_sced_data(thermal_sced_h5_file, "CTL_CC1_8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CAPITOL GEN CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-152")
sced_data = get_sced_data(thermal_sced_h5_file, "LARDVFTN_G4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAREDO CTG 4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-153")
sced_data = get_sced_data(thermal_sced_h5_file, "LARDVFTN_G5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LAREDO CTG 5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-154")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-155")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-156")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-157")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST5",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-158")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST6",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-159")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "PEARSALL ST7",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-162")
sced_data = get_sced_data(thermal_sced_h5_file, "CCEC_CC1_2")
HSL = 200.0
LSL = 50.0
new_thermal = make_thermal_gen(
    gen;
    name = "CORPUS CHRISTI CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-163")
sced_data = get_sced_data(thermal_sced_h5_file, "CCEC_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CORPUS CHRISTI CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-164")
sced_data = get_sced_data(thermal_sced_h5_file, "NUECES_B_CC1_1")
HSL = 350
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "NUECES BAY REPOWER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-165")
sced_data = get_sced_data(thermal_sced_h5_file, "NUECES_B_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "NUECES BAY REPOWER CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-170")
sced_data = get_sced_data(thermal_sced_h5_file, "SILASRAY_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-171")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-173")
sced_data = get_sced_data(thermal_sced_h5_file, "SILASRAY_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-175")
sced_data = get_sced_data(thermal_sced_h5_file, "NEDIN_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MAGIC VALLEY STATION CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-176")
sced_data = get_sced_data(thermal_sced_h5_file, "NEDIN_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MAGIC VALLEY STATION CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-177")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-178")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY ST3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-179")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SILAS RAY ST4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-186")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC1_4")
HSL = 650
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-187")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC1_4")
HSL = 650
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-188")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC1_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER1 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-189")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC2_4")
HSL = 650
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-190")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC2_4")
HSL = 650
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-191")
sced_data = get_sced_data(thermal_sced_h5_file, "FRNYPP_CC2_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FORNEY ENERGY CENTER2 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-192")
sced_data = get_sced_data(thermal_sced_h5_file, "STEAM_STEAM_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "POWERLANE PLANT STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-197")
sced_data = get_sced_data(thermal_sced_h5_file, "HLSES_UNIT3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HANDLEY STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-198")
sced_data = get_sced_data(thermal_sced_h5_file, "HLSES_UNIT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HANDLEY STG U4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-199")
sced_data = get_sced_data(thermal_sced_h5_file, "HLSES_UNIT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HANDLEY STG U5",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-203")
sced_data = get_sced_data(thermal_sced_h5_file, "SPNCER_SPNCE_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SPENCER STG U4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-204")
sced_data = get_sced_data(thermal_sced_h5_file, "SPNCER_SPNCE_5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SPENCER STG U5",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-207")
sced_data = get_sced_data(thermal_sced_h5_file, "WCPP_CC1_3")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WISE_TRACTEBEL POWER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-208")
sced_data = get_sced_data(thermal_sced_h5_file, "WCPP_CC1_3")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WISE_TRACTEBEL POWER CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-209")
sced_data = get_sced_data(thermal_sced_h5_file, "WCPP_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WISE_TRACTEBEL POWER CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-214")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_T1_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA TEMPLE I CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-215")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_T1_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA TEMPLE I CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-216")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_T1_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA TEMPLE I CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-218")
sced_data = get_sced_data(thermal_sced_h5_file, "OLINGR_OLING_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RAY OLINGER STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-219")
sced_data = get_sced_data(thermal_sced_h5_file, "OLINGR_OLING_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RAY OLINGER STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-220")
sced_data = get_sced_data(thermal_sced_h5_file, "OLINGR_OLING_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RAY OLINGER STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-221")
sced_data = get_sced_data(thermal_sced_h5_file, "OLINGR_OLING_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RAY OLINGER STG U4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-222")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_T2_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA TEMPLE II CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-223")
sced_data = get_sced_data(thermal_sced_h5_file, "PANDA_T2_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PANDA TEMPLE II CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-224")
sced_data = get_sced_data(thermal_sced_h5_file, "WHCCS_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW7"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WOLF HOLLOW 1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-225")
sced_data = get_sced_data(thermal_sced_h5_file, "WHCCS_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WOLF HOLLOW 1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-226")
sced_data = get_sced_data(thermal_sced_h5_file, "WHCCS2_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WOLF HOLLOW 2 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)


gen = get_component(ThermalStandard, sys, "gen-227")
sced_data = get_sced_data(thermal_sced_h5_file, "MCSES_UNIT7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MOUNTAIN CREEK STG U6",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-228")
sced_data = get_sced_data(thermal_sced_h5_file, "MCSES_UNIT7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MOUNTAIN CREEK STG U7",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-229")
sced_data = get_sced_data(thermal_sced_h5_file, "MCSES_UNIT8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MOUNTAIN CREEK STG U8",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

# Joint Assets in the same bus.
gen = get_component(ThermalStandard, sys, "gen-232")
sced_data = get_sced_data(thermal_sced_h5_file, "SCES_UNIT1_J01")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDY CREEK J01",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])

gen = get_component(ThermalStandard, sys, "gen-232")
sced_data = get_sced_data(thermal_sced_h5_file, "SCES_UNIT1_J02")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDY CREEK J02",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])

gen = get_component(ThermalStandard, sys, "gen-232")
sced_data = get_sced_data(thermal_sced_h5_file, "SCES_UNIT1_J03")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDY CREEK J03",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])

gen = get_component(ThermalStandard, sys, "gen-232")
sced_data = get_sced_data(thermal_sced_h5_file, "SCES_UNIT1_J04")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDY CREEK J04",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)

remove_component!(sys, gen)
### End of joint assets

gen = get_component(ThermalStandard, sys, "gen-234")
sced_data = get_sced_data(thermal_sced_h5_file, "JACKCNTY_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-235")
sced_data = get_sced_data(thermal_sced_h5_file, "JACKCNTY_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-236")
sced_data = get_sced_data(thermal_sced_h5_file, "JACKCNTY_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 1 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-237")
sced_data = get_sced_data(thermal_sced_h5_file, "JCKCNTY2_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-238")
sced_data = get_sced_data(thermal_sced_h5_file, "JCKCNTY2_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-239")
sced_data = get_sced_data(thermal_sced_h5_file, "JCKCNTY2_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JACK COUNTY GEN FACILITY 2 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-240")
sced_data = get_sced_data(thermal_sced_h5_file, "ETCCS_CC1_2")
HSL = 300
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ENNIS POWER STATION CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-241")
sced_data = get_sced_data(thermal_sced_h5_file, "ETCCS_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW10"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = 300
new_thermal = make_thermal_gen(
    gen;
    name = "ENNIS POWER STATION CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-243")
sced_data = get_sced_data(thermal_sced_h5_file, "DCSES_CT10")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECORDOVA SES 1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)


gen = get_component(ThermalStandard, sys, "gen-244")
sced_data = get_sced_data(thermal_sced_h5_file, "DCSES_CT20")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECORDOVA SES 2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-245")
sced_data = get_sced_data(thermal_sced_h5_file, "DCSES_CT30")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECORDOVA SES 3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-246")
sced_data = get_sced_data(thermal_sced_h5_file, "DCSES_CT40")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECORDOVA SES 4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-247")
sced_data = get_sced_data(thermal_sced_h5_file, "MIL_MILLERG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RW MILLER STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-248")
sced_data = get_sced_data(thermal_sced_h5_file, "MIL_MILLERG2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RW MILLER STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-249")
sced_data = get_sced_data(thermal_sced_h5_file, "MIL_MILLERG3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RW MILLER STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-250")
sced_data = get_sced_data(thermal_sced_h5_file, "MIL_MILLERG4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RW MILLER STG U4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-251")
sced_data = get_sced_data(thermal_sced_h5_file, "MIL_MILLERG5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RW MILLER STG U5",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-254")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-255")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-256")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-257")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-258")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-259")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT6",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-260")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT7",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-261")
sced_data = get_sced_data(thermal_sced_h5_file, "MDANP_CT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MIDLOTHIAN ENERGY FACILITY GT8",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-262")
sced_data = get_sced_data(thermal_sced_h5_file, "LOSTPI_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW2"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LOST PINES POWER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-263")
sced_data = get_sced_data(thermal_sced_h5_file, "LOSTPI_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LOST PINES POWER CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-264")
sced_data = get_sced_data(thermal_sced_h5_file, "GIDEON_GIDEONG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM GIDEON STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-265")
sced_data = get_sced_data(thermal_sced_h5_file, "GIDEON_GIDEONG2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM GIDEON STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-266")
sced_data = get_sced_data(thermal_sced_h5_file, "GIDEON_GIDEONG3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM GIDEON STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-272")
sced_data = get_sced_data(thermal_sced_h5_file, "LEON_CRK_LCPCT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LEON CREEK PEAKER CTG 1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-273")
sced_data = get_sced_data(thermal_sced_h5_file, "LEON_CRK_LCPCT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LEON CREEK PEAKER CTG 2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-274")
sced_data = get_sced_data(thermal_sced_h5_file, "LEON_CRK_LCPCT3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LEON CREEK PEAKER CTG 3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-275")
sced_data = get_sced_data(thermal_sced_h5_file, "LEON_CRK_LCPCT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LEON CREEK PEAKER CTG 4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-276")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC1_4")
HSL = 375
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-277")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC1_4")
HSL = 375
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER1 CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-278")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = 400
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER1 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-279")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC2_4")
HSL = 375
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER2 CC1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-280")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC2_4")
HSL = 375
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-281")
sced_data = get_sced_data(thermal_sced_h5_file, "GUADG_CC2_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = 400
new_thermal = make_thermal_gen(
    gen;
    name = "GUADALUPE ENERGY CENTER2 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

## Shared ownership of the assets
gen = get_component(ThermalStandard, sys, "gen-282")
sced_data = get_sced_data(thermal_sced_h5_file, "FPPYD1_FPP_G1_J01")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FAYETTE POWER U1 J1",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-282")
sced_data = get_sced_data(thermal_sced_h5_file, "FPPYD1_FPP_G1_J02")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FAYETTE POWER U1 J2",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)
remove_component!(sys, gen)

gen = get_component(ThermalStandard, sys, "gen-283")
sced_data = get_sced_data(thermal_sced_h5_file, "FPPYD1_FPP_G2_J01")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FAYETTE POWER U2 J1",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-283")
sced_data = get_sced_data(thermal_sced_h5_file, "FPPYD1_FPP_G2_J02")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FAYETTE POWER U2 J2",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
add_component!(sys, new_thermal)
remove_component!(sys, gen)
## end of Shared ownership of the assets

gen = get_component(ThermalStandard, sys, "gen-284")
sced_data = get_sced_data(thermal_sced_h5_file, "FPPYD2_FPP_G3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FAYETTE POWER U3",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-293")
sced_data = get_sced_data(thermal_sced_h5_file, "WIPOPA_WPP_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WINCHESTER POWER PARK CTG1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-294")
sced_data = get_sced_data(thermal_sced_h5_file, "WIPOPA_WPP_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WINCHESTER POWER PARK CTG2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-295")
sced_data = get_sced_data(thermal_sced_h5_file, "WIPOPA_WPP_G3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WINCHESTER POWER PARK CTG3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-296")
sced_data = get_sced_data(thermal_sced_h5_file, "SDSES_UNIT4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDOW U4",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-297")
sced_data = get_sced_data(thermal_sced_h5_file, "SD5SES_UNIT5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDOW U5",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-299")
sced_data = get_sced_data(thermal_sced_h5_file, "CALAVERS_OWS1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "OW SOMMERS STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-300")
sced_data = get_sced_data(thermal_sced_h5_file, "CALAVERS_OWS2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "OW SOMMERS STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-301")
sced_data = get_sced_data(thermal_sced_h5_file, "CALAVERS_JTD1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JT DEELY U1",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-302")
sced_data = get_sced_data(thermal_sced_h5_file, "CALAVERS_JTD2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JT DEELY U2",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-303")
sced_data = get_sced_data(thermal_sced_h5_file, "CALAVERS_JKS1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "JK SPRUCE U1",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-304")
sced_data = get_sced_data(thermal_sced_h5_file, "RIONOG_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RIO NOGALES POWER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-305")
sced_data = get_sced_data(thermal_sced_h5_file, "RIONOG_CC1_5")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RIO NOGALES POWER CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-306")
sced_data = get_sced_data(thermal_sced_h5_file, "RIONOG_CC1_5")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RIO NOGALES POWER CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-307")
sced_data = get_sced_data(thermal_sced_h5_file, "RIONOG_CC1_6")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "RIO NOGALES POWER CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-312")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB6CT6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG TTG U1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-313")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB6CT7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG TTG U2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-314")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB6CT8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG TTG U3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-315")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ARTHUR VON ROSENBERG CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-316")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ARTHUR VON ROSENBERG CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-317")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-318")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-319")
sced_data = get_sced_data(thermal_sced_h5_file, "BRAUNIG_VHB3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VH BRAUNIG STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-320")
sced_data = get_sced_data(thermal_sced_h5_file, "SANDHSYD_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDHILL ENERGY CENTER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-321")
sced_data = get_sced_data(thermal_sced_h5_file, "SANDHSYD_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDHILL ENERGY CENTER CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-322")
sced_data = get_sced_data(thermal_sced_h5_file, "SANDHSYD_SH6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDHILL ENERGY CENTER GT",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-323")
sced_data = get_sced_data(thermal_sced_h5_file, "SANDHSYD_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SANDHILL ENERGY CENTER CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-333")
sced_data = get_sced_data(thermal_sced_h5_file, "BASTEN_CC1_1")
HSL = 400
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BASTROP ENERGY CENTER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-334")
sced_data = get_sced_data(thermal_sced_h5_file, "BASTEN_CC1_1")
HSL = 400
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BASTROP ENERGY CENTER CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-335")
sced_data = get_sced_data(thermal_sced_h5_file, "BASTEN_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BASTROP ENERGY CENTER CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-337")
sced_data = get_sced_data(thermal_sced_h5_file, "HAYSEN_HAYSENG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HAYS ENERGY FACILITY GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-338")
sced_data = get_sced_data(thermal_sced_h5_file, "HAYSEN_HAYSENG2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HAYS ENERGY FACILITY GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-339")
sced_data = get_sced_data(thermal_sced_h5_file, "HAYSEN_HAYSENG3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HAYS ENERGY FACILITY GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-340")
sced_data = get_sced_data(thermal_sced_h5_file, "HAYSEN_HAYSENG4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "HAYS ENERGY FACILITY GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-341")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPGT_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-342")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPGT_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-343")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPGT_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-349")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-350")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPG2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-351")
sced_data = get_sced_data(thermal_sced_h5_file, "DECKER_DPGT_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DECKER CREEK GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-352")
sced_data = get_sced_data(thermal_sced_h5_file, "CHE_CC1_5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CHANNEL ENERGY CENTER1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-353")
sced_data = get_sced_data(thermal_sced_h5_file, "CHE_CC1_7")
HSL = maximum(sced_data[!, "HSL"])
LSL = 250
new_thermal = make_thermal_gen(
    gen;
    name = "CHANNEL ENERGY CENTER1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-354")
sced_data = get_sced_data(thermal_sced_h5_file, "CHE_CC1_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CHANNEL ENERGY CENTER2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-355")
sced_data = get_sced_data(thermal_sced_h5_file, "CHE_CC1_8")
HSL = maximum(sced_data[!, "HSL"])
LSL = 250
new_thermal = make_thermal_gen(
    gen;
    name = "CHANNEL ENERGY CENTER2 CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-356")
sced_data = get_sced_data(thermal_sced_h5_file, "CHE_CC1_9")
HSL = maximum(sced_data[!, "HSL"])
LSL = 500
new_thermal = make_thermal_gen(
    gen;
    name = "CHANNEL ENERGY CENTER2 CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-358")
sced_data = get_sced_data(thermal_sced_h5_file, "RAYBURN_RAYBURG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM RAYBURN GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-359")
sced_data = get_sced_data(thermal_sced_h5_file, "RAYBURN_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW4"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM RAYBURN CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-360")
sced_data = get_sced_data(thermal_sced_h5_file, "RAYBURN_CC1_2")
HSL = 125
LSL = 75
new_thermal = make_thermal_gen(
    gen;
    name = "SAM RAYBURN CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-361")
sced_data = get_sced_data(thermal_sced_h5_file, "RAYBURN_CC1_3")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW4"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[.&(sced_data.LSL .> 1, sced_data.Submitted_TPO_MW1 .> 1), :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "SAM RAYBURN CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-367")
sced_data = get_sced_data(thermal_sced_h5_file, "VICTORIA_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VICTORIA POWER1 CC1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-368")
sced_data = get_sced_data(thermal_sced_h5_file, "VICTORIA_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "VICTORIA POWER2 CC1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-369")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-370")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-371")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-372")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-373")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-374")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FORMOSA GT6",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-375")
sced_data = get_sced_data(thermal_sced_h5_file, "BTE_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BAYTOWN ENERGY1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-376")
sced_data = get_sced_data(thermal_sced_h5_file, "BTE_CC1_4")
HSL = 200
LSL = 50
new_thermal = make_thermal_gen(
    gen;
    name = "BAYTOWN ENERGY1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-377")
sced_data = get_sced_data(thermal_sced_h5_file, "BTE_CC1_4")
HSL = 200
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BAYTOWN ENERGY2 CC1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-378")
sced_data = get_sced_data(thermal_sced_h5_file, "BTE_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = 200
new_thermal = make_thermal_gen(
    gen;
    name = "BAYTOWN ENERGY2 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-381")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SHELL U1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-382")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SHELL U2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-383")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SHELL U3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-384")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_2")
HSL = 420
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-385")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = 500
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-386")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_3")
HSL = 500
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-387")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = 620
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-388")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_4")
HSL = 600
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC5",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
new_thermal.internal = PSY.IS.InfrastructureSystemsInternal()
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-389")
sced_data = get_sced_data(thermal_sced_h5_file, "DDPEC_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = 620
new_thermal = make_thermal_gen(
    gen;
    name = "Deer Park Energy Center CC6",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-393")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SR BERTRON GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-394")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SR BERTRON GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-395")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SR BERTRON GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-396")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SR BERTRON GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-397")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "SR BERTRON ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-398")
sced_data = get_sced_data(thermal_sced_h5_file, "AZ_AZ_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "EXTEX LAPORTE GEN STN CTG1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-399")
sced_data = get_sced_data(thermal_sced_h5_file, "AZ_AZ_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "EXTEX LAPORTE GEN STN CTG2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-400")
sced_data = get_sced_data(thermal_sced_h5_file, "AZ_AZ_G3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "EXTEX LAPORTE GEN STN CTG3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-401")
sced_data = get_sced_data(thermal_sced_h5_file, "AZ_AZ_G4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "EXTEX LAPORTE GEN STN CTG4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-403")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON1 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-404")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON1 CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-405")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON1 CC4",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-406")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC1_7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON1 CC7",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-407")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC1_8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON1 CC8",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-408")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC2_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON2 CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-409")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC2_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON2 CC4",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-410")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC2_7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON2 CC7",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-411")
sced_data = get_sced_data(thermal_sced_h5_file, "THW_CC2_8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TH WARTON2 CC8",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-417")
sced_data = get_sced_data(thermal_sced_h5_file, "FEGC_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FRIENDSWOOD GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-418")
sced_data = get_sced_data(thermal_sced_h5_file, "FEGC_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FRIENDSWOOD GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-419")
sced_data = get_sced_data(thermal_sced_h5_file, "FEGC_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FRIENDSWOOD GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-420")
sced_data = get_sced_data(thermal_sced_h5_file, "FEGC_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FRIENDSWOOD GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-422")
sced_data = get_sced_data(thermal_sced_h5_file, "CBY_CBY_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CEDAR BAYOU ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-423")
sced_data = get_sced_data(thermal_sced_h5_file, "CBY_CBY_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CEDAR BAYOU ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-424")
sced_data = get_sced_data(thermal_sced_h5_file, "CBY4_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "CEDAR BAYOU CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-425")
sced_data = get_sced_data(thermal_sced_h5_file, "CBY4_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "CEDAR BAYOU CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-426")
sced_data = get_sced_data(thermal_sced_h5_file, "CBY4_CC1_4")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW9"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "CEDAR BAYOU CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-427")
sced_data = get_sced_data(thermal_sced_h5_file, "TXCTY_CC1_9")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS CITY POWER CC9",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-428")
sced_data = get_sced_data(thermal_sced_h5_file, "TXCTY_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS CITY POWER CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-429")
sced_data = get_sced_data(thermal_sced_h5_file, "TXCTY_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS CITY POWER CC3",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-430")
sced_data = get_sced_data(thermal_sced_h5_file, "TXCTY_CC1_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS CITY POWER CC6",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-431")
sced_data = get_sced_data(thermal_sced_h5_file, "TXCTY_CC1_7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS CITY POWER CC7",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-440")
sced_data = get_sced_data(thermal_sced_h5_file, "CBEC_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW5"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLORADO BEND ENERGY CENTER 1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-441")
sced_data = get_sced_data(thermal_sced_h5_file, "CBEC_CC2_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW4"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLORADO BEND ENERGY CENTER 2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-442")
sced_data = get_sced_data(thermal_sced_h5_file, "CBEC_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLORADO BEND ENERGY CENTER 2 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-443")
sced_data = get_sced_data(thermal_sced_h5_file, "CBECII_CC3_1")
HSL = 600
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLORADO BEND ENERGY CENTER 3 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-444")
sced_data = get_sced_data(thermal_sced_h5_file, "CBECII_CC3_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "COLORADO BEND ENERGY CENTER 3 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-445")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FREEPORT LNG GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-446")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FREEPORT LNG GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-447")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FREEPORT LNG GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-448")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "FREEPORT LNG GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-449")
sced_data = get_sced_data(thermal_sced_h5_file, "TGF_TGFGT_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TEXAS GULF SULPHUR",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-450")
sced_data = get_sced_data(thermal_sced_h5_file, "PSG_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PASADENA COGENERATION CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-451")
sced_data = get_sced_data(thermal_sced_h5_file, "PSG_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "PASADENA COGENERATION CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-452")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-453")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-454")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U3",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-455")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U4",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-456")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U5",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-457")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U6",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-458")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U7",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-459")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAP_G8")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH STG U8",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-460")
sced_data = get_sced_data(thermal_sced_h5_file, "WAP_WAPGT_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "WA PARISH CTG 1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-461")
sced_data = get_sced_data(thermal_sced_h5_file, "BVE_CC1_1")
HSL = 160
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BRAZOS VALLEY CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-462")
sced_data = get_sced_data(thermal_sced_h5_file, "BVE_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW6"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = 220
new_thermal = make_thermal_gen(
    gen;
    name = "BRAZOS VALLEY CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-463")
sced_data = get_sced_data(thermal_sced_h5_file, "BVE_CC1_2")
HSL = 375
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BRAZOS VALLEY CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-464")
sced_data = get_sced_data(thermal_sced_h5_file, "BVE_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = 425
new_thermal = make_thermal_gen(
    gen;
    name = "BRAZOS VALLEY CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-465")
sced_data = get_sced_data(thermal_sced_h5_file, "LHM_CVC_G4")
HSL = maximum(sced_data[!, "HSL"])
LSL = 50.0
new_thermal = make_thermal_gen(
    gen;
    name = "CVC CHANNELVIEW GT1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-466")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = 425
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-467")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-468")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-469")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen2 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-470")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen3 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-471")
sced_data = get_sced_data(thermal_sced_h5_file, "PSA_CC1_4")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Power Systems Arco Cogen3 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-472")
sced_data = get_sced_data(thermal_sced_h5_file, "CVC_CC1_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Channelview Cogeneration Plant CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-473")
sced_data = get_sced_data(thermal_sced_h5_file, "CVC_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Channelview Cogeneration Plant CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-474")
sced_data = get_sced_data(thermal_sced_h5_file, "CVC_CC1_5")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Channelview Cogeneration Plant CC5",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-475")
sced_data = get_sced_data(thermal_sced_h5_file, "CVC_CC1_6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "Channelview Cogeneration Plant CC6",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-477")
sced_data = get_sced_data(thermal_sced_h5_file, "GBY_GBYGT81")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-478")
sced_data = get_sced_data(thermal_sced_h5_file, "GBY_GBYGT82")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-479")
sced_data = get_sced_data(thermal_sced_h5_file, "GBY_GBYGT83")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-480")
sced_data = get_sced_data(thermal_sced_h5_file, "GBY_GBYGT84")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU GT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-481")
sced_data = get_sced_data(thermal_sced_h5_file, "BYU_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-482")
sced_data = get_sced_data(thermal_sced_h5_file, "BYU_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "GREENS BAYOU CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-483")
sced_data = get_sced_data(thermal_sced_h5_file, "CALHOUN_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CALHOUN PORT COMFORT CTG1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-484")
sced_data = get_sced_data(thermal_sced_h5_file, "CALHOUN_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "CALHOUN PORT COMFORT CTG2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-485")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "VICTORIA GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-486")
sced_data = get_sced_data(thermal_sced_h5_file, "SJS_SJS_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAN JACINTO SES GT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-487")
sced_data = get_sced_data(thermal_sced_h5_file, "SJS_SJS_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "SAN JACINTO SES GT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

# AMOCO Units operate as self scheduled.
gen = get_component(ThermalStandard, sys, "gen-489")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT1",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-490")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-491")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-492")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-493")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT5",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-494")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT6",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-495")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT7",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-496")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT8",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")

gen = get_component(ThermalStandard, sys, "gen-497")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT9",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-498")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "AMOCO UNIT10",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

# DOWGEN is self scheduling
gen = get_component(ThermalStandard, sys, "gen-499")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT1",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-500")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT2",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-501")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-502")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT4",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-503")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT5",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-504")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT6",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-505")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT7",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-506")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT8",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-507")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT9",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-508")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT10",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-509")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen(
    gen;
    name = "DOWGEN UNIT11",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
)
set_must_run!(new_thermal, true)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-511")
sced_data = get_sced_data(thermal_sced_h5_file, "FTR_CC1_1")
HSL = 250
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA FRONTIER STATION CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-512")
sced_data = get_sced_data(thermal_sced_h5_file, "FTR_CC1_4")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW8"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA FRONTIER STATION CC4",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-513")
sced_data = get_sced_data(thermal_sced_h5_file, "FTR_CC1_9")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA FRONTIER STATION CC9",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-514")
sced_data = get_sced_data(thermal_sced_h5_file, "FTR_CC1_12")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA FRONTIER STATION CC12",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-515")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC1_1")
HSL = 175
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER1 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-516")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW2"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = 225
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER1 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-517")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC1_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = 450
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER1 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)


gen = get_component(ThermalStandard, sys, "gen-518")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC2_1")
HSL = 180
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER2 CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-519")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW2"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = 225
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER2 CC2",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-520")
sced_data = get_sced_data(thermal_sced_h5_file, "FREC_CC2_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = 450
new_thermal = make_thermal_gen(
    gen;
    name = "FREESTONE ENERGY CENTER2 CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-521")
sced_data = get_sced_data(thermal_sced_h5_file, "BBSES_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BIG BROWN U1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-522")
sced_data = get_sced_data(thermal_sced_h5_file, "BBSES_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "BIG BROWN U2",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-523")
sced_data = get_sced_data(thermal_sced_h5_file, "LEG_LEG_G1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LIMESTONE U1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-524")
sced_data = get_sced_data(thermal_sced_h5_file, "LEG_LEG_G2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "LIMESTONE U2",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-525")
sced_data = get_sced_data(thermal_sced_h5_file, "TGCCS_CC1_1")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW4"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL_ = sced_data[sced_data.LSL .> 1, :][!, "Submitted_TPO_MW1"]
LSL = median(LSL_[.!isnan.(LSL_)])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA GATEWAY STATION CC1",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-526")
sced_data = get_sced_data(thermal_sced_h5_file, "TGCCS_CC1_2")
HSL_ = sced_data[sced_data.HSL .> 1, :][!, "Submitted_TPO_MW4"]
HSL = maximum(HSL_[.!isnan.(HSL_)])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA GATEWAY STATION CC2",
    prime_mover = "CC_CT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-527")
sced_data = get_sced_data(thermal_sced_h5_file, "TGCCS_CC1_3")
HSL = 700
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA GATEWAY STATION CC3",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-528")
sced_data = get_sced_data(thermal_sced_h5_file, "TGCCS_CC1_3")
HSL = maximum(sced_data[!, "HSL"])
LSL = 700
new_thermal = make_thermal_gen(
    gen;
    name = "TENASKA GATEWAY STATION CC4",
    prime_mover = "CC_CA",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-529")
sced_data = get_sced_data(thermal_sced_h5_file, "OGSES_UNIT1A")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "OAK GROVE SES U1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-530")
sced_data = get_sced_data(thermal_sced_h5_file, "OGSES_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "OAK GROVE SES U2",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-535")
sced_data = get_sced_data(thermal_sced_h5_file, "MNSES_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MONTICELLO U1",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-536")
sced_data = get_sced_data(thermal_sced_h5_file, "MNSES_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MONTICELLO U2",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-537")
sced_data = get_sced_data(thermal_sced_h5_file, "MNSES_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "MONTICELLO U3",
    prime_mover = "ST",
    fuel = "SUB",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-540")
sced_data = get_sced_data(thermal_sced_h5_file, "ATKINS_ATKINSG7")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "ATKINS",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-541")
sced_data = get_sced_data(thermal_sced_h5_file, "TNP_ONE_TNP_O_1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TWIN OAKS U1",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-542")
sced_data = get_sced_data(thermal_sced_h5_file, "TNP_ONE_TNP_O_2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "TWIN OAKS U2",
    prime_mover = "ST",
    fuel = "LIG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-543")
sced_data = get_sced_data(thermal_sced_h5_file, "DANSBY_DANSBYG1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DANSBY ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-544")
sced_data = get_sced_data(thermal_sced_h5_file, "DANSBY_DANSBYG3")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen(
    gen;
    name = "DANSBY GT3",
    prime_mover = "GT",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

##### Manual fixes to NUCLEAR Gens ###########
gen = get_component(ThermalStandard, sys, "gen-212")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen_nuc(
    gen;
    name = "COMANCHE PEAK U1",
    prime_mover = "ST",
    fuel = "NUC",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-213")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen_nuc(
    gen;
    name = "COMANCHE PEAK U2",
    prime_mover = "ST",
    fuel = "NUC",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-379")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen_nuc(
    gen;
    name = "SOUTH TEXAS NUCLEAR U1",
    prime_mover = "ST",
    fuel = "NUC",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-380")
HSL = get_active_power_limits(gen).max
LSL = get_active_power_limits(gen).min
new_thermal = make_thermal_gen_nuc(
    gen;
    name = "SOUTH TEXAS NUCLEAR U2",
    prime_mover = "ST",
    fuel = "NUC",
    HSL = HSL,
    LSL = LSL,
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

#### Manual adjustments because the quadratic cost is a bad approximation of GSREH plants

gen = get_component(ThermalStandard, sys, "gen-193")
sced_data = get_sced_data(thermal_sced_h5_file, "GRSES_UNIT1")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "GRAHAM STG U1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-194")
sced_data = get_sced_data(thermal_sced_h5_file, "GRSES_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "GRAHAM STG U2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-476")
sced_data = get_sced_data(thermal_sced_h5_file, "LHSES_UNIT2A")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "LAKE HUBBARD ST",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-533")
sced_data = get_sced_data(thermal_sced_h5_file, "SCSES_UNIT1A")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "STRYKER CREEK ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-534")
sced_data = get_sced_data(thermal_sced_h5_file, "SCSES_UNIT2")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "STRYKER CREEK ST2",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

gen = get_component(ThermalStandard, sys, "gen-539")
sced_data = get_sced_data(thermal_sced_h5_file, "TRSES_UNIT6")
HSL = maximum(sced_data[!, "HSL"])
LSL = median(sced_data[sced_data.LSL .> 1, :][!, "LSL"])
new_thermal = make_thermal_gen_st(
    gen;
    name = "TRINIDAD ST1",
    prime_mover = "ST",
    fuel = "NG",
    HSL = HSL,
    LSL = LSL,
    sced_data = sced_data
)
remove_component!(sys, gen)
add_component!(sys, new_thermal)

#### add storage units
for (gen_name, storage_name) in gen_storage_mapping
    @info gen_name
    gen = get_component(ThermalStandard, sys, gen_name)
    storage = make_storage(gen; name =  storage_name)
    remove_component!(sys, gen)
    add_component!(sys, storage)
end

@assert isempty([(get_name(x), get_max_active_power(x)) for x in get_components(ThermalStandard, sys)])

for th in get_components(ThermalGen, sys)
    ap = get_active_power(th)
    p_lims_min = get_active_power_limits(th).min
    if ap <= p_lims_min
        set_active_power!(th, th.active_power_limits.min)
    end
    set_reactive_power!(th, 0.0)
end

to_json(sys, "intermediate_sys.json", force = true)
sys = System("intermediate_sys.json")
set_units_base_system!(sys, "SYSTEM_BASE")
@assert isempty(get_components(ThermalStandard, sys))

# Writes a JSON with the CC constraints
open("cc_restrictions.json","w") do f
    JSON.print(f, cc_train_restrictions)
end
