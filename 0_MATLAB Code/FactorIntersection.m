%==========================================================================
% File      : FactorIntersection.m
% Project   : Modelling the future Challange
% Detail    : Factor 'Drunk Driving' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef FactorIntersection < handle
    % Create Freqncy diagram array for Intersection totalzipcode x Intersection
    % rows : zipcodes, columns : intersection
    % Drunk driving :
    %     1 - Not an intersection
    %     2 - fourway intersection
    %     3 - T intersection
    % [zipcode, not-Intersection, Intersection] 

    properties
        Data;          

        FactorValues = {1, 2, 3}
        FactorCategoryValue = [1, 2, 3]
        ColumnIndexInData = 10;
        
        FactorFrequency;
        FactorAverage;
    end

    methods

        function obj = FactorIntersection(data)           
            obj.Data = data;           
        end

        function frequencyofIntersection = UpdateFrequency(obj)
            % Get Unique zipcode Array
            processZipCode = ProcessZipCode(obj.Data);
            [uniqueZipcode, uniquezipcodeDataSize] = processZipCode.GetUniqueZipCode();
        
            % Get freqency diagram for factor
            [rowSize,~] = size(uniqueZipcode);
            [~,colSize] = size(obj.FactorValues);
            colSize = colSize + 2;
            frequencyofIntersection = zeros(rowSize, colSize);            
        
            for i = 1 : rowSize         
                 %Get a list of accident data for a zipcode
                 accDataInAzipcode = processZipCode.GetAccDataInAZipCode(uniqueZipcode(i), uniquezipcodeDataSize(i));
                 
                 frequencyofIntersection(i,:) = GetFreqDataforZipCode(obj, accDataInAzipcode, uniqueZipcode(i), colSize);
            end  
        
            % Delete the unwanted zipcode Rows
            frequencyofIntersection = Utility.RemoveZipCodeFromFactorData(frequencyofIntersection);

            obj.FactorFrequency = frequencyofIntersection(:,:);
        
        end         
       

         function avgData = UpdateAverageStatistics(obj)
            
            % Calculate avergae of factor for each zipcode
            
            avgData = Utility.UpdateAverageStatistics(obj.FactorFrequency, obj.FactorCategoryValue);
            obj.FactorAverage = avgData(:,:);         
         end

         function freqData = GetFreqDataforZipCode(obj, accDataInAzipcode, zipcode, colSize)
            % Get frequency data for lightcondition based on zipcode          
            colIndex = obj.ColumnIndexInData;  

            freqData = zeros(1, colSize);
            freqData(1,1) = zipcode;                      

            intersectionArray = cell2mat(accDataInAzipcode(:,colIndex));

            for i = 1 : size(intersectionArray) 
                 switch intersectionArray(i)
                     case obj.FactorValues(1)                    
                        freqData(1,2) = freqData(1,2) + 1;
                     case obj.FactorValues(2)               
                        freqData(1,3) = freqData(1,3) + 1; 
                     case obj.FactorValues(3)               
                        freqData(1,4) = freqData(1,4) + 1;  
                    otherwise                    
                        freqData(1,5) = freqData(1,5) + 1;
                 end
             end           
         end
        
        
         function factorFreqTable = GetFrequencyTable(obj)

            % Create a printable data for factor frequency with average data
           
            % Add average data column to factor frequency
            factorFrequency(:,:) = obj.FactorFrequency(:,:);
            factorFrequency(:, width(factorFrequency)+1) = obj.FactorAverage;

            % Create a FactorFreqency Table for the factor
            header = {'ZipCode', 'Not an Intersection', 'FourWay', 'T -Intersection', 'UnKnown', 'Average'};

            % Create a FactorFreqency Table for the factor            
            factorFreqTable = [ header; num2cell(factorFrequency)];
           
         end

      end
end