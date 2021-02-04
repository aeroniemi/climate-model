kToC = function(kelvin) {
  stopifnot(kelvin > 0)
  stopifnot(is.numeric(kelvin))
  celcius = (kelvin - 273.15)
  stopifnot(celcius < 190)
  return(celcius)
}
cToK = function(celcius) {
  stopifnot(is.numeric(celcius))
  stopifnot(celcius > -100)
  stopifnot(celcius < 200)
  kelvin = (celcius + 273.15)
  stopifnot(kelvin > 0)
  return(kelvin)
}


kToC = function(kelvin) {
  celcius = (kelvin - 273.15)
  return(celcius)
}
kToC(298)