SELECT 
  mo.order_id,
  mo.customer_unique_id,
  mo.total_order_value,

  r.review_score,
  SUM(CASE WHEN r.review_score IS NULL THEN 1 ELSE 0 END) OVER () AS missing_review_count

FROM master_orders mo

LEFT JOIN order_reviews r 
  ON mo.order_id = r.order_id

;

SELECT order_id, COUNT(*)
FROM (
  SELECT 
    mo.order_id,
    r.review_score
  FROM master_orders mo
  LEFT JOIN order_reviews r 
    ON mo.order_id = r.order_id
)
GROUP BY order_id
HAVING COUNT(*) > 1;


CREATE VIEW master_orders_enrich AS
SELECT 
  mo.order_id,
  mo.customer_unique_id,
  mo.order_date,
  mo.total_order_value,
  mo.total_items,
  mo.delivery_delay_days,
  mo.delivery_category,

  AVG(r.review_score) AS review_score

FROM master_orders mo

LEFT JOIN order_reviews r 
  ON mo.order_id = r.order_id

GROUP BY 
  mo.order_id,
  mo.customer_unique_id,
  mo.order_date,
  mo.total_order_value,
  mo.total_items,
  mo.delivery_delay_days,
  mo.delivery_category;