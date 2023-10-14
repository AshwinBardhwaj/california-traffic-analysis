%==========================================================================
% File      : POCDataClusters.m
% Project   : Modelling the future Challange
% Detail    : This is the main code.
%             Analying the eefct of light conditions, factor 2 on the 
%             number of accidents in the Saceremento and LA Clusters
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================

% Constant declaration ----------------------------------------------------
baseProjectDataDir = "Y:\59_MTFC Math Competition\Project Data\";
accDatafileName = baseProjectDataDir + "ashba_LocationDataWithFactorsZipCode_Active.xlsx";
LightconditionFreqDataFilename = baseProjectDataDir + "Factor_LightCondition_FreqData.xlsx";
WeatherFreqDataFilename = baseProjectDataDir + "Factor_Weather_FreqData.xlsx";
DrunkDrivingDataFilename = baseProjectDataDir + "Factor_DrunkDriving_FreqData.xlsx";
IntersectionDataFilename = baseProjectDataDir + "Factor_Intersection_FreqData.xlsx";
SeasonDataFilename = baseProjectDataDir + "Factor_Season_FreqData.xlsx";
RandomForestInputTableFilename = baseProjectDataDir + "Input_For_RandomForest.xlsx";

% Cleanup -----------------------------------------------------------------
Utility.DeleteFile(LightconditionFreqDataFilename);
Utility.DeleteFile(WeatherFreqDataFilename);
Utility.DeleteFile(DrunkDrivingDataFilename);
Utility.DeleteFile(IntersectionDataFilename);
Utility.DeleteFile(SeasonDataFilename);
Utility.DeleteFile(RandomForestInputTableFilename);

% Read the accident data from file to a matrix-----------------------------
data = readcell(accDatafileName);

% Instantiate the cluster algorithm ---------------------------------------
dbScanCluster = DBScanCluster(data, 15, 20);
dbScanCluster.Execute(17);
dbScanCluster.Plot();

% Get the Data for biggest cluster ---------------------------------------- 
biggestClusterIndex = dbScanCluster.GetBiggestClusterIndex();
biggestClusterData = dbScanCluster.GetCluster(biggestClusterIndex);
indexList = biggestClusterIndex * ones(size(biggestClusterData, 1));
dbScanCluster.PlotClusterData(biggestClusterData, indexList);

% Create Freq data for 'Light Conditions' in Cluster 1 --------------------
lightCondition = FactorLightCondition(biggestClusterData);

lightCondition.UpdateFrequency();
avgLightConditionArray = lightCondition.UpdateAverageStatistics();

factorLightConditionFreqData = lightCondition.GetFrequencyTable();
writecell(factorLightConditionFreqData, LightconditionFreqDataFilename);


% Create Freq data for 'Weather' in Cluster 1 -----------------------------
weather = FactorWeather(biggestClusterData);

weather.UpdateFrequency();
avgWeatherArray = weather.UpdateAverageStatistics();

factorWeatherFreqData = weather.GetFrequencyTable();
writecell(factorWeatherFreqData, WeatherFreqDataFilename);


% Create Freq data for 'Drunk Driving' in Cluster 1 -----------------------
drunkdriving = FactorDrunkDriving(biggestClusterData);

drunkdriving.UpdateFrequency();
avgDrunkDrivingArray = drunkdriving.UpdateAverageStatistics();

factordrunkDrivingFreqData = drunkdriving.GetFrequencyTable();
writecell(factordrunkDrivingFreqData, DrunkDrivingDataFilename);


% Create Freq data for 'Intersection' in Cluster 1 ------------------------
intersection = FactorIntersection(biggestClusterData);

intersection.UpdateFrequency();
avgIntersectionArray = intersection.UpdateAverageStatistics();

factorIntersectionFreqData = intersection.GetFrequencyTable();
writecell(factorIntersectionFreqData, IntersectionDataFilename);
 

% Create Freq data for 'Season' in Cluster 1 -------------------------------
season = FactorSeason(biggestClusterData);

season.UpdateFrequency();
modeSeasonArray = season.UpdateModeStatistics();

factorSeasonFreqData = season.GetFrequencyTable();
writecell(factorSeasonFreqData, SeasonDataFilename);


% Create Data for RandomForest --------------------------------------------

% Get Unique zipcode Array
processZipCode = ProcessZipCode(biggestClusterData);
[zipcodeArray, accPerZipCodeArray] = processZipCode.GetUniqueZipCode();
zipcodeArray = Utility.RemoveZipCodeFromFactorData(zipcodeArray);
accPerZipCodeArray = Utility.RemoveZipCodeFromFactorData(accPerZipCodeArray);

% RandomForestInputTabl
inputArray = [ zipcodeArray, accPerZipCodeArray, avgLightConditionArray, avgWeatherArray, avgDrunkDrivingArray, avgIntersectionArray, modeSeasonArray];

% Create a inputTable for Random forest
header = {'ZipCode', 'x_Accidents', 'Avg Light Condition', ' Avg Weather', 'Avg Drunk Driving', 'Avg Intersection Type', 'Mode of Season'};             
inputTable = [ header; num2cell(inputArray)];
writecell(inputTable, RandomForestInputTableFilename);