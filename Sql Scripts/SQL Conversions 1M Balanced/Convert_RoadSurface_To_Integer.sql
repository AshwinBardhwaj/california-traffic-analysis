alter TABLE collisiontable1M add COLUMN road_surface_value INTEGER;

update collisiontable1M
set road_surface_value = 1
where road_surface =  'dry';

update collisiontable1M
set road_surface_value = 2
where road_surface =  'wet';

update collisiontable1M
set road_surface_value = 3
where road_surface =  'slippery';

update collisiontable1M
set road_surface_value = 4
where road_surface =  'snowy';

select distinct road_surface, road_surface_value
from collisiontable1M;