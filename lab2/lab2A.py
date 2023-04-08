from dataclasses import dataclass
from math import sqrt

uL = 0.288675
uX = 0.204124
d = 0.02

def get_sin(x: float, L: float) -> float:
  return x / sqrt(x ** 2 + L ** 2)

def get_sin_uncert(x: float, L: float) -> float:
  first = (L * x * uL) / ((L**2 + x**2) ** 1.5)
  second = (L**2 * uX) / ((L**2 + x**2) ** 1.5)
  return sqrt(first ** 2 + second ** 2)

def stdev(mean: float, dataset: list[float]) -> float:
  diffs = map(lambda e: (e - mean) ** 2, dataset)
  summed = sum(diffs)
  A = len(dataset)
  return sqrt(summed / A / (A - 1))

@dataclass
class Measurement:
  """Class representing measurements for particular L"""
  L: float
  pairs: list[tuple[float, float]]

  @property
  def mean_xs(self) -> list[float]:
    return [(pair[0] + pair[1]) / 2 
      for pair in self.pairs]
  
  @property
  def sins(self) -> list[float]:
    return [get_sin(x, self.L) for x in self.mean_xs]
  
  @property
  def sin_uncerts(self) -> list[float]:
    return [get_sin_uncert(x, self.L) for x in self.mean_xs]
  
  @property
  def waves(self) -> list[float]:
    return [d * sinv / (n + 1) 
      for n, sinv in enumerate(self.sins)]

# Dataset
MEASUREMENTS =  [
  Measurement(300, list(zip([8, 16, 24, 32], [8, 16, 24, 32]))),
  Measurement(360, list(zip([9.5, 19, 29, 39], [9.5, 19, 29, 38.5]))),
  Measurement(400, list(zip([11, 21.5, 32.5, 43], [10.5, 21, 32, 43]))),
  Measurement(425, list(zip([11.5, 23, 34, 46], [11, 22.5, 34, 46]))),
  Measurement(550, list(zip([15, 29, 44, 59], [14.5, 29, 44, 59])))
]

if __name__ == '__main__':
  waves = []
  for each in MEASUREMENTS:
    waves += each.waves
  
  mean = sum(waves) / len(waves)
  print(mean * 10 ** 6)
  uLambda = stdev(mean, waves)
  print(uLambda * 10 ** 6)

