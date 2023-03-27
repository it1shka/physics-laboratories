include("lab3func.jl")

D = [49.40 98.50 149.45 99.35 127.50 140.20;
     49.65 99.80 149.50 99.70 127.60 140.05;
     49.75 99.50 149.55 99.25 127.75 140.25;
     49.55 99.30 149.65 99.65 127.70 140.10;
     49.55 99.45 149.65 99.75 127.55 140.15;
     49.75 99.10 149.60 99.65 127.70 140.10;
     49.85 99.75 149.50 99.55 127.70 140.20]

t = [77.51 67.47 68.83 67.83 67.47 68.22;
     77.43 67.73 68.43 67.24 67.85 67.95;
     77.79 67.52 68.51 67.67 67.52 68.03]

d = (Di -> Di / 2).(D)
T = (ti -> ti / 100).(t)

# mean values
dms = mean.(eachcol(d))
Tms = mean.(eachcol(T))

# uncertainties, first stage
μds = μd.(eachcol(D))
μTs = μT.(eachcol(t))

# uncertainties for point plot

# errors of d^2
errx = map(1:6) do i
  2dms[i]  * μds[i]
end

# errors of T^2 d 
erry = map(1:6) do i
  T, d = Tms[i], dms[i]
  μT, μd = μTs[i], μds[i]
  sqrt(4T^2 * d^2 * μT^2 + T^4 + μd^2)
end

# actual values
x = (d -> d ^ 2).(dms)
y = (i -> dms[i] * Tms[i] ^ 2).(1:6)

@show x y errx erry

# drawing actial plot
using Plots

plot(x, y, 
  seriestype = :scatter, label = "Point",
  xerr = errx, yerr = erry)
xlabel!("d^2")
ylabel!("dT^2")
title!("Point Plot")

savefig("point_plot.png")