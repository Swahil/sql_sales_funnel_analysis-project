
WITH funnel_stages AS (
	SELECT 
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'page_view') AS stage_1_views,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'add_to_cart') AS stage_2_cart,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'checkout_start') AS stage_3_checkout,
			COUNT (DISTINCT user_id)FILTER (WHERE event_type = 'payment_info') AS stage_4_payment,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'purchase') AS stage_5_purchase
	FROM user_events
	WHERE  event_date::DATE >= DATE '2026-02-03' - INTERVAL '30 days'
	)
--conversion rate in the funnel stages
SELECT
			--stage_1_views,
			--stage_2_cart,
			ROUND(stage_2_cart *100/stage_1_views,2)AS view_to_cart_rate,
			--stage_3_checkout,
			ROUND(stage_3_checkout *100/stage_2_cart,2) AS cart_to_check_out_rate,
			--stage_4_payment,
			ROUND(stage_4_payment *100/stage_3_checkout,2) AS check_out_to_payment_rate,
			--stage_5_purchase,
			ROUND(stage_5_purchase *100/stage_4_payment,2) AS payment_to_purchase_rate,
			ROUND(stage_5_purchase *100/stage_1_views,2) AS overall_conversion_rate
FROM funnel_stages;

