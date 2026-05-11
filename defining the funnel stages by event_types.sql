
	SELECT 
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'page_view') AS stage_1_views,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'add_to_cart') AS stage_2_cart,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'checkout_start') AS stage_3_checkout,
			COUNT (DISTINCT user_id)FILTER (WHERE event_type = 'payment_info') AS stage_4_payment,
			COUNT (DISTINCT user_id) FILTER (WHERE event_type = 'purchase') AS stage_5_purchase
	FROM user_events;
	