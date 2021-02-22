# ------------------------------------------------------------------------------
# Run a model using the default config
# ------------------------------------------------------------------------------
# a1 = runModel()
# plot(a1$year, a1$toCelcius(a1$earTemp), type = "l", ylab = "Temp", xlab = "Year", main = paste("Earth temperature from", a1$year[1], "to", a1$year[CONFIG$runYears]))
a3 = runMultipleModels(list(
    a = list(
        title = "No Cryo",
        colour = "#ff00ff",
        identifer = 2,
        config = list(enableCryo = FALSE)
    ),
    b=list(
        title = "No Veg",
        colour = "#ffff00",
        identifer = 3,
        config = list(enableVeg = FALSE)
    ),
    c=list(
        title = "No Cryo or Veg",
        colour = "#ffff00",
        identifer = 4,
        config = list(enableVeg = FALSE, enableCryo = FALSE)
    ),
    d=list(
        title = "Normal",
        colour = "#ffff00",
        identifer = 5,
        config = list()
    )
    ))

library(tidyverse)
print(gf_line(TEMP$toCelcius(earTemp)~year, color=~title, data=a3, ylab = "Earth Mean Temperature/C"))