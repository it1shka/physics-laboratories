∑(X) = reduce(+, X)
mean(X) = ∑(X) / length(X)
means(M) = mean.(eachcol(M))
means_approx(M) = round.(means(M), digits = 2)

function typeA(X) 
  n = length(X)
  Xm = mean(X)
  dX = (x -> (x - Xm) ^ 2).(X)
  sqrt(∑(dX) / n / (n - 1))
end

# Δd is a smallest division
typeB(Δd) = 0.5Δd / sqrt(3)

function combine(X)
  squared = (x -> x ^ 2).(X)
  summed = ∑(squared)
  return sqrt(summed)
end

zippairs(A, B) = collect(zip(A, B))

# uncertainties of the first level
μt(t) = combine([typeA(t), typeB(0.01), 0.5])
μT(t) = sqrt((μt(t) / 100) ^ 2 + (1 / 100 ^ 2) ^ 2)

μD(D) = combine([typeA(D), typeB(0.05)])
μd(D) = 0.5μD(D)
