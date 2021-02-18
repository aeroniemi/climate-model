# ------------------------------------------------------------------------------
#~ Temperature conversion
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