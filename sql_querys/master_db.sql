SELECT 
  co.order_id,
  c.customer_unique_id,

  co.order_date,

  SUM(oi.price + oi.freight_value) AS total_order_value,

  co.delivery_delay_days,
  co.delivery_category

FROM clean_orders co

JOIN customers c 
  ON co.customer_id = c.customer_id

JOIN order_items oi 
  ON co.order_id = oi.order_id

GROUP BY 
  co.order_id,
  c.customer_unique_id,
  co.order_date,
  co.delivery_delay_days,
  co.delivery_category;

SELECT order_id, COUNT(*)
FROM (
    SELECT 
  co.order_id,
  c.customer_unique_id,

  co.order_date,

  SUM(oi.price + oi.freight_value) AS total_order_value,

  co.delivery_delay_days,
  co.delivery_category

FROM clean_orders co

JOIN customers c 
  ON co.customer_id = c.customer_id

JOIN order_items oi 
  ON co.order_id = oi.order_id

GROUP BY 
  co.order_id,
  c.customer_unique_id,
  co.order_date,
  co.delivery_delay_days,
  co.delivery_category
)
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) FROM clean_orders;

SELECT COUNT(*) FROM (
    SELECT 
  co.order_id,
  c.customer_unique_id,

  co.order_date,

  SUM(oi.price + oi.freight_value) AS total_order_value,

  co.delivery_delay_days,
  co.delivery_category

FROM clean_orders co

JOIN customers c 
  ON co.customer_id = c.customer_id

JOIN order_items oi 
  ON co.order_id = oi.order_id

GROUP BY 
  co.order_id,
  c.customer_unique_id,
  co.order_date,
  co.delivery_delay_days,
  co.delivery_category
);

-- ## FINAL master  oders CLEANED QUERY

SELECT 
  co.order_id,
  c.customer_unique_id,
  co.order_date,

  SUM(oi.price + oi.freight_value) AS total_order_value,
  COUNT(oi.product_id) AS total_items,

  co.delivery_delay_days,
  co.delivery_category

FROM clean_orders co
JOIN customers c 
  ON co.customer_id = c.customer_id
JOIN order_items oi 
  ON co.order_id = oi.order_id

GROUP BY 
  co.order_id,
  c.customer_unique_id,
  co.order_date,
  co.delivery_delay_days,
  co.delivery_category;



SELECT * FROM master_orders LIMIT 10;

