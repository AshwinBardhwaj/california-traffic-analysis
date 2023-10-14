alter TABLE collisiontable1M add COLUMN collision_severity_value INTEGER;

update collisiontable1M
set collision_severity_value = 1
where collision_severity =  'property damage only';

update collisiontable1M
set collision_severity_value = 2
where collision_severity =  'pain';

update collisiontable1M
set collision_severity_value = 3
where collision_severity =  'other injury';

update collisiontable1M
set collision_severity_value = 4
where collision_severity =  'severe injury';

update collisiontable1M
set collision_severity_value = 5
where collision_severity =  'fatal';

select distinct collision_severity, collision_severity_value
from collisiontable1M;