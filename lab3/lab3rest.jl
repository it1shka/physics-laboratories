include("lab3func.jl")

d = [130.20 130.00 130.00 130.00 129.85 129.95 130.00]
D = [139.90 139.70 139.70 139.60 139.90 139.70 139.80]

m = [257.3 257.2 257.2 257.3 257.2]
t = [73.07 73.67 73.70 73.69 73.50]

k = 9.81 / 8π^2

dm = mean(d)
Dm = mean(D)
Tm = mean((x -> x / 100).(t))
mm = mean(m)

μdv = μD(d)
μTv = μT(t)
μmv = μm(m)

μI = k * combine([dm * Tm^2 * μmv, mm * Tm^2 * μdv, 2mm * dm * Tm * μTv])
@show dm^2 * μmv
@show 2*mm*dm*μdv
μIx = (1/4) * combine([dm^2 * μmv, 2*mm*dm*μdv])

combine([μI, μIx / 1000])

μDv = μD(D)

(1/8)*mm*(dm^2 + Dm^2)


μσ1 = combine([dm^2 * μmv, 2*mm*dm*μdv]) / 1000
μσ2 = combine([Dm^2 * μmv, 2*mm*Dm*μDv]) / 1000
@show μσ1 μσ2

(1/8)combine([μσ1 μσ2])