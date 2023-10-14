%==========================================================================
% File      : Utility.m
% Project   : Modelling the future Challange
% Detail    : Factor 'Drunk Driving' on the given cluster data
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
classdef Utility
    % UNTITLED Summary of this class goes here
    %   Detailed explanation goes here  

    methods(Static)
     
         function updatedFrequencyofFactor = RemoveZipCodeFromFactorData(frequencyofFactor)
         
             % Delete unwanted zipcodes. first two row 11000, 22557           

             updatedFrequencyofFactor = frequencyofFactor(3:end,:);
         end

        function avgData = UpdateAverageStatistics(factorFrequency, factorCategoryValue)
            
            % Iterate over all zipcodes and average of all light conditions           

            % When taking avergae , do not use the first column(zipcode)
            % and the last column, which is unknown value 
            avgData = zeros(height(factorFrequency),1);
            sum = 0;
            totalCase = 0;

            for i = 1:height(factorFrequency)
            
                for j = 2: width(factorFrequency) -1 
                    sum = sum +  factorFrequency(i,j)* factorCategoryValue(j-1);
                    totalCase = totalCase + factorFrequency(i,j);
                end
            
                avgData(i) = sum /totalCase;
            end  
        end

        function modeData = UpdateModeStatistics(factorFrequency)

            % Iterate over all zip-codes and get mode
            % return the first category that has max accidents

            factorFrequency = factorFrequency(:,1:end-1);
            modeData = zeros(height(factorFrequency),1);

            for i = 1:height(factorFrequency)
                mode = max(factorFrequency(i,2:end));
                modeData(i) = find(factorFrequency(i,:) ==  mode, 1);
                modeData(i) = modeData(i)-1;
            end
        end

        function DeleteFile(filename)

            % Delete a file if it exists
            
            if exist(filename, 'file')==2
                delete(filename);
            end
        end
    end
end