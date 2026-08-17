import sqlite3
import csv

conn = sqlite3.connect("swiggy_capstone.db")

query = """
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
"""

cur = conn.execute(query)

with open(
    "monthly_cuisine_revenue.csv",
    "w",
    newline="",
    encoding="utf-8"
) as f:

    writer = csv.writer(f)

    writer.writerow([
        "cuisine",
        "month",
        "order_count",
        "total_revenue",
        "avg_revenue"
    ])

    writer.writerows(cur.fetchall())

conn.close()

print("monthly_cuisine_revenue.csv created.")
