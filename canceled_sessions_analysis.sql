-- Количество отменённых сессий по направлениям
SELECT
    mentor_domain_id,
    COUNT(*) AS canceled_sessions
FROM sessions
WHERE session_status = 'canceled'
GROUP BY mentor_domain_id
ORDER BY canceled_sessions DESC;

-- Доля отменённых сессий по месяцам
SELECT
    DATE_TRUNC('month', session_date_time) AS month,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN session_status = 'canceled' THEN 1 ELSE 0 END) AS canceled_sessions,
    ROUND(
        100.0 * SUM(CASE WHEN session_status = 'canceled' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS canceled_share_percent
FROM sessions
GROUP BY month
ORDER BY month;
