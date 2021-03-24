# ------------------------------------------------------------------------------
# Run a model using the default config
# ------------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------
# Data tidying
# ------------------------------------------------------------------------------
# format the a2 table to fit the requirements
a3$earTemp = a3$earTemp - CONFIG$initialTemp
a4 = subset(a3, select = c(year, title, earTemp)) # final temp by model
a5 <- reshape(a4, idvar = "year", timevar = "title", direction = "wide", v.names="earTemp") # intergrated model results
colnames(a5) <- sub("earTemp\\.", "", colnames(a5))
# a5 <- spread(a4, title, earTemp) # intergrated model results (uses tidyr, better method but not vanilla, comment 113, 114) 
a6 = subset(a3, select = c(year, title, tcr), tcr > 0) # tcr by model

# ------------------------------------------------------------------------------
#! Chart drawing setup
#! Although not required, the following section uses common libraries to draw 
#! plots used in the associated report. The associated code can be run by 
#! uncommenting these lines. Raw results can be found in tables a2-a6.
# ------------------------------------------------------------------------------
# #import chart libraries
# library(tidyverse)

# # ------------------------------------------------------------------------------
# # Figure 1
# # control/cf/pf alone forcing sensitivity study
# # ------------------------------------------------------------------------------
# figure1 = ggplot(a5, aes(year-2000)) + 
#   geom_ribbon(aes(ymin=cfNlMin, ymax=cfMean),fill=rgb(191/255, 191/255, 191/255))+
#   geom_line(aes(y=Control, color=c("Control")), color=rgb(0,0,0), size=1) +
#   geom_line(aes(y=cfNlMean, color=c("cfNlMean")), color= rgb(112/255,160/255,205/255), size=1) + 
#   geom_ribbon(aes(ymin=pfMin, ymax=pfMax),fill=rgb(191/255, 191/255, 191/255))+
#   geom_line(aes(y=pfMean, color=c("cfNlMean")), color= rgb(196/255,121/255,0/255), size=1) +
#   theme_bw() +
#   scale_y_continuous(position = "right", expand = expansion(mult = c(0, 0   )), breaks=seq(0,9, 0.5),limits=c(NA, 9))+
#   scale_x_continuous( expand = expansion(mult = c(0, .0)),  breaks=seq(0,100, 10))+
#   xlab("Years since model start")+
#   ylab(expression('Temperature Change /'~degree*'C'))+
#   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# print(figure1)
# # ------------------------------------------------------------------------------
# # Figure 1
# # alpha sensitivity study
# # ------------------------------------------------------------------------------
# figure2 = ggplot(a5, aes(year-2000)) + 
#   geom_ribbon(aes(ymin=forMin, ymax=forMax),fill=rgb(191/255, 191/255, 191/255))+
#   geom_line(aes(y=Control, color=c("Control")), color=rgb(0,0,0), size=1) +
#   geom_line(aes(y=com, color=c("cfNlMean")), color= rgb(196/255,121/255,0/255), size=1) + 
#   geom_line(aes(y=comNl, color=c("cfNlMean")), color= rgb(112/255,160/255,205/255), size=1) + 
#   theme_bw() +
#   scale_y_continuous(position = "right", expand = expansion(mult = c(0, 0)), breaks=seq(0,9, 0.2),limits=c(NA, 4.800001))+
#   scale_x_continuous( expand = expansion(mult = c(0, .0)),  breaks=seq(0,100, 10))+
#   xlab("Years since model start")+
#   ylab(expression('Temperature Change /'~degree*'C'))+
#   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# print(figure2)