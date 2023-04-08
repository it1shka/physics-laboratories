using Plots, GLM, DataFrames
include("setup.jl")

model = lm(@formula(y ~ x), DataFrame(x=temperatures, y=voltages))
b, a = coef(model)
errb, erra = coeftable(model).cols[2]

println(erra)

temperature_uncertainties = fill(thermometer_uncert, length(temperatures))
voltage_uncertainties = (rdg -> (0.0005rdg + 0.01) / √3).(voltages)

scatter(temperatures, voltages, label="Voltage", xerr=temperature_uncertainties, yerr=voltage_uncertainties)
plot!(temperatures, (x -> a*x + b).(temperatures), label="Regression Line")
xlabel!("T, °C")
ylabel!("U, mV")

savefig("voltage_regression.png")