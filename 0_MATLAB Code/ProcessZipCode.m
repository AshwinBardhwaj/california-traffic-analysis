%==========================================================================
% File      : ProcessZipCode.m
% Project   : Math Challange
% Detail    : Process zipcode data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef ProcessZipCode < handle
    % Process zipcode in a Data set

    properties
        Data;
    end

    methods
        function obj = ProcessZipCode(data)           
            obj.Data = data;    
        end

        function [uniqueZipCode, uniqueZipCodeFreq] = GetUniqueZipCode(obj)
        
            % Get Unique zipcode Array
            zipcodeArray = cell2mat(obj.Data(:,13));
            newtable = table(zipcodeArray);
            zipcodegroupCountTable  = groupcounts(newtable, 'zipcodeArray');
            
            uniqueZipCode = zipcodegroupCountTable{:,{'zipcodeArray'}};
            uniqueZipCodeFreq = zipcodegroupCountTable{:,{'GroupCount'}};             
        end  

        function zipCodeData = GetAccDataInAZipCode(obj, zipcode, zipcodeDataSize)
            % Get rows of data for a zipcode

            % filter out the zipcode column
            zipcodeArray = cell2mat(obj.Data(:,13));   

            zipCodeData = cell(zipcodeDataSize, 13);

            j = 1;
            for i = 1 : size(obj.Data)
                 if zipcodeArray(i) == zipcode
                    zipCodeData(j,:) = obj.Data(i,:);
                    j = j+1;
                 end
            end            
         end

    end
end