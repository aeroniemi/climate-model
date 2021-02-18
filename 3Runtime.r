# ------------------------------------------------------------------------------
#~ Runtime processes
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
#' Calculate CO2
#' @param lastCo2 number; last period co2
#' @returns co2 number; current period co2
# ------------------------------------------------------------------------------
calculateAnthCO2 = function(lastCO2) {
    if (CONFIG$enableAnthCO2 == FALSE) {
    return(lastCO2)
  }
    return(lastCO2 * CONFIG$anthCO2Multiplier)
}
# ------------------------------------------------------------------------------
#' Calculate new albedo
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @param oldAlbedo number; last period's albedo
#' @param time object; current period timeseries row
#' @return newAlbedo number; resultant period albedo
# ------------------------------------------------------------------------------
calculateAlbedo = function(temp, oldTemp, oldAlbedo, time) {
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    # therefore, need to return the default albedo
    return(oldAlbedo)
  }
  partAlbedo = oldAlbedo
  if (CONFIG$enableCryo == TRUE) {
    partAlbedo = partAlbedo + ((temp - oldTemp) * CONFIG$cryoSens) # the cryo impact
  }
  
  partAlbedo = partAlbedo + (time$cloudChange * CONFIG$vegAlbedoSens) # the veg impact
  partAlbedo = partAlbedo + (time$vegChange * CONFIG$cloudAlbedoSens) # the cloud impact
  return(partAlbedo)
}
# ------------------------------------------------------------------------------
#' Calculate base temperature from albedo
#' @param albedo number; current period albedo
#' @returns temp number; current period base temperature
# ------------------------------------------------------------------------------
calculateAlbedoTemp = function(albedo) {
  return((CONSTS$solar * (1 - albedo) / (4 * CONSTS$stefan)) ^ (1 / 4))
}
# ------------------------------------------------------------------------------
#' Calculate CO2 temperature
#' @param co2 number; current period co2
#' @returns temp number; current period co2 sub-temperature
# ------------------------------------------------------------------------------
calculateCo2Temp = function(time) {
  co2Change = (time$anthCO2+time$oceanCO2) - CONFIG$initialCO2
  tempChange = CONFIG$CO2Sens * co2Change
  initialCo2Temp = CONFIG$initialTemp - TS$albTemp[1]
  return(tempChange + initialCo2Temp)
}
# ------------------------------------------------------------------------------
#' Calculate new vegitation
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateVegChange = function(temp, oldTemp) {
  if (length(oldTemp) == 0 || CONFIG$enableVeg == FALSE) {
    # if this is the first cycle, oldTemp will be numeric(0)
    return(0)
  }
  change = ((temp - oldTemp) * CONFIG$vegSens)
  return(change)
}
# ------------------------------------------------------------------------------
#' Calculate new cloud
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateCloudChange = function(temp, oldTemp) {
  if (length(oldTemp) == 0 || CONFIG$enableClouds == FALSE) {
    # if this is the first cycle, oldTemp will be numeric(0)
    return(0)
  }
  change = ((temp - oldTemp) * CONFIG$cloudSens)
  return(change)
}
# ------------------------------------------------------------------------------
#' Calculate ocean CO2
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateOceanCO2 = function(temp) {
  if (CONFIG$enableOceanCO2 == FALSE) {
    return(0)
  }
  CO2 = ((temp - CONFIG$initialTemp) * CONFIG$oceanCO2Sens)
  return(CO2)
}