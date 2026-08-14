-- ТОП-5 менторов по количеству сессий за последний полный месяц в предоставленном датасете.
-- Последний полный месяц — август 2022 года, поскольку данные за сентябрь заканчиваются 15.09.2022.
SELECT
    mentor_id,
    COUNT(*) AS sessions_count
FROM sessions
WHERE session_date_time >= '2022-08-01'
  AND session_date_time < '2022-09-01'
GROUP BY mentor_id
ORDER BY sessions_count DESC
LIMIT 5;
