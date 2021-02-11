# ------------------------------------------------------------------------------
# model.r
# This contains the core of the model
# It is expected that the majority of functions should be contained in other
# files
# ------------------------------------------------------------------------------
source("functions.r")
source("config.r")


for (key in 2:CONFIG$runYears) {
  # advance the year
  TS$year[key] = TS$year[key - 1] + 1
  # advance CO2
  TS$co2[key] = TS$co2[key - 1] * CONFIG$co2Increase
  # advance albedo
  TS$albedo[key] = calculateAlbedo(TS$earTemp[key - 1], TS$earTemp[key - 2], TS$albedo[key - 1])
  # calculate new albedo temp
  TS$albTemp[key] = calculateAlbedoTemp(TS$albedo[key])
  # calculate new CO2 warming
  co2TempAddition = CONFIG$CO2sens * (TS$co2[key] - TS$co2[key - 1])
  TS$co2Temp[key] = TS$co2Temp[key - 1] + co2TempAddition
  # give final temperature value
  TS$earTemp[key] = TS$albTemp[key] + TS$co2Temp[key]
}
plot(TS$year, TEMP$toCelcius(TS$earTemp), type = "l", ylab = "Temp", xlab = "Year", main = paste("Earth temperature from", TS$year[1], "to", TS$year[CONFIG$runYears]))
