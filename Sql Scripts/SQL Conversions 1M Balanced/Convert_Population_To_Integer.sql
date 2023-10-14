alter TABLE collisiontable1M add COLUMN population_value;

update collisiontable1M
set population_value = 1
where population =  'unincorporated';

update collisiontable1M
set population_value = 2
where population =  '<2500';

update collisiontable1M
set population_value = 3
where population =  '2500 to 10000';

update collisiontable1M
set population_value = 4
where population =  '10000 to 25000';

update collisiontable1M
set population_value = 5
where population =  '25000 to 50000';

update collisiontable1M
set population_value = 6
where population =  '50000 to 100000';

update collisiontable1M
set population_value = 7
where population =  '100000 to 250000';

update collisiontable1M
set population_value = 8
where population =  '>250000';

select distinct population, population_value
from collisiontable1M;