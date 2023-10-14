function numAccPerCluster = getClusterSize(data,clusterIndex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numAccPerCluster = zeros(max(idx),1);
for i = 1:size(X)
    currIdx = idx(i);
    if (currIdx ~= -1)
    numAccPerCluster(currIdx) = numAccPerCluster(currIdx) + 1;
    end
end
end