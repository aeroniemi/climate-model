# ------------------------------------------------------------------------------
#~ Configuration
# ------------------------------------------------------------------------------
config <- list(
  runYears = 300, # How many years to run for
  startYear = 2000, # Model start year
  initialAlbedo = 0.3, # Initial albedo
  initialCO2 = 369, # Initial CO2 level (ppmv)
  CO2Sens = 0.005, # K temp increase per 1 ppmv
  albSens = -0.005, # for every 1 degree of warming, albedo increases by...
  vegSens = -0.01, # for every 1 degree of warming, vegetation increases by...
  cloudSens = -0.01,
  oceanCO2Sens = 10,
  cloudAlbedoSens = 0.1, 
  vegAlbedoSens = -0.3,
  co2Increase = 1.01, # factor to increase CO2 by each year
  initialTemp = TEMP$toKelvin(14) # Temperature at t=0 in kelvin
)
CONFIG = config
# ------------------------------------------------------------------------------
#~ Constants
# things that are not expected to be changed by the user
# ------------------------------------------------------------------------------
CONSTS <- list(
  solar = 1370, # Solar constant, W m^-2
  stefan = 5.67E-8, # Stefan-Boltzmann constant
  last = FALSE
)


# ------------------------------------------------------------------------------
#~ Init vectors
# ------------------------------------------------------------------------------
TS <- data.frame(
  year = numeric(CONFIG$runYears),
  anthCO2 = numeric(CONFIG$runYears),
  oceanCO2 = numeric(CONFIG$runYears),
  #albedoChange = numeric(CONFIG$runYears),
  vegChange = numeric(CONFIG$runYears),
  cloudChange = numeric(CONFIG$runYears), 
  albedo = numeric(CONFIG$runYears),
  #veg = numeric(CONFIG$runYears),
  #cloud = numeric(CONFIG$runYears), 
  albTemp = numeric(CONFIG$runYears),
  co2Temp = numeric(CONFIG$runYears),
  earTemp = numeric(CONFIG$runYears)
)
# set start values
TS$year[1] = CONFIG$startYear
TS$anthCO2[1] = CONFIG$initialCO2
TS$albedo[1] = CONFIG$initialAlbedo
#TS$veg[1] = 1
#TS$cloud[1] = 1
# calculate initial temperatures
TS$albTemp[1] = calculateAlbedoTemp(CONFIG$initialAlbedo)
TS$co2Temp[1] = CONFIG$initialTemp - TS$albTemp[1]
TS$earTemp[1] = TS$albTemp[1] + TS$co2Temp[1]
# check initial earth temp matches the expectation
stopifnot(TS$earTemp[1] == CONFIG$initialTemp)
