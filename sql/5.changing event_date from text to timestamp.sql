/*we had to change the data type of event_date from text to timestamp for us to query*/

ALTER TABLE user_events
ALTER COLUMN event_date TYPE TIMESTAMP
USING event_date::timestamp;