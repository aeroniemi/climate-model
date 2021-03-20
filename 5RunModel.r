# ------------------------------------------------------------------------------
# Operational model function
# ------------------------------------------------------------------------------
runModel = function(inConfig = list()) {
	localConfig = modifyList(CONFIG, inConfig)
	# ------------------------------------------------------------------------------
	#~ Init vectors
	# ------------------------------------------------------------------------------
	localConfig$runYears = localConfig$runYears+1
	TS <- data.frame(
		year = numeric(localConfig$runYears),
		anthCO2 = numeric(localConfig$runYears),
		oceanCO2 = numeric(localConfig$runYears),
		permaForcing = numeric(localConfig$runYears),
		fertCO2Forcing = numeric(localConfig$runYears),
		vegChange = numeric(localConfig$runYears),
		cloudChange = numeric(localConfig$runYears), 
		albedo = numeric(localConfig$runYears),
		albTemp = numeric(localConfig$runYears),
		co2Temp = numeric(localConfig$runYears),
		forTemp = numeric(localConfig$runYears),
		earTemp = numeric(localConfig$runYears)
	)
	# set start values
	TS$year[1] = localConfig$startYear
	TS$anthCO2[1] = localConfig$initialCO2
	TS$albedo[1] = localConfig$initialAlbedo
	# calculate initial temperatures
	TS$albTemp[1] = calculateAlbedoTemp(localConfig$initialAlbedo)
	TS$co2Temp[1] = localConfig$initialTemp - TS$albTemp[1]
	TS$earTemp[1] = TS$albTemp[1] + TS$co2Temp[1]
	# check initial earth temp matches the expectation
	stopifnot(TS$earTemp[1] == localConfig$initialTemp)
	
	for (key in 2:localConfig$runYears) {
		# ----------------------------------------------------------------------------
		#* Advance core params
		# ----------------------------------------------------------------------------
		# Advance the year
		TS$year[key] = TS$year[key - 1] + 1
		# Advance Anthropogenic CO2
		TS$anthCO2[key] = calculateAnthCO2(TS$anthCO2[key - 1], localConfig)
		# Advance vegitation
		TS$vegChange[key] = calculateVegChange(TS$earTemp[key - 1], TS$earTemp[key - 2], localConfig)
		# Advance cloud
		TS$cloudChange[key] = calculateCloudChange(TS$earTemp[key - 1], TS$earTemp[key - 2], localConfig)
		# Advance ocean CO2
		TS$oceanCO2[key] = calculateOceanCO2(TS$earTemp[key - 1], localConfig)
		# Advance permafrost forcing
		TS$permaForcing[key] = calculatePermaForcing(TS$earTemp[key - 1], localConfig)
		# Advance CO2 fertilisation forcing
		TS$fertCO2Forcing[key] = calculateFertCO2Forcing(TS$earTemp[key - 1], localConfig)
		# Advance albedo
		TS$albedo[key] = calculateAlbedo(TS$earTemp[key - 1], TS$earTemp[key - 2], TS$albedo[key - 1], TS[key,], localConfig)
		# ------------------------------------------------------------------------------
		#* Calculate sub-temperatures
		# ------------------------------------------------------------------------------
		# Calculate new albedo temp
		TS$albTemp[key] = calculateAlbedoTemp(TS$albedo[key], localConfig)
		# Calculate new CO2 temp
		TS$co2Temp[key] = calculateCo2Temp(TS[key,],TS$albTemp[1], localConfig)
		# Calculate new forcings temp
		TS$forTemp[key] = calculateForcingTemp(TS[key,],TS$albTemp[1], localConfig)
		# ----------------------------------------------------------------------------
		#* Calculate final temperature
		# ----------------------------------------------------------------------------
		TS$earTemp[key] = TS$albTemp[key] + TS$co2Temp[key] + TS$forTemp[key]
	}
	return(TS)
}

# ------------------------------------------------------------------------------
# Run multiple attempts at the model
# ------------------------------------------------------------------------------
runMultipleModels = function(configurations) {
	results = data.frame()
	for (key in configurations) {
		mres = runModel(key$config)
		mres$title = key$title
		mres$colour = key$colour
		mres$identifier = key$identifer
		
		rbind(results, mres) -> results
	}
	return(results)
}