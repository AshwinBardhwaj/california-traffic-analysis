alter TABLE collisiontable1M add COLUMN party_sex_value INTEGER;

update collisiontable1M
set party_sex_value = 1
where party_sex =  'male';

update collisiontable1M
set party_sex_value = 2
where party_sex =  'female';

select distinct party_sex, party_sex_value
from collisiontable1M;