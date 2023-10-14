alter TABLE collisiontable1M add COLUMN road_condition_1_value INTEGER;

update collisiontable1M
set road_condition_1_value = 1
where road_condition_1 =  'normal';

update collisiontable1M
set road_condition_1_value = 2
where road_condition_1 =  'construction';

update collisiontable1M
set road_condition_1_value = 3
where road_condition_1 =  'obstruction';

update collisiontable1M
set road_condition_1_value = 4
where road_condition_1 =  'loose material';

update collisiontable1M
set road_condition_1_value = 5
where road_condition_1 =  'holes';

update collisiontable1M
set road_condition_1_value = 6
where road_condition_1 =  'flooded';

update collisiontable1M
set road_condition_1_value = 7
where road_condition_1 =  'reduced width';

select distinct road_condition_1, road_condition_1_value
from collisiontable1M;