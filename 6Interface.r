# ------------------------------------------------------------------------------
# Run a model using the default config
# ------------------------------------------------------------------------------
# a1 = runModel()
# plot(a1$year, a1$toCelcius(a1$earTemp), type = "l", ylab = "Temp", xlab = "Year", main = paste("Earth temperature from", a1$year[1], "to", a1$year[CONFIG$runYears]))
a3 = runMultipleModels(list(
    cfMax = list(
        title = "cfMax",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -1.0,
            permaForcingSens = 0.00
        )
    ),
    cfNlMean = list(
        title = "cfNlMean",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.7,
            permaForcingSens = 0.00
        )
    ),
    cfNlMin = list(
        title = "cfNlMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.5,
            permaForcingSens = 0.00
        )
    ),
    pfMax = list(
        title = "pfMax",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.25
        )
    ),
    pfMean = list(
        title = "pfMean",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.16
        )
    ),
    pfMin = list(
        title = "pfMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.10
        )
    ),
    forMax = list(
        title = "forMax",
        identifer = 1,
        config = list(
            cliFeedbackParam = 4.0/2.96,
            fertCO2Sens = -0.7,
            permaForcingSens = 0.16
        )
    ),
    forMin = list(
        title = "forMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 2.0/4.44,
            fertCO2Sens = -0.7,
            permaForcingSens = 0.16
        )
    ),
    com = list(
        title = "com",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -1.0,
            permaForcingSens = 0.16
        )
    ),
    comNl = list(
        title = "comNl",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.7,
            permaForcingSens = 0.16
        )
    ),
    control = list(
        title = "Control",
        identifer = 1,
        config = list(
            cliFeedbackParam = 3.0/3.70,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.00
        )
    )
))
a4 = subset(a3, select = c(year, title, earTemp))
a5 <- spread(a4, title, earTemp)
# a4 <- spread(a3, title, earTemp)
# a4 <- subset(spread(a3, title, earTemp), cfNlMean == NA)

library(tidyverse)
# print(gf_ribbon(forMax+forMin~year,  data=a5, ylab = "Earth Mean Temperature/C"))

figure1 = gf_ribbon(cfMax+cfNlMin~year,fill=rgb(204/255, 174/255, 113/255),  data=a5) %>%
gf_ribbon(forMax+forMin~year,fill=rgb(91/255, 174/255, 178/255), data=a5) %>%
gf_ribbon(pfMax+pfMin~year,fill=rgb(191/255, 191/255, 191/255),  data=a5) %>%
gf_line(Control~year,color=rgb(0/255, 0/255, 0/255), data=a5) %>%
gf_line(pfMean~year,color=rgb(112/255, 160/255, 205/255),  data=a5)%>%
gf_line(cfNlMean~year,color=rgb(196/255, 121/255, 0/255),  data=a5) %>%
gf_theme(theme_bw())
print(figure1)

#%>%gf_theme(theme_bw())
# figure1 = ggplot(data=a3, aes(x=year-2000, y=earTemp-CONFIG$initialTemp, ymin=0, ymax=10)) + 
#  geom_line() + 
#  geom_ribbon(alpha=0.5)
#  print(figure1)

print(gf_line(earTemp-CONFIG$initialTemp~year, color=~title, data=a3, ylab = "Earth Mean Temperature/C")%>%gf_theme(theme_bw()))
