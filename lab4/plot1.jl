using Plots
include("setup.jl")

temperature_uncertainties = fill(thermometer_uncert, length(temperatures))
voltage_uncertainties = (rdg -> (0.0005rdg + 0.01) / √3).(voltages)

plot(temperatures, voltages, label="")
scatter!(temperatures, voltages, label="Voltage", xerr=temperature_uncertainties, yerr=voltage_uncertainties, markersize=3)
xlabel!("T, °C")
ylabel!("U, mV")

savefig("voltage.png")