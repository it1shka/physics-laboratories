using Plots
include("setup.jl")

timeline = 0:20:(length(voltages2) - 1) * 20

voltage_uncertainties = voltage_uncert(voltages2)
time_uncertainties = fill(Y([0.5, 0.1]), length(timeline))

scatter(
  timeline, voltages2, 
  xerr=time_uncertainties, 
  yerr=voltage_uncertainties, 
  markersize=3, 
  legend=false
)

xlabel!("t, s")
ylabel!("U, mV")
savefig("plot2.png")