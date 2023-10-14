classdef DBScanCluster 
    % Predictive model using density based clustering algorithm
    
    properties
        % accident data
        Data;     

        %optimal Epsilon
        OptimalEpsilon;       
    end

    methods
        function obj = DBScanCluster(data, minPoints, maxPoints)
             obj.Data = data;
             
             %Calculate Optimal epsilon for the given data
             obj.OptimalEpsilon = clusterDBSCAN.estimateEpsilon(obj.Data, minPoints, maxPoints);
        end              
       
        function clusterIndexList = Execute(obj, minNumOfPoints)
             % Performing density base clustering
             % input data - data, min number of Points
             clusterIndexList = dbscan(obj.Data, obj.OptimalEpsilon, minNumOfPoints);             
        end

        function [biggestClusterIndex, size] = GetBiggestClusterIndex(clusterSizeList)
            % return the index of the biggest Cluster
            
            % Get the index of the BiggestcCluster
            size = max(clusterSizeList);
            biggestClusterIndexList = find(clusterSizeList == size);
            biggestClusterIndex = biggestClusterIndexList(1,1); 
        end

        function clusterData = GetCluster(obj, clusterIndexList, index, size)
            % return the Data for a particular cluster index 

            clusterData = zeros(size, 1);
            j = 1;
            for i = 1:size(clusterIndexList)
                if clusterIndexList(i) == index
                   clusterData(j) = obj.Data(i);
                   j = j +1;
                end
            end
        end

%         function biggestClusterData = GetBiggestCluster(obj, clusterIndexList, clustersizeList)
%             % return the Data of the biggest Cluster
%             
%             % Get the index of the BiggestcCluster
%             biggestClusterIndexList = find(clusterSizeList == max(clusterSizeList));
%             biggestClusterIndex = biggestClusterIndexList(1,1);
%             
%             biggestClusterData = zeros(clustersizeList(biggestClusterIndex), 1);
%             j = 1;
%             for i = 1:size(clusterIndexList)
%                 if clusterIndexList(i) == biggestClusterIndex
%                    biggestClusterData(j) = obj.Data(i);
%                    j = j +1;
%                 end
%             end
%         end

        function clustersizeList = getClusterSize(obj, clusterIndexList)
            % Calulate size of each cluster
            % input - array of cluster numbers
            % output - array of size of each cluster
            clustersizeList = zeros(max(clusterIndexList),1);
            for i = 1:size(obj.Data)
                 clusternumber = clusterIndexList(i);
                if(clusternumber ~= -1)
                   clustersizeList(clusternumber) = clustersizeList(clusternumber) + 1; 
                end
            end      
        end

        function Plot(obj, clusterIndexList)
            % Create a Scatter Plot           
            gscatter(obj.Data(:,1), obj.Data(:,2), clusterIndexList)            
        end      
    end
end