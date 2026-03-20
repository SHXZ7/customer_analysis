SELECT COUNT(*) FROM order_items; -- Total number of order items = 112650

SELECT *
FROM order_items
WHERE price <= 0;
-- NO OUTPUT

SELECT *
FROM order_items
WHERE product_id IS NULL OR seller_id IS NULL
LIMIT 10;

SELECT COUNT(DISTINCT customer_unique_id) FROM customers;
-- Total number of unique customers = 96096

SELECT customer_unique_id, COUNT(*)
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

SELECT review_score, COUNT(*)
FROM order_reviews
GROUP BY review_score;

SELECT *
FROM order_reviews
WHERE review_score IS NULL;

SELECT 
  o.order_id,
  c.customer_unique_id,
  
  o.order_purchase_timestamp,
  
  oi.price,
  oi.freight_value,
  
  (oi.price + oi.freight_value) AS total_order_value,
  
  JULIANDAY(o.order_delivered_customer_date) - 
  JULIANDAY(o.order_estimated_delivery_date) AS delivery_delay_days

FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
