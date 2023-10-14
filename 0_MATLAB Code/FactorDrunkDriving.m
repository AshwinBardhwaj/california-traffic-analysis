%==========================================================================
% File      : FactorDrunkDriving.m
% Project   : Modelling the future Challange
% Detail    : Factor 'Drunk Driving' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef FactorDrunkDriving < handle
    % Create Freqncy diagram array for LightCondition totalzipcode x lightcondition
    % rows : zipcodes, columns : drunk driving
    % Drunk driving :
    %     0 - Not due to drunk driving
    %     1 - due to drunk driving
    % [zipcode, not-drunkdriving, drunkdriving] 

    properties
        Data;          

        FactorValues = [0, 1];
        FactorCategoryValue = [1, 2];
                
        ColumnIndexInData = 5;
        
        FactorFrequency;
        FactorAverage;
    end

    methods

        function obj = FactorDrunkDriving(data)           
            obj.Data = data;           
        end

        function frequencyofDrunkDriving = UpdateFrequency(obj)
            % Get Unique zipcode Array
            processZipCode = ProcessZipCode(obj.Data);
            [uniqueZipcode, uniquezipcodeDataSize] = processZipCode.GetUniqueZipCode();
        
            % Get freqency diagram for factor
            [rowSize,~] = size(uniqueZipcode);
            [~,colSize] = size(obj.FactorValues);
            colSize = colSize + 2;
            frequencyofDrunkDriving = zeros(rowSize, colSize);            
        
            for i = 1 : rowSize         
                 %Get a list of accident data for a zipcode
                 accDataInAzipcode = processZipCode.GetAccDataInAZipCode(uniqueZipcode(i), uniquezipcodeDataSize(i));
                 
                 frequencyofDrunkDriving(i,:) = GetFreqDataforZipCode(obj, accDataInAzipcode, uniqueZipcode(i), colSize);
            end  
        
            % Delete the unwanted zipcode Rows
            frequencyofDrunkDriving = Utility.RemoveZipCodeFromFactorData(frequencyofDrunkDriving);

            obj.FactorFrequency = frequencyofDrunkDriving(:,:);
        
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

            drunkDrivingArray = cell2mat(accDataInAzipcode(:,colIndex));

            for i = 1 : size(drunkDrivingArray) 
                 switch drunkDrivingArray(i)
                     case obj.FactorValues(1)                    
                        freqData(1,2) = freqData(1,2) + 1;
                     case obj.FactorValues(2)               
                        freqData(1,3) = freqData(1,3) + 1;                                            
                    otherwise                    
                        freqData(1,4) = freqData(1,4) + 1;
                 end
             end           
         end


         function factorFreqTable = GetFrequencyTable(obj)

            % Create a printable data for factor frequency with average data
           
            % Add average data column to factor frequency
            factorFrequency(:,:) = obj.FactorFrequency(:,:);
            factorFrequency(:, width(factorFrequency)+1) = obj.FactorAverage;

            % Create a FactorFreqency Table for the factor
            header = {'ZipCode', 'No Drunk Drving', 'Drunk Drving', 'UnKnown', 'Average'};

            % Create a FactorFreqency Table for the factor            
            factorFreqTable = [ header; num2cell(factorFrequency)];
           
         end


    end        
end