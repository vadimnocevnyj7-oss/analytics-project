WITH weekly_sessions AS (
    SELECT
        DATE_TRUNC('week', session_date_time) AS week_start,
        mentor_id,
        COUNT(*) AS sessions_in_this_week
    FROM sessions
    WHERE session_status = 'finished'
    GROUP BY DATE_TRUNC('week', session_date_time), mentor_id
)
SELECT
    DATE_TRUNC('month', week_start) AS month,
    mentor_id,
    ROUND(AVG(sessions_in_this_week), 2) AS avg_sessions_per_week
FROM weekly_sessions
GROUP BY DATE_TRUNC('month', week_start), mentor_id
ORDER BY month, mentor_id;

WITH weekly_sessions AS (
    SELECT
        DATE_TRUNC('week', session_date_time) AS week,
        mentor_id,
        COUNT(*) AS successful_sessions
    FROM sessions
    WHERE session_status = 'finished'
    GROUP BY DATE_TRUNC('week', session_date_time), mentor_id
),
monthly_avg AS (
    SELECT
        DATE_TRUNC('month', week) AS month,
        mentor_id,
        AVG(successful_sessions) AS avg_sessions_per_week
    FROM weekly_sessions
    GROUP BY DATE_TRUNC('month', week), mentor_id
)
SELECT
    month,
    mentor_id,
    CAST(ROUND(avg_sessions_per_week, 2) AS REAL) AS avg_sessions_per_week,
    CAST(ROUND(
        avg_sessions_per_week - LAG(avg_sessions_per_week) OVER (
            PARTITION BY mentor_id
            ORDER BY month
        ),
        2
    ) AS REAL) AS change_from_previous_month
FROM monthly_avg
ORDER BY mentor_id, month;