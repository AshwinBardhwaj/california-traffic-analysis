alter TABLE collisiontable1M add COLUMN lighting_value INTEGER;

update collisiontable1M
set lighting_value = 5
where lighting =  'daylight';

update collisiontable1M
set lighting_value = 4
where lighting =  'dark with street lights';

update collisiontable1M
set lighting_value = 3
where lighting =  'dusk or dawn';

update collisiontable1M
set lighting_value = 2
where lighting =  'dark with street lights not functioning';

update collisiontable1M
set lighting_value = 1
where lighting =  'dark with no street lights';

select distinct lighting, lighting_value
from collisiontable1M;
