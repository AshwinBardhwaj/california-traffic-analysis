alter TABLE collisiontable1M add COLUMN location_type_value INTEGER;

update collisiontable1M
set location_type_value = 1
where location_type =  'highway';

update collisiontable1M
set location_type_value = 2
where location_type =  'ramp';

update collisiontable1M
set location_type_value = 3
where location_type =  'intersection';

select distinct location_type, location_type_value
from collisiontable1M;