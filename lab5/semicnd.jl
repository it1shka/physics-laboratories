using Plots
include("data.jl")

temperature = (t -> t + 273.15).(frame[!, :temperature])
resistivity = frame[!, :fourth]

x = (T -> 1000 / T).(temperature)
y = log.(resistivity)

xerr = (T -> μt * 1000 / T^2).(temperature)
yerr = (r -> μΩ(r) / r).(resistivity)

scatter(x, y, xerr=xerr, yerr=yerr, markersize=3, label="Point")
xlabel!("X axis (1000 / T)")
ylabel!("Y axis (lnR)")
title!("Plot of lnR = f(1000 / T) for Semiconductor Sample")

savefig("semiconductor.png")