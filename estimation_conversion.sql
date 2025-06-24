--Mettre le code du Calcul segment RFM ICI
SELECT e.event_type, COUNT(*) AS nb
FROM `bigquery-public-data.thelook_ecommerce.events` as e
JOIN rfm_final rf ON e.user_id=rf.user_id
where date(e.created_at)>= '2025-01-08' and date(e.created_at)<= '2025-01-15' and traffic_source='Email' and rf.statut='Silver'
GROUP BY e.event_type
ORDER BY nb DESC

