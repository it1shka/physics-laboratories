from dataclasses import dataclass
from math import sqrt

uL = 0.288675
uX = 0.204124
Lambda = 532.5895110782009
LambdaStdev = 0.7472916417628126

def stdev(mean: float, dataset: list[float]) -> float:
  diffs = map(lambda e: (e - mean) ** 2, dataset)
  summed = sum(diffs)
  A = len(dataset)
  return sqrt(summed / A / (A - 1))

@dataclass
class Measurement:
  L: float
  left: float
  right: float

  @property
  def mean(self) -> float:
    return (self.left + self.right) / 2
  
  @property
  def sin(self) -> float:
    return self.mean / sqrt(self.mean ** 2 + self.L ** 2)
  
  @property
  def sin_uncert(self) -> float:
    first = (self.L * self.mean * uL) / ((self.L**2 + self.mean**2) ** 1.5)
    second = (self.L**2 * uX) / ((self.L**2 + self.mean**2) ** 1.5)
    return sqrt(first ** 2 + second ** 2)

# Dataset
MEASUREMENTS = [
  Measurement(125, 35, 35),
  Measurement(150, 42, 42),
  Measurement(100, 28, 28),
  Measurement(50, 14.5, 14.5),
  Measurement(75, 21, 21),
  Measurement(175, 49, 49),
  Measurement(200, 56, 55.5),
  Measurement(220, 62, 61),
  Measurement(240, 67, 66),
  Measurement(260, 72, 72.5),
  Measurement(280, 78, 78),
  Measurement(300, 83, 84),
  Measurement(330, 92.5, 92),
  Measurement(360, 100, 100),
  Measurement(400, 111, 111)
]

if __name__ == '__main__':
  sins = list(map(lambda e: e.sin, MEASUREMENTS))
  sinavg = sum(sins) / len(sins)
  print(sinavg)
  uSin = stdev(sinavg, sins)
  print(uSin)

  d = Lambda / sinavg
  print(d)

  part1 = (LambdaStdev / sinavg) ** 2
  part2 = (Lambda * uSin / sinavg ** 2) ** 2
  uD = sqrt(part1 + part2)
  print(uD)
