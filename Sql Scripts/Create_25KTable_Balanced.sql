CREATE TABLE collisiontable25KBAL(
	case_id	PRIMARY KEY,
	collision_severity	TEXT,
	latitude	REAL,
	longitude	REAL,
	population	TEXT,
	lighting	TEXT,
	collision_time	TEXT,
	intersection	INT,
	location_type	TEXT,
	road_surface	TEXT,
	road_condition_1	TEXT,
	weather_1	TEXT,
	alcohol_involved	INT,
	at_fault	INT,
	financial_responsibility	TEXT,
	party_age	INT,
	party_sex	TEXT,
	party_drug_physical	TEXT,
	cellphone_in_use	TEXT,
	vehicle_make	TEXT,
	vehicle_year	INTEGER,
	party_sex_value	INTEGER,
	collision_severity_value	INTEGER,
	population_value	INTEGER,
	lighting_value	INTEGER,
	road_surface_value	INTEGER,
	weather_1_value	INTEGER,
	vehicle_make_norm	TEXT,
	location_type_value	INTEGER,
	road_condition_1_value	INTEGER,
	financial_responsibility_value	INTEGER,
	party_drug_physical_value	INTEGER,
	alcohol_involved_value	INTEGER);

INSERT INTO collisiontable25KBAL 
select collisiontable1M.* from collisiontable1M
where collision_severity == 'property damage only'
ORDER BY random() LIMIT 5000;

INSERT INTO collisiontable25KBAL 
select collisiontable1M.* from collisiontable1M
where collision_severity == 'pain'
ORDER BY random() LIMIT 5000;

INSERT INTO collisiontable25KBAL 
select collisiontable1M.* from collisiontable1M
where collision_severity == 'other injury'
ORDER BY random() LIMIT 5000;

INSERT INTO collisiontable25KBAL 
select collisiontable1M.* from collisiontable1M
where collision_severity == 'fatal'
ORDER BY random() LIMIT 5000;

INSERT INTO collisiontable25KBAL 
select collisiontable1M.* from collisiontable1M
where collision_severity == 'severe injury'
ORDER BY random() LIMIT 5000;