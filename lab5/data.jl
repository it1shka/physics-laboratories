using DataFrames

matrix = [111.3 54.5 76.6 129.5  22.5;
          111.6 51.7 72.6 123.5  25.6;
          112.3 48.0 66.9 115.0  30.6;
          113.2 44.2 61.6 106.9  35.6;
          114.7 40.0 54.0  94.1  40.3;
          115.5 36.9 50.4  88.6  45.3;
          116.8 33.4 45.0  79.5  50.6;
          118.0 30.6 40.7  72.6  55.6;
          119.2 28.2 37.0  66.3  60.5;
          120.6 25.8 33.1  59.8  65.4;
          121.4 23.7 30.3  54.8  70.4;
          122.7 21.8 27.4  49.6  75.4;
          124.2 20.0 24.8  45.0  80.5;
          125.8 18.1 22.1  39.8  85.0;
          127.1 16.8 20.3  36.8  90.4;
          128.4 15.6 18.5  33.4  95.4;
          129.8 14.5 16.9  30.5 100.4]

colnames = [:first, :second, :third, :fourth, :temperature]

frame = DataFrame(matrix, colnames)

# Some public functions

∑(X) = reduce(+, X) 

typeB(Δd) = Δd / √3
μt = typeB(0.5)
μΩ(rdg) = (0.005rdg + 0.1) |> typeB

μrect(x, y, xerr, yerr) = Shape(
  [x - xerr, x - xerr, x + xerr, x + xerr], 
  [y - yerr, y + yerr, y + yerr, y - yerr]
)

# combinator 
Y(μs) = (x -> x ^ 2).(μs) |> ∑ |> √