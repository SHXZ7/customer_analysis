SELECT * FROM orders LIMIT 10;

SELECT order_status, COUNT(*) as count
FROM orders
GROUP BY order_status;

SELECT 
  order_id,
  customer_id,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_customer_date,
  order_estimated_delivery_date
FROM orders
WHERE order_status = 'delivered';

SELECT 
  order_id,
  customer_id,
  
  -- Use best available timestamp
  COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,
  
  order_purchase_timestamp,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  
  -- Delivery delay
  JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days

FROM orders
WHERE order_status = 'delivered';

SELECT *
FROM (
    SELECT 
        order_id,
        customer_id,

        COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,

        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        -- Delivery delay
        JULIANDAY(order_delivered_customer_date) - 
        JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days

    FROM orders
    WHERE order_status = 'delivered'
)
LIMIT 10;

SELECT *
FROM (
        SELECT 
        order_id,
        customer_id,

        COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,

        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        -- Delivery delay
        JULIANDAY(order_delivered_customer_date) - 
        JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days

    FROM orders
    WHERE order_status = 'delivered'
)
WHERE order_delivered_customer_date IS NULL;

SELECT *
FROM (
    SELECT 
        order_id,
        customer_id,

        COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,

        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        JULIANDAY(order_delivered_customer_date) - 
        JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days

    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
)
LIMIT 10;

SELECT *
FROM (
        SELECT 
        order_id,
        customer_id,

        COALESCE(order_approved_at, order_purchase_timestamp) AS order_date,

        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        JULIANDAY(order_delivered_customer_date) - 
        JULIANDAY(order_estimated_delivery_date) AS delivery_delay_days

    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
)
WHERE delivery_delay_days > 30
ORDER BY delivery_delay_days DESC
LIMIT 10;

SELECT 
  order_purchase_timestamp,
  order_delivered_customer_date,
  order_estimated_delivery_date
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
ORDER BY 
  JULIANDAY(order_delivered_customer_date) - 
  JULIANDAY(order_estimated_delivery_date) DESC
LIMIT 10;

SELECT 
  COUNT(*) as total_orders,
  SUM(CASE WHEN 
    JULIANDAY(order_delivered_customer_date) - 
    JULIANDAY(order_estimated_delivery_date) > 30 
  THEN 1 ELSE 0 END) as extreme_delays
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;



    SELECT *
FROM (
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
            WHEN JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) > 0  THEN 'Late'
            WHEN JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date) <= 0 THEN 'On Time/Early'
        END AS delivery_category

    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
)
