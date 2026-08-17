-- 1. SELECT / WHERE
-- Restaurants located in Mumbai
SELECT
    restaurant_id,
    name,
    cuisine,
    city
FROM restaurants
WHERE city = 'Mumbai';


-- 2. DISTINCT
-- Every distinct cuisine
SELECT DISTINCT
    cuisine
FROM restaurants
ORDER BY cuisine;


-- 3. ORDER BY + LIMIT
-- Five highest-value orders
SELECT
    order_id,
    customer_id,
    restaurant_id,
    order_date,
    amount_inr,
    status
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;


-- 4. LIKE with %
-- Restaurants whose name contains "Spice"
SELECT
    restaurant_id,
    name,
    cuisine,
    city
FROM restaurants
WHERE name LIKE '%Spice%';


-- 5. IN
-- Customers in Mumbai or Delhi
SELECT
    customer_id,
    name,
    signup_date,
    city
FROM customers
WHERE city IN ('Mumbai', 'Delhi')
ORDER BY city, customer_id;


-- 6. BETWEEN
-- Orders between INR 500 and INR 1500 inclusive
SELECT
    order_id,
    order_date,
    amount_inr,
    status
FROM orders
WHERE amount_inr BETWEEN 500 AND 1500
ORDER BY amount_inr;


-- 7. NOT BETWEEN
-- Orders outside INR 500 to INR 1500
SELECT
    order_id,
    order_date,
    amount_inr,
    status
FROM orders
WHERE amount_inr NOT BETWEEN 500 AND 1500
ORDER BY amount_inr;


-- 8. IS NULL
-- Orders with no rating
SELECT
    order_id,
    order_date,
    amount_inr,
    status,
    rating
FROM orders
WHERE rating IS NULL
ORDER BY order_id;
