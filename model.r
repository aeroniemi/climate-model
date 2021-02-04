# ------------------------------------------------------------------------------
# model.r
# This contains the core of the model
# It is expected that the majority of functions should be contained in other
# files
# ------------------------------------------------------------------------------
source("config.r")
source("functions.r")


# ------------------------------------------------------------------------------
# Calculate starting albedo temps
# ------------------------------------------------------------------------------
CONSTS$zeroAlbedoTemp <- ((CONSTS$solar / (4 * CONSTS$stefan)) ^ (1 / 4))
CONSTS$albedoTemp <- ((CONSTS$solar * (1 - config$initialAlbedo) / (4 * CONSTS$stefan)) ^ (1 / 4))
print("Albedo-only temperature is:")
print(kToC(CONSTS$albedoTemp))
# ------------------------------------------------------------------------------
#  Calculate greenhouse effect at t=0
# ------------------------------------------------------------------------------
gasTemp <- (config$initialTemp - CONSTS$albedoTemp)
earthTemp <- (CONSTS$albedoTemp + gasTemp)
print("New earth starting temperature is:")
print(kToC(earthTemp))


year <- numeric(config$runYears)
CO2 <- numeric(config$runYears)
gasEffect <- numeric(config$runYears)

year[1] <- config$startYear
CO2[1] <- config$initialCO2
gasEffect[1] <- gasTemp
for (i in 2:config$runYears) {
  year[i] = year[i - 1] + 1
  CO2[i] = CO2[i - 1] * 1.01
  gasEffect[i] = (CO2[i]-config$initialCO2) * config$CO2sens + gasTemp
}

plot(year, kToC(gasEffect + CONSTS$albedoTemp), type = "l", ylab = "Temp", xlab = "Year", main = "CO2 concentration from 2000 to 2100")
mydata <- data.frame(year, CO2, gasEffect, kToC(gasEffect + CONSTS$albedoTemp))
