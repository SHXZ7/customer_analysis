CREATE VIEW seller_performances AS

SELECT 
  oi.seller_id,

  COUNT(DISTINCT oi.order_id) AS total_orders,

  COUNT(*) AS total_items_sold,

  SUM(oi.price + oi.freight_value) AS total_revenue,

  AVG(moe.review_score) AS avg_review_score,

  CASE 
    WHEN AVG(moe.review_score) < 3 THEN 'Low Rated'
    WHEN AVG(moe.review_score) < 4 THEN 'Average'
    ELSE 'High Rated'
  END AS seller_rating_category,

  AVG(moe.delivery_delay_days) AS avg_delivery_delay

FROM order_items oi

JOIN master_orders_enriched moe 
  ON oi.order_id = moe.order_id

GROUP BY oi.seller_id;

SELECT * FROM seller_performances   
LIMIT 10;
