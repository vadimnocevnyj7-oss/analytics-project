-- Самый популярный день недели по каждому направлению за последний полный месяц
WITH last_full_month AS (
    SELECT
        DATE_TRUNC('month', MAX(session_date_time))
        - INTERVAL '1 month' AS month_start
    FROM sessions
),
weekday_stats AS (
    SELECT
        d.name,
        EXTRACT(ISODOW FROM s.session_date_time) AS weekday_num,
        TO_CHAR(s.session_date_time, 'FMDay') AS weekday_name,
        COUNT(*) AS meetings_count
    FROM sessions s
    JOIN domain d
        ON s.mentor_domain_id = d.id
    CROSS JOIN last_full_month lm
    WHERE s.session_date_time >= lm.month_start
      AND s.session_date_time < lm.month_start + INTERVAL '1 month'
    GROUP BY
        d.name,
        weekday_num,
        weekday_name
)
SELECT
    name AS "Тип направления",
    TRIM(weekday_name) AS "День недели",
    meetings_count AS "Количество встреч"
FROM (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY name
            ORDER BY meetings_count DESC
        ) AS rnk
    FROM weekday_stats
) t
WHERE rnk = 1
ORDER BY name;
