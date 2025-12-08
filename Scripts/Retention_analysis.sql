WITH churned_customers AS (
    SELECT
        customerkey,
        cohort_year,
        MAX(orderdate) AS last_day_purchase,
        CASE
            WHEN MAX(orderdate) < (SELECT MAX(orderdate) FROM sales)::DATE - INTERVAL '6 months' THEN 'Churned'
            ELSE 'Active'
        END AS customer_status
    FROM cohort_analysis
    WHERE first_purchase_date < (SELECT MAX(orderdate) FROM sales)::DATE - INTERVAL '6 months' 
    GROUP BY customerkey, cohort_year, first_purchase_date
)
SELECT
    cohort_year,
    customer_status,
    COUNT(customerkey) AS num_customers,
    SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year) AS total_customers,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year), 2) AS percentage
FROM churned_customers
GROUP BY cohort_year, customer_status
ORDER BY cohort_year, customer_status