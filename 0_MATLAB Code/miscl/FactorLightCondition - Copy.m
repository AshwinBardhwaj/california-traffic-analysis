%==========================================================================
% File      : FactorLightCondition.m
% Project   : Math Challange
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
        FactorCategoryValue = {1,2,3,4,5,6}   
        
        FactorFrequency;
    end

    methods

        function obj = FactorLightCondition(data)           
            obj.Data = data;           
        end

        function frequencyofLightCondition = UpdateFrequency(obj)

            % Get Unique zipcode Array
            [uniqueZipcode, uniquezipcodeDataSize] = GetUniqueZipCode(obj);

            % Get freqency diagram for Light condition
            [rowSize,~] = size(uniqueZipcode);
            frequencyofLightCondition = zeros(rowSize, 8);            

            for i = 1 : rowSize                
                frequencyofLightCondition(i,:) = GetFreqDataforZipCode(obj, uniqueZipcode(i), uniquezipcodeDataSize(i));
            end  

            obj.FactorFrequency = frequencyofLightCondition(:,:);
        end       
        

        function [uniqueZipCode, uniqueZipCodeFreq] = GetUniqueZipCode(obj)

            % Get Unique zipcode Array
            zipcodeArray = cell2mat(obj.Data(:,13));
            newtable = table(zipcodeArray);
            zipcodegroupCountTable  = groupcounts(newtable, 'zipcodeArray');

            uniqueZipCode = zipcodegroupCountTable{:,{'zipcodeArray'}};
            uniqueZipCodeFreq = zipcodegroupCountTable{:,{'GroupCount'}};             
        end  

        function freqData = GetFreqDataforZipCode(obj, zipcode, zipcodeDataSize)
            % Get frequency data for lightcondition based on zipcode

            %Get a list of accidenet dat for a zipcode
            zipcodeData = GetDataforZipCode(obj, zipcode, zipcodeDataSize);
            
            freqData = zeros(1, 8);
            freqData(1,1) = zipcode;

            for i = 1 : size(zipcodeData) 
                 switch true
                    case (strcmpi(zipcodeData(i,6),obj.FactorValues(1))==1)                    
                        freqData(1,2) = freqData(1,2) + 1;
                    case (strcmpi(zipcodeData(i,6),obj.FactorValues(2))==1)               
                        freqData(1,3) = freqData(1,3) + 1;
                    case (strcmpi(zipcodeData(i,6),obj.FactorValues(3))==1)                 
                        freqData(1,4) = freqData(1,4) + 1;
                    case (strcmpi(zipcodeData(i,6),obj.FactorValues(4))==1)                
                        freqData(1,5) = freqData(1,5) + 1;
                    case (strcmpi(zipcodeData(i,6),obj.FactorValues(5))==1)                   
                        freqData(1,6) = freqData(1,6) + 1;
                     case (strcmpi(zipcodeData(i,6),obj.FactorValues(6))==1)                   
                        freqData(1,7) = freqData(1,7) + 1;             
                    otherwise                    
                        freqData(1,8) = freqData(1,8) + 1;
                 end
             end           
         end

         function zipCodeData = GetDataforZipCode(obj, zipcode, zipcodeDataSize)
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