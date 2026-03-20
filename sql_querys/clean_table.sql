CREATE VIEW clean_orders AS
SELECT 
    order_id,
    customer_id,

    COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,

    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    JULIANDAY(order_delivered_customer_date) - 
    JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days,

    CASE 
        WHEN JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) > 30 THEN 'Extreme Delay'
        WHEN JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) > 0 THEN 'Late'
        ELSE 'On Time/Early'
    END AS delivery_category

FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;

SELECT * FROM clean_orders LIMIT 10;