baseProjectDataDir = "Y:\59_MTFC Math Competition\Project Data\";
accDatafileName = baseProjectDataDir + "ashba_LocationDataWithFactorsZipCode_Active.xlsx";
data = readcell(accDatafileName);

dbScanCluster = DBScanCluster(data, 15, 20);
dbScanCluster.Execute(20);
dbScanCluster.Plot()