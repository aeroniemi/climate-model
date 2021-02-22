# ------------------------------------------------------------------------------
#~ Configuration
# ------------------------------------------------------------------------------
CONFIG <- list(
  #~ General
  runYears = 100, # How many years to run for
  startYear = 2000, # Model start year
  initialTemp = TEMP$toKelvin(14), # Temperature at t=0 in kelvin
  initialCO2 = 369, # Initial CO2 level (ppmv)
  initialAlbedo = 0.3, # Initial albedo
  CO2Sens = 0.005, # K temp increase per 1 ppmv
  #~ Cryosphere
  enableCryo = TRUE,
  cryoSens = -0.005, # for every 1 degree of warming, albedo increases by...
  #~ Ocean CO2 rise
  enableOceanCO2 = TRUE,
  oceanCO2Sens = 10, # for every 1 degree of warming, oceanic CO2 increases by ... ppmv
  #~ Anthropogenic CO2 rise
  enableAnthCO2 = TRUE,
  anthCO2Multiplier = 1.01, # factor to increase CO2 by each year
  #~ Vegetation
  enableVeg = TRUE,
  vegSens = -0.01, # for every 1 degree of warming, vegetation increases by...
  vegAlbedoSens = -0.3, # for every 1 increase in vegitation, albedo increases by...
  #~ Clouds
  enableClouds = TRUE,
  cloudSens = -0.01, # for every 1 degree of warming, cloud cover increases by...
  cloudAlbedoSens = 0.1 # for every 1 increase in cloud cover, albedo increases by...
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

