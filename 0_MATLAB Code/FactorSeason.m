%==========================================================================
% File      : FactorSeason.m
% Project   : Modelling the future Challange
% Detail    : Factor 'Season' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef FactorSeason < handle
    % Create Freqncy diagram array for Intersection totalzipcode x Intersection
    % rows : zipcodes, columns : season
    % Season :  Winter : Dec - Feb
    %           Spring : March - May
    %           Summer : June - Aug
    %           Fall   : Sep - Nov
    % [zipcode, Winter,Spring,Summer,Fall] 

    properties
        Data;          

         % [Jan, Feb, Mar, Apr, May, June, July, Aug, Sep, Oct, Nov, Dec] 
        FactorValues = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        FactorCategoryValue = [1,2,3,4];
        ColumnIndexInData = 11;

        FactorFrequency;
        FactorMode;
    end

    methods

        function obj = FactorSeason(data)           
            obj.Data = data;           
        end

        function frequencyofSeason = UpdateFrequency(obj)
            % Get Unique zipcode Array
            processZipCode = ProcessZipCode(obj.Data);
            [uniqueZipcode, uniquezipcodeDataSize] = processZipCode.GetUniqueZipCode();
            
            % Get freqency diagram for factor
            [rowSize,~] = size(uniqueZipcode);
            colSize = 6;
            frequencyofSeason = zeros(rowSize, colSize);            
            
            for i = 1 : rowSize         
                %Get a list of accident data for a zipcode
                accDataInAzipcode = processZipCode.GetAccDataInAZipCode(uniqueZipcode(i), uniquezipcodeDataSize(i));
                
                frequencyofSeason(i,:) = GetFreqDataforZipCode(obj, accDataInAzipcode, uniqueZipcode(i), colSize);
            end  
            
            % Delete the unwanted zipcode Rows
            frequencyofSeason = Utility.RemoveZipCodeFromFactorData(frequencyofSeason);

            obj.FactorFrequency = frequencyofSeason(:,:);
        
        end          
        
        function modeData = UpdateModeStatistics(obj)
            
            % Calculate avergae of factor for each zipcode
            
            modeData = Utility.UpdateModeStatistics(obj.FactorFrequency);
            obj.FactorMode = modeData(:,:);         
        end

        function freqData = GetFreqDataforZipCode(obj, accDataInAzipcode, zipcode, colSize)
            % Get frequency data for factor based on zipcode          
            colIndex = obj.ColumnIndexInData;  

            freqData = zeros(1, colSize);
            freqData(1,1) = zipcode;                      

            seasonArray = cell2mat(accDataInAzipcode(:,colIndex));

            for i = 1 : size(seasonArray) 
                 switch seasonArray(i)
                     case obj.FactorValues(12)
                     case obj.FactorValues(1) 
                     case obj.FactorValues(2)    
                        freqData(1,2) = freqData(1,2) + 1;
                     case obj.FactorValues(3)
                     case obj.FactorValues(4) 
                     case obj.FactorValues(5)                     
                        freqData(1,3) = freqData(1,3) + 1;
                     case obj.FactorValues(6)
                     case obj.FactorValues(7) 
                     case obj.FactorValues(8)                
                        freqData(1,4) = freqData(1,4) + 1;
                     case obj.FactorValues(9)
                     case obj.FactorValues(10) 
                     case obj.FactorValues(11)                     
                        freqData(1,5) = freqData(1,5) + 1;                    
                    otherwise                    
                        freqData(1,6) = freqData(1,6) + 1;
                 end
             end           
        end


        function factorFreqTable = GetFrequencyTable(obj)

            % Create a printable data for factor frequency with average data
           
            % Add average data column to factor frequency
            factorFrequency(:,:) = obj.FactorFrequency(:,:);
            factorFrequency(:, width(factorFrequency)+1) = obj.FactorMode;

            % Create a FactorFreqency Table for the factor
            header = {'ZipCode', 'Winter', 'Spring', 'Summer', 'Fall', 'UnKnown', 'Mode'};

            % Create a FactorFreqency Table for the factor            
            factorFreqTable = [ header; num2cell(factorFrequency)];           
        end
        
      end
end