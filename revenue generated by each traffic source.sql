
SELECT 
    CASE
        WHEN traffic_source = 'email' THEN 'Email'
        WHEN traffic_source = 'organic' THEN 'Organic'
        WHEN traffic_source = 'paid_ads' THEN 'Paid Ads'
        WHEN traffic_source = 'social' THEN 'Social'
        ELSE 'Other'
    END AS traffic_source_name,
    SUM(amount) AS total_revenue
FROM user_events
WHERE  event_date::DATE >= DATE '2026-02-03' - INTERVAL '30 days'
AND event_type = 'purchase'
GROUP BY traffic_source;

