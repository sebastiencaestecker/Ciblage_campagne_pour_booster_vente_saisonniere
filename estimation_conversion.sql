WITH rfm AS (
  Select
    user_id,
    MAX(DATE(created_at)) as last_order,
    COUNT(id) as frequency,
    SUM(sale_price) as monetary
  FROM bigquery-public-data.thelook_ecommerce.order_items
  WHERE status='Complete' and DATE(created_at) >= DATE_SUB(CURRENT_DATE(),INTERVAL 4 MONTH)
  group by user_id
  ),
  
rfm1 AS (
  SELECT
    user_id,
    DATE_DIFF(current_date(),last_order,DAY) as Recency,
    frequency,
    monetary
  FROM rfm
),

    -- Je calcule le quartile pour la recency, frequency et la  monetary, la limite 1 car le resultat et le meme pour chaque ligne de la table rfm1
    -- percentile_cont() me calcule la valeur pour chaque quartile
quartiles AS (
  SELECT
    PERCENTILE_CONT(recency, 0.25) OVER() AS r_q1,
    PERCENTILE_CONT(recency, 0.50) OVER() AS r_q2,
    PERCENTILE_CONT(recency, 0.75) OVER() AS r_q3,

    PERCENTILE_CONT(frequency, 0.25) OVER() AS f_q1,
    PERCENTILE_CONT(frequency, 0.50) OVER() AS f_q2,
    PERCENTILE_CONT(frequency, 0.75) OVER() AS f_q3,

    PERCENTILE_CONT(monetary, 0.25) OVER() AS m_q1,
    PERCENTILE_CONT(monetary, 0.50) OVER() AS m_q2,
    PERCENTILE_CONT(monetary, 0.75) OVER() AS m_q3
  FROM rfm1
  LIMIT 1
),
score as (
  SELECT
    r.*,
    CASE
      WHEN recency <= q.r_q1 THEN 4
      WHEN recency <= q.r_q2 THEN 3
      WHEN recency <= q.r_q3 THEN 2
      ELSE 1
    END AS r_score,
    CASE
      WHEN frequency <= q.f_q1 THEN 1
      WHEN frequency <= q.f_q2 THEN 2
      WHEN frequency <= q.f_q3 THEN 3
      ELSE 4
    END AS f_score,
    CASE
      WHEN monetary <= q.m_q1 THEN 1
      WHEN monetary <= q.m_q2 THEN 2
      WHEN monetary <= q.m_q3 THEN 3
      ELSE 4
    END AS m_score
  FROM rfm1 r
  CROSS JOIN quartiles q --n'ayant pas de colonne commune et n'ayant qu'une ligne je fais un cross join
),
rfm_final AS (
  SELECT *,
    r_score + f_score + m_score AS rfm_total,
    CASE
      WHEN r_score + f_score + m_score >= 10 THEN 'Platine'
      WHEN r_score + f_score + m_score >= 8 THEN 'Gold'
      WHEN r_score + f_score + m_score >= 6 THEN 'Silver'
      WHEN r_score + f_score + m_score >= 4 THEN 'Bronze'
      ELSE 'Iron'
    END AS statut
  FROM score
)

SELECT e.event_type, COUNT(*) AS nb
FROM `bigquery-public-data.thelook_ecommerce.events` as e
JOIN rfm_final rf ON e.user_id=rf.user_id
where date(e.created_at)>= '2025-01-08' and date(e.created_at)<= '2025-01-15' and traffic_source='Email' and rf.statut='Silver'
GROUP BY e.event_type
ORDER BY nb DESC

