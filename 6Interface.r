# ------------------------------------------------------------------------------
# Run a model using the default config
# ------------------------------------------------------------------------------
# a1 = runModel()
# plot(a1$year, a1$toCelcius(a1$earTemp), type = "l", ylab = "Temp", xlab = "Year", main = paste("Earth temperature from", a1$year[1], "to", a1$year[CONFIG$runYears]))
a3 = runMultipleModels(list(
    cfMean = list(
        title = "cfMean",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -1.05,
            permaForcingSens = 0.00
        )
    ),
    cfNlMean = list(
        title = "cfNlMean",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.65,
            permaForcingSens = 0.00
        )
    ),
    cfNlMin = list(
        title = "cfNlMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.40,
            permaForcingSens = 0.00
        )
    ),
    pfMax = list(
        title = "pfMax",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.35
        )
    ),
    pfMean = list(
        title = "pfMean",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.24
        )
    ),
    pfMin = list(
        title = "pfMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.14
        )
    ),
    forMax = list(
        title = "forMax",
        identifer = 1,
        config = list(
            cliFeedbackParam = 1.45,
            fertCO2Sens = -0.65,
            permaForcingSens = 0.24
        )
    ),
    forMin = list(
        title = "forMin",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.43,
            fertCO2Sens = -0.65,
            permaForcingSens = 0.24
        )
    ),
    com = list(
        title = "com",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -1.05,
            permaForcingSens = 0.24
        )
    ),
    comNl = list(
        title = "comNl",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.65,
            permaForcingSens = 0.24
        )
    ),
    control = list(
        title = "Control",
        identifer = 1,
        config = list(
            cliFeedbackParam = 0.94,
            fertCO2Sens = -0.0,
            permaForcingSens = 0.00
        )
    )
))
a3$earTemp = a3$earTemp - CONFIG$initialTemp
a4 = subset(a3, select = c(year, title, earTemp))
a5 <- spread(a4, title, earTemp)

a6 = subset(a3, select = c(year, title, tcr), tcr > 0)

# a4 <- spread(a3, title, earTemp)
# a4 <- subset(spread(a3, title, earTemp), cfNlMean == NA)

library(tidyverse)
library(directlabels)
library('Cairo')
library(gridExtra)
# CairoWin()
# print(gf_ribbon(forMax+forMin~year,  data=a5, ylab = "Earth Mean Temperature/C"))



#%>%gf_theme(theme_bw())
# figure1 = ggplot(data=a3, aes(x=year-2000, y=earTemp-CONFIG$initialTemp, ymin=0, ymax=10)) + 
#  geom_line() + 
#  geom_ribbon(alpha=0.5)
#  print(figure1)

# print(gf_line(earTemp~year, color=~title, data=a3, ylab = "Earth Mean Temperature/C")%>%gf_theme(theme_bw()))

figure1 = ggplot(a5, aes(year-2000)) + 
  geom_ribbon(aes(ymin=cfNlMin, ymax=cfMean),fill=rgb(191/255, 191/255, 191/255))+
  geom_line(aes(y=Control, color=c("Control")), color=rgb(0,0,0), size=1) +
  geom_line(aes(y=cfNlMean, color=c("cfNlMean")), color= rgb(112/255,160/255,205/255), size=1) + 
  geom_ribbon(aes(ymin=pfMin, ymax=pfMax),fill=rgb(191/255, 191/255, 191/255))+
  geom_line(aes(y=pfMean, color=c("cfNlMean")), color= rgb(196/255,121/255,0/255), size=1) +
  theme_bw() +
  scale_y_continuous(position = "right", expand = expansion(mult = c(0, 0   )), breaks=seq(0,9, 0.5),limits=c(NA, 9))+
#   scale_y_continuous(position = "right", expand = expansion(mult = c(0, .1)), breaks=seq(0,5, 0.25))+
  scale_x_continuous( expand = expansion(mult = c(0, .0)),  breaks=seq(0,100, 10))+
  xlab("Years since model start")+
  ylab(expression('Temperature Change /'~degree*'C'))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

figure2 = ggplot(a5, aes(year-2000)) + 
  geom_ribbon(aes(ymin=forMin, ymax=forMax),fill=rgb(191/255, 191/255, 191/255))+
  geom_line(aes(y=Control, color=c("Control")), color=rgb(0,0,0), size=1) +
  geom_line(aes(y=com, color=c("cfNlMean")), color= rgb(196/255,121/255,0/255), size=1) + 
  geom_line(aes(y=comNl, color=c("cfNlMean")), color= rgb(112/255,160/255,205/255), size=1) + 
  theme_bw() +
  scale_y_continuous(position = "right", expand = expansion(mult = c(0, 0)), breaks=seq(0,9, 0.2),limits=c(NA, 4.800001))+
#   scale_y_continuous(position = "right", expand = expansion(mult = c(0, .1)), breaks=seq(0,5, 0.25))+
  scale_x_continuous( expand = expansion(mult = c(0, .0)),  breaks=seq(0,100, 10))+
  xlab("Years since model start")+
  ylab(expression('Temperature Change /'~degree*'C'))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

print(figure1)
print(figure2)