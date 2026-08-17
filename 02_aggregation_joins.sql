-- A. INNER JOIN + GROUP BY + HAVING
-- Delivered revenue by cuisine, keeping cuisines
-- whose delivered revenue is greater than INR 40,000.

SELECT
    r.cuisine,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine
HAVING SUM(o.amount_inr) > 40000
ORDER BY total_revenue DESC;


-- B. LEFT JOIN
-- All restaurants, including any with zero orders.
-- COUNT(o.order_id) returns 0 when there is no matching order.

SELECT
    r.restaurant_id,
    r.name,
    r.cuisine,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
LEFT JOIN orders AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.name,
    r.cuisine
ORDER BY total_orders ASC, r.restaurant_id;
