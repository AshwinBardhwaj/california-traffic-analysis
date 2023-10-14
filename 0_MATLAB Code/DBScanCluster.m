%==========================================================================
% File      : DBScanCluster.m
% Project   : Math Challange
% Detail    : Create cluster based on the given data using density based 
%             clustering algorithm
% Autor     : Ashwin Bardhwaj
%
% @Copyright reserved @2021  
%==========================================================================
classdef DBScanCluster < handle
    % Predictive model using density based clustering algorithm
    
    properties
        % accident data
        Data;     

        % accident data
        LatLngData;     

        % Cluster Index List
        ClusterIndexList;

        % Cluster Size List
        ClusterSizeList;

        %optimal Epsilon
        OptimalEpsilon;       
    end

    methods
        function obj = DBScanCluster(data, minPoints, maxPoints)
             obj.Data = data;
             obj.LatLngData = cell2mat(data(:,1:2));
             
             %Calculate Optimal epsilon for the given data
             obj.OptimalEpsilon = clusterDBSCAN.estimateEpsilon(obj.LatLngData, minPoints, maxPoints);
        end              
       
        function Execute(obj, minNumOfPoints)
             % Performing density base clustering
             % input data - data, min number of Points
             obj.ClusterIndexList = dbscan(obj.LatLngData, obj.OptimalEpsilon, minNumOfPoints); 
             obj.ClusterSizeList = UpdateClusterSize(obj, obj.ClusterIndexList);
        end

        function clusterSizeList = UpdateClusterSize(obj, clusterIndexList)
            % Calulate size of each cluster
            % input - array of cluster numbers
            % output - array of size of each cluster
            clusterSizeList = zeros(max(clusterIndexList),1);
            for i = 1:size(obj.LatLngData)
                 clusternumber = clusterIndexList(i);
                if(clusternumber ~= -1)
                   clusterSizeList(clusternumber) = clusterSizeList(clusternumber) + 1; 
                end
            end      
        end      

        function Plot(obj)
            % Create a Scatter Plot           
            gscatter(obj.LatLngData(:,1), obj.LatLngData(:,2), obj.ClusterIndexList)            
        end       

        function biggestClusterIndex = GetBiggestClusterIndex(obj)
            % return the index of the biggest Cluster
            
            % Get the index of the BiggestcCluster
            biggestClusterIndexList = find(obj.ClusterSizeList == max(obj.ClusterSizeList));
            biggestClusterIndex = biggestClusterIndexList(1,1); 
        end

        function clusterData = GetCluster(obj, index)
            % return the Data for a particular cluster index 

            clusterData = cell(obj.ClusterSizeList(index), 13);
            j = 1;
            for i = 1:size(obj.ClusterIndexList)
                if obj.ClusterIndexList(i) == index
                   clusterData(j,:) = obj.Data(i,:);
                   j = j +1;
                end
            end
        end
        
        function PlotClusterData(~, data, indexList)
            % Create a Scatter Plot     
            latlngData = cell2mat(data(:,1:2));
            gscatter(latlngData(:,1), latlngData(:,2), indexList)            
        end  
    end
end