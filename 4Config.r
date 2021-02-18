# ------------------------------------------------------------------------------
#~ Configuration
# ------------------------------------------------------------------------------
CONFIG <- list(
  #~ General
  runYears = 100, # How many years to run for
  startYear = 2000, # Model start year
  initialTemp = TEMP$toKelvin(14), # Temperature at t=0 in kelvin
  initialCO2 = 369, # Initial CO2 level (ppmv)
  CO2Sens = 0.005, # K temp increase per 1 ppmv
  initialAlbedo = 0.3, # Initial albedo
  #~ Cryosphere
  enableCryo = TRUE,
  cryoSens = -0.005, # for every 1 degree of warming, albedo increases by...
  #~ Ocean CO2 rise
  enableOceanCO2 = TRUE,
  oceanCO2Sens = 10,
  #~ Anthropogenic CO2 rise
  enableAnthCO2 = TRUE,
  anthCO2Multiplier = 1.01, # factor to increase CO2 by each year
  #~ Vegetation
  enableVeg = TRUE,
  vegSens = -0.01, # for every 1 degree of warming, vegetation increases by...
  vegAlbedoSens = -0.3,
  #~ Clouds
  enableClouds = TRUE,
  cloudSens = -0.01,
  cloudAlbedoSens = 0.1
)
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
CONFIG$runYears = CONFIG$runYears+1
TS <- data.frame(
  year = numeric(CONFIG$runYears),
  anthCO2 = numeric(CONFIG$runYears),
  oceanCO2 = numeric(CONFIG$runYears),
  vegChange = numeric(CONFIG$runYears),
  cloudChange = numeric(CONFIG$runYears), 
  albedo = numeric(CONFIG$runYears),
  albTemp = numeric(CONFIG$runYears),
  co2Temp = numeric(CONFIG$runYears),
  earTemp = numeric(CONFIG$runYears)
)
# set start values
TS$year[1] = CONFIG$startYear
TS$anthCO2[1] = CONFIG$initialCO2
TS$albedo[1] = CONFIG$initialAlbedo
# calculate initial temperatures
TS$albTemp[1] = calculateAlbedoTemp(CONFIG$initialAlbedo)
TS$co2Temp[1] = CONFIG$initialTemp - TS$albTemp[1]
TS$earTemp[1] = TS$albTemp[1] + TS$co2Temp[1]
# check initial earth temp matches the expectation
stopifnot(TS$earTemp[1] == CONFIG$initialTemp)
