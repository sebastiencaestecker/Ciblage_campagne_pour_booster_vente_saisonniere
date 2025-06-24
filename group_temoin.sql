--Mettre le code du Calcul segment RFM ICI

silver_category AS(
  SELECT 
    oi.user_id as user_id
  FROM rfm_final rf
  JOIN bigquery-public-data.thelook_ecommerce.order_items oi on oi.user_id=rf.user_id
  JOIN bigquery-public-data.thelook_ecommerce.products p on p.id=oi.product_id
  WHERE statut='Silver' and DATE(oi.created_at) >= DATE_SUB(CURRENT_DATE(),INTERVAL 4 MONTH) and p.category='Outerwear & Coats' and oi.status='Complete'

),

target_clients AS (
  SELECT user_id
  FROM rfm_final
  WHERE user_id NOT IN (SELECT user_id FROM silver_category) and statut='Silver'
),

group_temoin as (
  SELECT
    user_id,
    CASE 
      WHEN rand() <=0.1 THEN 'Temoin'
      else 'Expose'
    END AS Statut_campagne
  FROM target_clients

)


select count(Statut_campagne) from group_temoin
group by Statut_campagne
