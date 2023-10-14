alter TABLE collisiontable1M add COLUMN financial_responsibility_value INTEGER;

update collisiontable1M
set financial_responsibility_value = 1
where financial_responsibility =  'proof of insurance obtained';

update collisiontable1M
set financial_responsibility_value = 2
where financial_responsibility =  'no proof of insurance obtained';

update collisiontable1M
set financial_responsibility_value = 3
where financial_responsibility =  'officer called away before obtained';

select distinct financial_responsibility, financial_responsibility_value
from collisiontable1M;