SELECT collision_severity, Count(collision_severity) AS Frequency
FROM collisiontable25KBalClusterIndexed
GROUP BY collision_severity
order By count(collision_severity) DESC