# ------------------------------------------------------------------------------
# model.r
# This contains the core of the model
# It is expected that the majority of functions should be contained in other
# files
# ------------------------------------------------------------------------------
source("functions.r")
source("config.r")

# ------------------------------------------------------------------------------
# Run the period loop
# ------------------------------------------------------------------------------
for (key in 2:CONFIG$runYears) {
  # ----------------------------------------------------------------------------
  #* Advance core params
  # ----------------------------------------------------------------------------
  # Advance the year
  TS$year[key] = TS$year[key - 1] + 1
  # Advance CO2
  TS$co2[key] = calculateCo2(TS$co2[key - 1])
  # Advance albedo
  TS$albedo[key] = calculateAlbedo(TS$earTemp[key - 1], TS$earTemp[key - 2], TS$albedo[key - 1])
  # ------------------------------------------------------------------------------
  #* Calculate sub-temperatures
  # ------------------------------------------------------------------------------
  # Calculate new albedo temp
  TS$albTemp[key] = calculateAlbedoTemp(TS$albedo[key])
  # Calculate new CO2 temp
  TS$co2Temp[key] = calculateCo2Temp(TS$co2[key])
  # ----------------------------------------------------------------------------
  #* Calculate final temperature
  # ----------------------------------------------------------------------------
  TS$earTemp[key] = TS$albTemp[key] + TS$co2Temp[key]
}
plot(TS$year, TEMP$toCelcius(TS$earTemp), type = "l", ylab = "Temp", xlab = "Year", main = paste("Earth temperature from", TS$year[1], "to", TS$year[CONFIG$runYears]))
