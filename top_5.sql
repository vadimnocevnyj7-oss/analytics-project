-- Последний полный месяц в датасете — август 2022 года.
-- Сентябрь содержит данные только до 15 числа.
SELECT
    mentor_id,
    COUNT(*) AS sessions_count
FROM sessions
WHERE session_date_time >= '2022-08-01'
  AND session_date_time < '2022-09-01'
GROUP BY mentor_id
ORDER BY sessions_count DESC
LIMIT 5;
