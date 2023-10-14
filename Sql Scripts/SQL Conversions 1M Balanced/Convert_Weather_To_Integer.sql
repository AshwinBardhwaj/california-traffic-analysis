alter TABLE collisiontable1M add COLUMN weather_1_value INTEGER;

update collisiontable1M
set weather_1_value = 1
where weather_1 =  'clear';

update collisiontable1M
set weather_1_value = 2
where weather_1 =  'cloudy';

update collisiontable1M
set weather_1_value = 3
where weather_1 =  'wind';

update collisiontable1M
set weather_1_value = 4
where weather_1 =  'raining';

update collisiontable1M
set weather_1_value = 5
where weather_1 =  'fog';

update collisiontable1M
set weather_1_value = 6
where weather_1 =  'snowing';

update collisiontable1M
set weather_1 = 7
where weather_1 =  'other';

select distinct weather_1, weather_1_value
from collisiontable1M;