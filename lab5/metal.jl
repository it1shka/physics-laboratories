using Plots
include("data.jl")

x = frame[!, :temperature]
y = frame[!, :first]

xerr = fill(μt, length(x))
yerr = μΩ.(y)

scatter(x, y, xerr=xerr, yerr=yerr, markersize=3, label="Resistivity")
xlabel!("t, °C")
ylabel!("R, Ω")
title!("Plot of R = f(m) for Metal Sample")

plot!(μrect(x[13], y[13], xerr[13], yerr[13]), opacity=0.5, label="Area of Uncertainty")

savefig("metal.png")