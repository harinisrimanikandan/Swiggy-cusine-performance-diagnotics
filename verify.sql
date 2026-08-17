-- Verification results required:
-- restaurants = 15
-- customers = 50
-- orders = 420
-- cuisine_targets = 6
-- orders.status contains Delivered, Cancelled, Pending

SELECT COUNT(*) AS restaurant_count
FROM restaurants;

SELECT COUNT(*) AS customer_count
FROM customers;

SELECT COUNT(*) AS order_count
FROM orders;

SELECT COUNT(*) AS cuisine_target_count
FROM cuisine_targets;

SELECT
    status,
    COUNT(*) AS status_count
FROM orders
GROUP BY status
ORDER BY status;
