# ------------------------------------------------------------------------------
# Temperature conversion
# ------------------------------------------------------------------------------
TEMP <- list(
# ------------------------------------------------------------------------------
#' Kelvin to Celcius
#' @param kelvin number
#' @returns celcius number
# ------------------------------------------------------------------------------
toCelcius = function(kelvin) {
  stopifnot(kelvin > 0)
  stopifnot(is.numeric(kelvin))
  celcius = (kelvin - 273.15)
  stopifnot(celcius < 190)
  return(celcius)
},
# ------------------------------------------------------------------------------
#' Celcius to Kelvin
#' @param celcous number
#' @returns kelvin number
# ------------------------------------------------------------------------------
toKelvin = function(celcius) {
  stopifnot(is.numeric(celcius))
  stopifnot(celcius > -100)
  stopifnot(celcius < 200)
  kelvin = (celcius + 273.15)
  stopifnot(kelvin > 0)
  return(kelvin)
}
)
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
#' @return newAlbedo number; resultant period albedo
# ------------------------------------------------------------------------------
calculateAlbedo = function(temp, oldTemp, oldAlbedo) {
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    # therefore, need to return the default albedo
    return(oldAlbedo)
  }
  newAlbedo = oldAlbedo + ((temp - oldTemp) * CONFIG$albSens)
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
