


--we had to change the data type of event_date from text to timestamp for us to query
ALTER TABLE user_events
ALTER COLUMN event_date TYPE TIMESTAMP
USING event_date::timestamp;
--average time taken for each event type & conversion rate time
WITH time_taken AS (
	SELECT 
		user_id,
		MIN(event_date) FILTER (WHERE event_type = 'page_view') AS page_view_time,
		MIN(event_date) FILTER (WHERE event_type = 'add_to_cart') AS add_to_cart_time,
		MIN(event_date) FILTER (WHERE event_type = 'purchase') AS purchase_time
	FROM user_events
	WHERE event_date >= TIMESTAMP '2026-02-03 04:10:18.555' - INTERVAL '30 days'
	GROUP BY user_id 
	HAVING MIN(event_date) FILTER (WHERE event_type = 'purchase') IS NOT NULL
)

SELECT 
	COUNT(user_id) AS converted_users,
--EXTRACT(EPOCH FROM() function is used to calculate the difference in seconds between two timestamps, and then we divide by 60 to convert it to minutes. The ROUND function is used to round the result to 1 decimal place for better readability.)
	ROUND(AVG(EXTRACT(EPOCH FROM (add_to_cart_time - page_view_time)) / 60) ,1) AS view_to_cart,
	ROUND(AVG(EXTRACT(EPOCH FROM (purchase_time - add_to_cart_time)) / 60) ,1)  AS cart_to_purchase,
	ROUND(AVG(EXTRACT(EPOCH FROM (purchase_time - page_view_time)) / 60),1) AS view_to_purchase
FROM time_taken;

