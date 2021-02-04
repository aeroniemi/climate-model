config <- list(
  runYears = 11, # How many years to run for
  startYear = 2000, # Model start year
  initialAlbedo = 0.3, # Initial albedo
  initialCO2 = 369, # Initial CO2 level (ppmv)
  CO2sens = 0.005, # K temp increase per 1 ppmv
  initialTemp = cToK(14) # Temperature at t=0 in kelvin
)
CONSTS <- list(
  solar = 1370, # solar constant, W m^-2
  stefan = 5.67E-8, # stefan-boltzmann constant
  last = FALSE
)

