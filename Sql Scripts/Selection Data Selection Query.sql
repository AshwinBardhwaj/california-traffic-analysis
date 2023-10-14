DROP TABLE collsiontable1M;

CREATE TABLE collisiontable1M(case_id PRIMARY KEY, collision_severity TEXT, latitude REAL, longitude REAL, population TEXT, lighting TEXT, collision_time TEXT, intersection INT, location_type TEXT , 
								road_surface TEXT, road_condition_1 TEXT, weather_1 TEXT, alcohol_involved INT, at_fault INT, financial_responsibility TEXT, party_age INT, party_sex TEXT,
								party_drug_physical TEXT, cellphone_in_use TEXT, vehicle_make TEXT, vehicle_year INTEGER);
								
INSERT INTO collisiontable1M select 
     collisions.case_id,
	 collisions.collision_severity,
	 collisions.latitude,
	 collisions.longitude,
	 collisions.population,
	 collisions.lighting,
	 collisions.collision_time,
	 collisions.intersection,
	 collisions.location_type,
	 collisions.road_surface,
	 collisions.road_condition_1,
	 collisions.weather_1,
	 collisions.alcohol_involved,
	 parties.at_fault,
	 parties.financial_responsibility,
	 parties.party_age,
	 parties.party_sex,
	 parties.party_drug_physical,
	 parties.cellphone_in_use,
	 parties.vehicle_make,
	 parties.vehicle_year
from collisions
inner join parties on collisions.case_id = parties.case_id
where parties.at_fault = 1 AND
	  collisions.latitude IS NOT NULL AND
	  collisions.longitude IS NOT NULL AND
	  collisions.population IS NOT NULL AND
	  collisions.lighting IS NOT NULL AND
	  collisions.collision_time IS NOT NULL AND
	  collisions.intersection IS NOT NULL AND
	  collisions.location_type IS NOT NULL AND
	  collisions.road_surface IS NOT NULL AND
	  collisions.road_condition_1 IS NOT NULL AND
	  collisions.weather_1 IS NOT NULL AND
	  parties.financial_responsibility IS NOT NULL AND
	  parties.party_age IS NOT NULL AND
	  parties.party_sex IS NOT NULL AND
	  parties.party_drug_physical IS NOT NULL AND
	  parties.cellphone_in_use IS NOT NULL AND
	  parties.vehicle_make IS NOT NULL AND
	  parties.vehicle_year IS NOT NULL 