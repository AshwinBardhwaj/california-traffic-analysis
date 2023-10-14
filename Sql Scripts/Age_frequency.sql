SELECT party_age, Count(party_age) AS Frequency
FROM collisiontable1M
GROUP BY party_age
order By party_age ASC