CREATE VIEW product_performance AS
SELECT 
  oi.product_id,
  p.product_category_name,

  COUNT(DISTINCT oi.order_id) AS total_orders,
  COUNT(*) AS total_items_sold,

  SUM(oi.price + oi.freight_value) AS total_revenue,

  AVG(r.review_score) AS avg_review_score

FROM order_items oi

JOIN products p 
  ON oi.product_id = p.product_id

LEFT JOIN order_reviews r 
  ON oi.order_id = r.order_id

GROUP BY 
  oi.product_id,
  p.product_category_name;

SELECT * FROM product_performance LIMIT 10;