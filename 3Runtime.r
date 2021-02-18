# ------------------------------------------------------------------------------
#~ Runtime processes
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
#' Calculate CO2
#' @param lastCo2 number; last period co2
#' @returns co2 number; current period co2
# ------------------------------------------------------------------------------
calculateCo2 = function(lastCo2) {
  return(lastCo2 * CONFIG$co2Increase)
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
  partAlbedo = 1
  partAlbedo = partAlbedo + ((temp - oldTemp) * CONFIG$albSens) # the cryo impact
  partAlbedo = partAlbedo + ((temp - oldTemp) * CONFIG$albSens) # the cryo impact
  
  
  newAlbedo = oldAlbedo + ((temp - oldTemp) * CONFIG$albSens) # the cryo impact
  return(newAlbedo)
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
calculateCo2Temp = function(co2) {
  co2Change = co2 - CONFIG$initialCO2
  tempChange = CONFIG$CO2sens * co2Change
  initialCo2Temp = CONFIG$initialTemp - TS$albTemp[1]
  return(tempChange + initialCo2Temp)
}
# ------------------------------------------------------------------------------
#' Calculate new cloud cover
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @param oldCloud number; last period's albedo
#' @return newAlbedo number; resultant period albedo
# ------------------------------------------------------------------------------
calculateCloud = function(temp, oldTemp, oldCloud) {
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    # therefore, need to return the default albedo
    return(oldCloud)
  }
  newCloud = oldCloud + ((temp - oldTemp) * CONFIG$cloudSens)
  return(newCloud)
}
# ------------------------------------------------------------------------------
#' Calculate new vegitation
#' @param temp number; current temperature
#' @param oldTemp number; last period's temperature
#' @return change number; resultant period change
# ------------------------------------------------------------------------------
calculateVegChange = function(temp, oldTemp) {
  if (length(oldTemp) == 0) {
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
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    return(0)
  }
  change = ((temp - oldTemp) * CONFIG$cloudSens)
  return(change)
}