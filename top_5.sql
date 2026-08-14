-- ТОП-5 менторов по количеству успешных сессий за последний полный месяц в датасете

WITH last_full_month AS (
    SELECT
        DATE_TRUNC('month', MAX(session_date_time)) - INTERVAL '1 month' AS month_start
    FROM sessions
)
SELECT
    mentor_id,
    COUNT(*) AS sessions_count
FROM sessions
CROSS JOIN last_full_month
WHERE session_status = 'finished'
  AND session_date_time >= month_start
  AND session_date_time < month_start + INTERVAL '1 month'
GROUP BY mentor_id
ORDER BY sessions_count DESC
LIMIT 5;
