WITH customer_ltv AS (
    SELECT
        customerkey,
        cleaned_name,
        SUM(total_net_revenue) AS total_ltv
    FROM cohort_analysis
    GROUP BY customerkey, cleaned_name
), percentile_lvl AS (
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_pct,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_pct
FROM customer_ltv
), segment_values AS (
SELECT
    cl.customerkey,
    cl.cleaned_name,
    cl.total_ltv,
    CASE
        WHEN total_ltv < pct.ltv_25th_pct THEN '1 - Low-Value'
        WHEN total_ltv <= pct.ltv_75th_pct THEN '2 - Mid-Value'
        ELSE '3 - High-Value'
    END AS customer_segment
FROM customer_ltv cl, percentile_lvl pct
)
SELECT
    customer_segment,
    SUM(total_ltv) AS total_ltv,
    COUNT(customerkey) AS segment_count,
    SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM segment_values
GROUP BY customer_segment
ORDER BY total_ltv