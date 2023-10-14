%==========================================================================
% File      : FactorLightCondition.m
% Project   : Modelling the future Challange
% Detail    : Factor 'LightCondition' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef FactorLightCondition < handle
    % Create Freqncy diagram array for LightCondition totalzipcode x lightcondition
    % rows : zipcodes, columns : lightconditions
    % Light Conditions : DUSK, DARK-Not Lighted, Dark-Unknwon, DARK-Lighted, Dawn, DayLight
    % [zipcode, DUSK, DARK-Not Lighted, Dark-Unknwon, DARK-Lighted, Dawn, DayLight] 

    properties
        Data;          

        FactorValues = {'Dusk', 'Dark - Not Lighted', 'Dark - Unkown lighting', 'Dark - Lighted', 'Dawn', 'DayLight'}
        FactorCategoryValue = [1,2,3,4,5,6]   
        ColumnIndexInData = 6;

        FactorFrequency;
        FactorAverage;
    end

    methods

        function obj = FactorLightCondition(data)           
            obj.Data = data;           
        end

        function frequencyofLightCondition = UpdateFrequency(obj)

            % Get frequency data for Light Condition

            % Get Unique zipcode Array
            processZipCode = ProcessZipCode(obj.Data);
            [uniqueZipcode, uniquezipcodeDataSize] = processZipCode.GetUniqueZipCode();

            % Get freqency diagram for Light condition
            [rowSize,~] = size(uniqueZipcode);
            [~,colSize] = size(obj.FactorValues);
            colSize = colSize + 2;
            frequencyofLightCondition = zeros(rowSize, colSize);            

            for i = 1 : rowSize 

                 %Get a list of accidenet dat for a zipcode
                 accDataInAzipcode = processZipCode.GetAccDataInAZipCode(uniqueZipcode(i), uniquezipcodeDataSize(i));
                 
                 frequencyofLightCondition(i,:) = GetFreqDataforZipCode(obj, accDataInAzipcode, uniqueZipcode(i), colSize);
            end              

            % Delete the unwanted zipcode Rows
            frequencyofLightCondition = Utility.RemoveZipCodeFromFactorData(frequencyofLightCondition);
           
            obj.FactorFrequency = frequencyofLightCondition(:,:);           
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

            for i = 1 : size(accDataInAzipcode) 
                 switch true
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(1))==1)                    
                        freqData(1,2) = freqData(1,2) + 1;
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(2))==1)               
                        freqData(1,3) = freqData(1,3) + 1;
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(3))==1)                 
                        freqData(1,4) = freqData(1,4) + 1;
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(4))==1)                
                        freqData(1,5) = freqData(1,5) + 1;
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(5))==1)                   
                        freqData(1,6) = freqData(1,6) + 1;
                     case (strcmpi(accDataInAzipcode(i,colIndex),obj.FactorValues(6))==1)                   
                        freqData(1,7) = freqData(1,7) + 1;             
                    otherwise                    
                        freqData(1,8) = freqData(1,8) + 1;
                 end
             end           
        end


        function factorFreqTable = GetFrequencyTable(obj)

            % Create a printable data for factor frequency with average data
           
            % Add average data column to factor frequency
            factorFrequency(:,:) = obj.FactorFrequency(:,:);
            factorFrequency(:, width(factorFrequency)+1) = obj.FactorAverage;

            % Create a FactorFreqency Table for the factor
            header = cat(2, {'ZipCode'}, obj.FactorValues, {'UnKnown', 'Average'});

            % Create a FactorFreqency Table for the factor            
            factorFreqTable = [ header; num2cell(factorFrequency)];
           
        end

      end
end