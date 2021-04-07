using PowerSystems
using PowerSimulations
const PSY = PowerSystems
const PSI = PowerSimulations
using Logging
using Dates
using CPLEX
using DataFrames

system = system_new = System("RT_sys.json")
#system_old = System("/Users/jdlara/Dropbox/Code/MultiStageCVAR/data/HA_sys.json")

configure_logging(file_level = Logging.Info, console_level = Logging.Info)

template = OperationsProblemTemplate(CopperPlatePowerModel)
set_device_model!(template, ThermalMultiStart, ThermalBasicUnitCommitment)
set_device_model!(template, RenewableDispatch, RenewableFullDispatch)
set_device_model!(template, PowerLoad, StaticPowerLoad)
set_device_model!(template, HydroDispatch, HydroDispatchRunOfRiver)
set_device_model!(template, GenericBattery, BookKeepingwReservation)
set_service_model!(template, ServiceModel(VariableReserve{ReserveUp}, RangeReserve))
set_service_model!(template, ServiceModel(VariableReserve{ReserveDown}, RangeReserve))

initial_time = DateTime("2018-01-01T00:00:00")

op_problem = OperationsProblem(
    UnitCommitmentProblem,
    template,
    system_new;
    initial_time = initial_time,
    #services_slack_variables = true,
    #balance_slack_variables = true,
    system_to_file = false,
    optimizer_log_print = true,
    optimizer = optimizer_with_attributes(CPLEX.Optimizer),
)

build!(op_problem; console_level = Logging.Info, output_dir = "./res")
solve!(op_problem)
results = ProblemResults(op_problem)

for name in names(results.variable_values[:On__ThermalMultiStart])
    status = results.variable_values[:On__ThermalMultiStart][!, name]
    eltype(status) <: DateTime && continue
    th = get_component(ThermalMultiStart, system, name)
    min_lim = get_active_power_limits(th).min
    max_lim = get_active_power_limits(th).max
    set_status!(th, Bool(round(status[1])))
    base_power = get_base_power(th)
    power_ = results.variable_values[:P__ThermalMultiStart][!, name][1] * 100.0 / base_power
    # power_ = status[1]*((min_lim + power[1]))
    power_ =
        isapprox(power_, max_lim * 100.0 / base_power; atol = 1e-3) ?
        max_lim * 100.0 / base_power - 1e-2 : power_
    power_ =
        isapprox(power_, min_lim * 100.0 / base_power; atol = 1e-3) ?
        min_lim * 100.0 / base_power + 1e-3 : power_
    set_active_power!(th, power_)
    set_reactive_power!(th, 0.0)
end

for name in names(results.variable_values[:P__HydroDispatch])
    power = results.variable_values[:P__HydroDispatch][!, name]
    eltype(power) <: DateTime && continue
    th = get_component(HydroDispatch, system, name)
    base_power = get_base_power(th)
    set_active_power!(th, power[1] * 100.0 / base_power)
    set_reactive_power!(th, 0.0)
end

for name in names(results.variable_values[:Pout__GenericBattery])
    power = results.variable_values[:Pout__GenericBattery][!, name]
    eltype(power) <: DateTime && continue
    power =
        results.variable_values[:Pout__GenericBattery][!, name] -
        results.variable_values[:Pin__GenericBattery][!, name]
    th = get_component(GenericBattery, system, name)
    base_power = get_base_power(th)
    set_active_power!(th, power[1] * 100.0 / base_power)
    set_reactive_power!(th, 0.0)
end

to_json(system, "RT_sys.json"; force = true)
