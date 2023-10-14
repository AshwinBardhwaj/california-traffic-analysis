function [xPos,yPos] = get_cartesian(latlongCoord)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
R = 3958.8;
radLat = deg2rad(latlongCoord(1,1));
radLong = deg2rad(latlongCoord(1,2));
xPos = R * cos(radLat) * cos(radLong);
yPos = R * cos(radLat) * sin(radLong);
end