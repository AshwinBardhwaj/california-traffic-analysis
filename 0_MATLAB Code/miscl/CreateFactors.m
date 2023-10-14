factor = readmatrix("ashba_LocationDataWithFactors_Active.xlsx");
factorsOfCluster = zeros(max(idx),5);
for i = 1:size(factor)
    clusterNum = idx(i);
    if (clusterNum ~= -1)
    factorsOfCluster(clusterNum,1) = factorsOfCluster(clusterNum,1) + factor(i,5);
    factorsOfCluster(clusterNum,2) = factorsOfCluster(clusterNum,2) + factor(i,7);
    factorsOfCluster(clusterNum,3) = factorsOfCluster(clusterNum,3) + factor(i,8);
    factorsOfCluster(clusterNum,4) = factorsOfCluster(clusterNum,4) + factor(i,10);
    factorsOfCluster(clusterNum,5) = factorsOfCluster(clusterNum,5) + factor(i,11);
    end
end
for i = 1:size(factorsOfCluster)
    factorsOfCluster(i,1) = factorsOfCluster(i,1)/clusterNumAcc(i);
    factorsOfCluster(i,2) = factorsOfCluster(i,2)/clusterNumAcc(i);
    factorsOfCluster(i,3) = factorsOfCluster(i,3)/clusterNumAcc(i);
    factorsOfCluster(i,4) = factorsOfCluster(i,4)/clusterNumAcc(i);
    factorsOfCluster(i,5) = factorsOfCluster(i,5)/clusterNumAcc(i);
end

allFactorData = horzcat(factorsOfCluster,clusterNumAcc);
allFactorDataTable = array2table(allFactorData);
allFactorDataTable.Properties.VariableNames(1:6) = {'Drunk Driving','Light Condition','Milepost','Intersection Type','Month','Number of Accidents'};


function accDataWithFactors = untitled16(inputArg1,inputArg2)
    %UNTITLED16 Summary of this function goes here
    %   Detailed explanation goes here
    outputArg1 = inputArg1;
    outputArg2 = inputArg2;
end