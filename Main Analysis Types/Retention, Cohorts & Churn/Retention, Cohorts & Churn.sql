WITH sub_dates AS (
SELECT
user_pseudo_id,
MIN(DATE_TRUNC(subscription_start,week)) as start_week,
MAX((DATE_TRUNC(subscription_end,week))) as last_week
FROM `turing_data_analytics.subscriptions`
GROUP BY user_pseudo_id
)

SELECT
start_week,
SUM (CASE WHEN start_week IS NOT NULL THEN 1 ELSE 0 END) AS user_count,
SUM (CASE WHEN start_week = last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_0,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 1 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_1,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 2 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_2,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 3 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_3,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 4 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_4,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 5 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_5,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 6 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_6
FROM sub_dates
GROUP BY 1
ORDER BY 1