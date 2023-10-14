alter TABLE collisiontable1M add COLUMN vehicle_make_norm TEXT;

update collisiontable1M
set vehicle_make_norm = vehicle_make
where vehicle_make in 
	(SELECT vehicle_make from collisiontable1M
     GROUP BY vehicle_make HAVING count(vehicle_make) > 1300)