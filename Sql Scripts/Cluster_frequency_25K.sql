SELECT ClusterNumber, Count(ClusterNumber) AS Frequency
FROM collisiontable25KBalClusterIndexed
GROUP BY ClusterNumber
order By ClusterNumber ASC