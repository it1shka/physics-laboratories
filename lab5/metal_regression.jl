using Plots, GLM, DataFrames
include("data.jl")

x = frame[!, :temperature]
y = frame[!, :first]

xerr = fill(μt, length(x))
yerr = μΩ.(y)

model = lm(@formula(Y ~ X), DataFrame(X=x, Y=y))
prediction = predict(model, DataFrame(X=x))

scatter(x, y, xerr=xerr, yerr=yerr, label="Actual points")
plot!(x, prediction, label="Linear regression")

xlabel!("t, °C")
ylabel!("R, Ω")
title!("Plot for Metal Sample with Linear Regression")

b, a = coef(model)
μb, μa = stderror(model)

@show a μa b μb

savefig("metal_regression.png")