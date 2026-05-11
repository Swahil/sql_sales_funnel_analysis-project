

--KPIs
WITH loreso_funnel AS (
	SELECT 
    SUM(amount) FILTER (WHERE event_type ='purchase') AS total_revenue,
    COUNT(*) FILTER(WHERE event_type='purchase') AS total_orders,
    COUNT(DISTINCT product_id) AS unique_products_sold,
    COUNT(user_id) FILTER (WHERE event_type = 'purchase') AS total_buyers,
    COUNT(user_id) FILTER (WHERE event_type = 'page_view') AS total_visitors
FROM user_events
WHERE  event_date::DATE >= DATE '2026-02-03' - INTERVAL '30 days'
)
SELECT 
	total_revenue,
	unique_products_sold,
	total_orders,
	total_buyers,
	total_visitors,
    ROUND(total_revenue::NUMERIC/total_visitors::NUMERIC,2) AS rev_per_visitor,
    ROUND(total_revenue::NUMERIC/total_buyers::NUMERIC,2) AS rev_per_buyer,
    ROUND(total_revenue::NUMERIC/total_orders::NUMERIC,2) AS rev_per_order,
    ROUND(total_buyers::NUMERIC*100/total_visitors::NUMERIC,2) AS buyer_conversion_rate
FROM loreso_funnel;





