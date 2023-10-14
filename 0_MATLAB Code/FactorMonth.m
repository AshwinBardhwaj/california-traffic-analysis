%==========================================================================
% File      : FactorMonth.m
% Project   : Modelling the future Challange
% Detail    : Factor 'Month' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef FactorMonth < handle
    % Create Freqncy diagram array for Intersection totalzipcode x Intersection
    % rows : zipcodes, columns : month
    % Month :  1 - January ... 12 - December
    % [zipcode, Jan, Feb, Mar, Apr, May, June, July, Aug, Sep, Oct, Nov, Dec] 

    properties
        Data;          

        FactorValues = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        ColumnIndexInData = 11;

        FactorFrequency;
    end

    methods

        function obj = FactorMonth(data)           
            obj.Data = data;           
        end

        function frequencyofMonth = UpdateFrequency(obj)
            % Get Unique zipcode Array
            processZipCode = ProcessZipCode(obj.Data);
            [uniqueZipcode, uniquezipcodeDataSize] = processZipCode.GetUniqueZipCode();
            
            % Get freqency diagram for factor
            [rowSize,~] = size(uniqueZipcode);
            [~,colSize] = size(obj.FactorValues);
            colSize = colSize + 2;
            frequencyofMonth = zeros(rowSize, colSize);            
            
            for i = 1 : rowSize         
                %Get a list of accident data for a zipcode
                accDataInAzipcode = processZipCode.GetAccDataInAZipCode(uniqueZipcode(i), uniquezipcodeDataSize(i));
                
                frequencyofMonth(i,:) = GetFreqDataforZipCode(obj, accDataInAzipcode, uniqueZipcode(i), colSize);
            end  
            
            % Delete the unwanted zipcode Rows
            frequencyofMonth = Utility.RemoveZipCodeFromFactorData(frequencyofMonth);

            obj.FactorFrequency = frequencyofMonth(:,:);
        
        end          
        
        function freqData = GetFreqDataforZipCode(obj, accDataInAzipcode, zipcode, colSize)
            % Get frequency data for factor based on zipcode          
            colIndex = obj.ColumnIndexInData;  

            freqData = zeros(1, colSize);
            freqData(1,1) = zipcode;                      

            monthArray = cell2mat(accDataInAzipcode(:,colIndex));

            for i = 1 : size(monthArray) 
                 switch monthArray(i)
                     case obj.FactorValues(1)                    
                        freqData(1,2) = freqData(1,2) + 1;
                     case obj.FactorValues(2)               
                        freqData(1,3) = freqData(1,3) + 1;     
                     case obj.FactorValues(3)                    
                        freqData(1,4) = freqData(1,4) + 1;
                     case obj.FactorValues(4)               
                        freqData(1,5) = freqData(1,5) + 1;
                     case obj.FactorValues(5)                    
                        freqData(1,6) = freqData(1,6) + 1;
                     case obj.FactorValues(6)               
                        freqData(1,7) = freqData(1,7) + 1;     
                     case obj.FactorValues(7)                    
                        freqData(1,8) = freqData(1,8) + 1;
                     case obj.FactorValues(8)               
                        freqData(1,9) = freqData(1,9) + 1;   
                     case obj.FactorValues(9)                    
                        freqData(1,10) = freqData(1,10) + 1;
                     case obj.FactorValues(10)               
                        freqData(1,11) = freqData(1,11) + 1;     
                     case obj.FactorValues(11)                    
                        freqData(1,12) = freqData(1,12) + 1;
                     case obj.FactorValues(12)               
                        freqData(1,13) = freqData(1,13) + 1;   
                    otherwise                    
                        freqData(1,14) = freqData(1,14) + 1;
                 end
             end           
        end
        
      end
end