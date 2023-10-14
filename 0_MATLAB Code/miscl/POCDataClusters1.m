accLatLongCoord = readmatrix("ashba_LocationDataWithFactors_Active.xlsx");
accLatLongCoord(:,3:12) = [];
%clusterer = HDBSCAN(accLatLongCoord);
%clusterer.fit_model();
%clusterer.get_best_clusters();
%clusterer.minpts = 5;
%clusterer.minclustsize = 70;
%clusterer.minClustNum = 50;
%clusterer.outlierThresh = 0.85;
%clusterer.fit_model();
%clusterer.get_best_clusters();
%clusterer.get_membership();
%clusterer.score;
%clusterer.run_hdbscan(10,70,1,3);
%clusterer.get_membership();

%clusterer.plot_clusters();
%clusterer.plot_tree();
estimatepsilon = clusterDBSCAN.estimateEpsilon(accLatLongCoord,15,20);
clusterIndexList = dbscan(accLatLongCoord,estimatepsilon,17);
gscatter(accLatLongCoord(:,1),accLatLongCoord(:,2),clusterIndexList)
%clusterNumAcc = findNumAccPerCluster(accLatLongCoord,clusterIndexList)
%postalcode = google_ReverseGeoCodeAddress(accLatLongCoord(9133,1),accLatLongCoord(9133,2));

