import numpy as np
from math import sqrt, pi
from textwrap import dedent

def direct_combine(values):
  summed_squares = np.sum(np.array(values) ** 2)
  return sqrt(summed_squares)

class Cylinder:
  CALIPER_UNCERT = 0.05 / (2 * sqrt(3))
  def __init__(self, name, diameters, heights):
    self.name = name
    self.diameters = np.array(diameters)
    self.heights = np.array(heights)
  
  @property
  def mean_height(self):
    return np.mean(self.heights)
  
  @property 
  def mean_diameter(self):
    return np.mean(self.diameters)

  @classmethod
  def uncertainty(cls, measurements):
    type_a = np.std(measurements)
    return direct_combine([type_a, cls.CALIPER_UNCERT])

  @property
  def diameter_uncertainty(self):
    return self.uncertainty(self.diameters)
  
  @property
  def height_uncertainty(self):
    return self.uncertainty(self.heights)
  
  @property
  def mean_volume(self):
    return 0.24 * pi * (self.mean_diameter ** 2) * self.mean_height
  
  @property
  def volume_uncertainty(self):
    partial1 = (pi * (self.mean_diameter ** 2) * self.diameter_uncertainty / 4.0) ** 2
    partial2 = (pi * self.mean_diameter * self.mean_height * self.height_uncertainty / 2) ** 2
    return sqrt(partial1 + partial2)

  def __str__(self):
    return dedent(f'''
    ***
      {self.name}:
      mean diameter: {self.mean_diameter}
      mean height: {self.mean_height}

      uncertainty diameter: {self.diameter_uncertainty}
      uncertainty height: {self.height_uncertainty}

      mean volume: {self.mean_volume}
      volume uncertainty: {self.volume_uncertainty}
    ***
    ''')

# raw experiment data
CYLINDERS = [
  Cylinder (
    'Cylinder 1',
    [10.00, 9.80, 9.90, 9.70, 9.85, 9.80, 9.90],
    [6.45, 6.40, 6.35, 6.30, 6.35, 6.60, 6.60],
  ),
  Cylinder (
    'Cylinder 2',
    [15.30, 15.30, 15.35],
    [5.65, 5.55, 5.60, 5.65, 5.55],
  ),
  Cylinder (
    'Cylinder 3',
    [20.15, 20.10, 20.20],
    [8.60, 8.35, 8.55],
  ),
  Cylinder (
    'Cylinder 4',
    [16.20, 16.15, 16.20],
    [15.10, 15.15, 15.15],
  ),
  Cylinder (
    'Cylinder 5',
    [20.10, 20.15, 20.10],
    [40.15, 39.80, 40.10, 39.90, 39.95],
  ),
  Cylinder (
    'Cylinder 6',
    [9.20, 9.00, 9.10, 9.00, 8.80],
    [5.90, 5.95, 5.80, 5.90, 5.80],
  ),
]

MASS = np.array([54.3, 54.2, 54.3, 54.2, 54.2, 54.2])
SCALES_UNCERT = 0.1 / sqrt(3)

def main():
  # printing for each cylinder
  for each in CYLINDERS:
    print(each)

  # evaluating mass parameters
  print(f'scales accuracy: {SCALES_UNCERT}')
  mean_mass = np.mean(MASS)
  print(f'mean mass: {mean_mass}')
  mass_unsertainty = direct_combine([SCALES_UNCERT, np.std(MASS)])
  print(f'mass uncertainty: {mass_unsertainty}\n')

  # evaluating mean volume
  mean_volume = sum(map(lambda e: e.mean_volume, CYLINDERS[:5])) - CYLINDERS[-1].mean_volume
  volume_uncertainty = direct_combine(list(map(lambda e: e.volume_uncertainty, CYLINDERS)))
  print(f'mean volume: {mean_volume}, volume uncertainty: {volume_uncertainty}')

  # evaluating density
  mean_density = mean_mass / mean_volume * 1000
  partial1 = (mass_unsertainty / mean_volume) ** 2
  partial2 = (mean_mass * volume_uncertainty / (mean_volume ** 2)) ** 2
  density_uncertainty = sqrt(partial1 + partial2)

  print(f'mean density: {mean_density}, density uncertainty: {density_uncertainty}')

if __name__ == '__main__': main()