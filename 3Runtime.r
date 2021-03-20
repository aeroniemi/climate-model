# ------------------------------------------------------------------------------
#~ Runtime processes
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
#' Calculate CO2
#' @param lastCo2 number; last period co2
#' @returns AnthCO2 number; current period co2
# ------------------------------------------------------------------------------
calculateAnthCO2 = function(lastCO2, config) {
    if (config$enableAnthCO2 == FALSE) {
    return(lastCO2)
  }
    return(lastCO2 * config$anthCO2Multiplier)
}
# ------------------------------------------------------------------------------
#' Calculate new albedo
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @param oldAlbedo number; last period's albedo
#' @param time object; current period timeseries object
#' @return albedo number; resultant period albedo
# ------------------------------------------------------------------------------
calculateAlbedo = function(temp, oldTemp, oldAlbedo, time, config) {
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    # therefore, need to return the default albedo
    return(oldAlbedo)
  }
  albedo = oldAlbedo
  if (config$enableCryo == TRUE) {
    albedo = albedo + ((temp - oldTemp) * config$cryoSens) # the cryo impact
  }
  albedo = albedo + (time$cloudChange * config$vegAlbedoSens) # the veg impact
  albedo = albedo + (time$vegChange * config$cloudAlbedoSens) # the cloud impact
  return(albedo)
}
# ------------------------------------------------------------------------------
#' Calculate base temperature from albedo
#' @param albedo number; current period albedo
#' @returns temp number; current period base temperature
# ------------------------------------------------------------------------------
calculateAlbedoTemp = function(albedo, config) {
  return((CONSTS$solar * (1 - albedo) / (4 * CONSTS$stefan)) ^ (1 / 4))
}
# ------------------------------------------------------------------------------
#' Calculate CO2 temperature
#' @param time object; current period timeseries
#' @param initialAlbedoTemp number; first period albedo temperature component
#' @returns temp number; current period CO2 sub-temperature
# ------------------------------------------------------------------------------
calculateCo2Temp = function(time, initialAlbedoTemp, config) {
  co2Change = (time$anthCO2+time$oceanCO2) - config$initialCO2
  tempChange = config$CO2Sens * co2Change
  initialCo2Temp = config$initialTemp - initialAlbedoTemp
  return(tempChange + initialCo2Temp)
}
# ------------------------------------------------------------------------------
#' Calculate new vegitation
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateVegChange = function(temp, oldTemp, config) {
  if (length(oldTemp) == 0 || config$enableVeg == FALSE) {
    # if this is the first cycle, oldTemp will be numeric(0)
    return(0)
  }
  change = ((temp - oldTemp) * config$vegSens)
  return(change)
}
# ------------------------------------------------------------------------------
#' Calculate new cloud
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateCloudChange = function(temp, oldTemp, config) {
  if (length(oldTemp) == 0 || config$enableClouds == FALSE) {
    # if this is the first cycle, oldTemp will be numeric(0)
    return(0)
  }
  change = ((temp - oldTemp) * config$cloudSens)
  return(change)
}
# ------------------------------------------------------------------------------
#' Calculate ocean CO2
#' @param temp number; current temperature
#' @return CO2 number; resultant period value
# ------------------------------------------------------------------------------
calculateOceanCO2 = function(temp, config) {
  if (config$enableOceanCO2 == FALSE) {
    return(0)
  }
  CO2 = ((temp - config$initialTemp) * config$oceanCO2Sens)
  return(CO2)
}
# ------------------------------------------------------------------------------
#' Calculate permafrost forcing
#' @param temp number; current temperature
#' @return forcing number; resultant period value forcing, wm2
# ------------------------------------------------------------------------------
calculatePermaForcing = function(temp, config) {
  if (config$enablePermaForcing == FALSE) {
    return(0)
  }
  forcing = ((temp - config$initialTemp) * config$permaForcingSens)
  return(forcing)
}
# ------------------------------------------------------------------------------
#' Calculate fertilisation co2 forcing
#' @param temp number; current temperature
#' @return forcing number; resultant period value forcing, wm2
# ------------------------------------------------------------------------------
calculateFertCO2Forcing = function(temp, config) {
  if (config$enableFertCO2 == FALSE) {
    return(0)
  }
  forcing = ((temp - config$initialTemp) * config$fertCO2Sens)
  return(forcing)
}
# ------------------------------------------------------------------------------
#' Calculate forcing temperature
#' @param time object; current period timeseries
#' @param initialAlbedoTemp number; first period albedo temperature component
#' @returns temp number; current period CO2 sub-temperature
# ------------------------------------------------------------------------------
calculateForcingTemp = function(time, initialAlbedoTemp, config) {
  forcing = (time$permaForcing + time$fertCO2Forcing)
  temp = config$cliFeedbackParam * forcing
  return(temp)
  # return(0)
}