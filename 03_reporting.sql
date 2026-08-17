-- ============================================================
-- A. RESTAURANT REVENUE TIER
-- ============================================================

SELECT
    restaurant_id,
    name,
    cuisine,
    total_revenue,
    CASE
        WHEN total_revenue >= 50000 THEN 'High'
        WHEN total_revenue >= 20000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM (
    SELECT
        r.restaurant_id,
        r.name,
        r.cuisine,
        COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN o.amount_inr
                ELSE 0
            END
        ), 0) AS total_revenue
    FROM restaurants AS r
    LEFT JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id
    GROUP BY
        r.restaurant_id,
        r.name,
        r.cuisine
)
ORDER BY total_revenue DESC;


-- ============================================================
-- B. MONTHLY-BY-CUISINE BUSINESS REPORT
-- THIS IS THE QUERY USED TO CREATE monthly_cuisine_revenue.csv
-- ============================================================

SELECT
    r.cuisine AS cuisine,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY
    r.cuisine,
    strftime('%Y-%m', o.order_date)
ORDER BY
    r.cuisine,
    month;


-- ============================================================
-- C. CUISINE TARGET / VARIANCE REPORT
-- ============================================================

WITH cuisine_revenue AS (
    SELECT
        r.cuisine,
        SUM(o.amount_inr) AS total_revenue
    FROM orders AS o
    INNER JOIN restaurants AS r
        ON o.restaurant_id = r.restaurant_id
    WHERE o.status = 'Delivered'
    GROUP BY r.cuisine
)

SELECT
    cr.cuisine,
    cr.total_revenue,
    ct.target_revenue_inr,

    ct.target_revenue_inr - cr.total_revenue AS variance,

    ((cr.total_revenue - ct.target_revenue_inr) * 100.0)
        / ct.target_revenue_inr AS percentage_variance,

    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr
            THEN 'Above Target'

        WHEN (
            (ct.target_revenue_inr - cr.total_revenue) * 100.0
            / ct.target_revenue_inr
        ) <= 15
            THEN 'Below Target - Watch'

        ELSE 'Below Target - Critical'
    END AS target_status

FROM cuisine_revenue AS cr
INNER JOIN cuisine_targets AS ct
    ON cr.cuisine = ct.cuisine

ORDER BY cr.total_revenue DESC;
