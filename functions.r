TEMP <- list(
toCelcius = function(kelvin) {
  stopifnot(kelvin > 0)
  stopifnot(is.numeric(kelvin))
  celcius = (kelvin - 273.15)
  stopifnot(celcius < 190)
  return(celcius)
},
toKelvin = function(celcius) {
  stopifnot(is.numeric(celcius))
  stopifnot(celcius > -100)
  stopifnot(celcius < 200)
  kelvin = (celcius + 273.15)
  stopifnot(kelvin > 0)
  return(kelvin)
}
)

calculateAlbedo = function(temp, oldTemp, oldAlbedo) {
  if (length(oldTemp) == 0) {
    # if this is the first cycle, oldTemp will be numeric(0)
    # therefore, need to return the default albedo
    return(oldAlbedo)
  }
  newAlbedo = oldAlbedo + ((temp - oldTemp) * CONFIG$albSens)
  return(newAlbedo)
}
calculateAlbedoTemp = function(albedo) {
  return((CONSTS$solar * (1 - albedo) / (4 * CONSTS$stefan)) ^ (1 / 4))
}