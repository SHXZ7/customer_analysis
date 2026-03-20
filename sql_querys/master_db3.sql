SELECT * 
FROM master_orders_enrich 
LIMIT 10;

SELECT 
  oi.order_id,
  p.product_category_name
FROM order_items oi
JOIN products p 
  ON oi.product_id = p.product_id
LIMIT 20;

SELECT 
  oi.order_id,
  MIN(p.product_category_name) AS product_category_name
FROM order_items oi
JOIN products p 
  ON oi.product_id = p.product_id
GROUP BY oi.order_id;




SELECT * FROM master_order_finals ;