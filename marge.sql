
WITH ca_category AS(
SELECT
  p.category,
  sum(p.cost) as cout,
  sum(p.retail_price) as ca
FROM bigquery-public-data.thelook_ecommerce.order_items oi
JOIN bigquery-public-data.thelook_ecommerce.products p on p.id=oi.product_id
WHERE oi.status='Complete' and date(oi.created_at)>=date_sub(current_date(),INTERVAL 4 month)
group by 1
)
Select 
  category,
  round(((ca-cout)/ca)*100,2) as marge
FROM ca_category
