select vehicle_make, count(vehicle_make) AS Frequency
FROM collisiontable25K
GROUP BY vehicle_make
ORDER BY count(vehicle_make) DESC