--defining funnel & conversion rate of users by traffic_source
WITH funnel_by_traffic_source AS (
	SELECT 
		traffic_source,
		COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'page_view') AS stage_1_views,
		COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'add_to_cart') AS stage_2_cart,
		COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'checkout_start') AS stage_3_checkout,
		COUNT (DISTINCT user_id)FILTER (WHERE event_type = 'payment_info') AS stage_4_payment,
		COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'purchase') AS stage_5_purchase
	FROM user_events
	WHERE  event_date::DATE >= DATE '2026-02-03' - INTERVAL '30 days'
	GROUP BY traffic_source
)
SELECT 
	funnel_by_traffic_source.*,
	--stage_1_views,
	--stage_2_cart,
	ROUND(stage_2_cart*100/stage_1_views,2) AS views_cart_tsRATE,
	--stage_5_purchase,
	ROUND(stage_3_checkout*100/stage_2_cart,2) AS cart_checkout_tsRATE,
	ROUND(stage_5_purchase*100/stage_3_checkout,2) AS checkout_purchase_tsRATE,
	ROUND(stage_5_purchase*100/stage_1_views,2) AS views_purchase_tsRATE
FROM funnel_by_traffic_source;