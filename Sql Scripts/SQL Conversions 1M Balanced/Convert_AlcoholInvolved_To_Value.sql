alter TABLE collisiontable1M add COLUMN alcohol_involved_value INTEGER;

update collisiontable1M
set alcohol_involved_value = 0
where alcohol_involved is null;

update collisiontable1M
set alcohol_involved_value = 1
where alcohol_involved = '1';

select distinct alcohol_involved, alcohol_involved_value
from collisiontable1M;