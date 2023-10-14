alter TABLE collisiontable1M add COLUMN party_drug_physical_value INTEGER;

update collisiontable1M
set party_drug_physical_value = 1
where party_drug_physical =  'not applicable';

update collisiontable1M
set party_drug_physical_value = 1
where party_drug_physical =  'G';

update collisiontable1M
set party_drug_physical_value = 2
where party_drug_physical =  'under drug influence';

update collisiontable1M
set party_drug_physical_value = 3
where party_drug_physical =  'sleepy/fatigued';

update collisiontable1M
set party_drug_physical_value = 4
where party_drug_physical =  'impairment - physical';

select distinct party_drug_physical, party_drug_physical_value
from collisiontable1M;