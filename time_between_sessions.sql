-- Среднее время между первой и второй успешной сессией ментора
WITH mentor_sessions AS (
    SELECT
        mentor_id,
        session_date_time,
        ROW_NUMBER() OVER (
            PARTITION BY mentor_id
            ORDER BY session_date_time
        ) AS rn
    FROM sessions
    WHERE session_status = 'finished'
),
first_second AS (
    SELECT
        mentor_id,
        MAX(CASE WHEN rn = 1 THEN session_date_time END) AS first_session,
        MAX(CASE WHEN rn = 2 THEN session_date_time END) AS second_session
    FROM mentor_sessions
    WHERE rn <= 2
    GROUP BY mentor_id
)
SELECT
    AVG(second_session - first_session) AS avg_time_between_sessions
FROM first_second
WHERE second_session IS NOT NULL;

-- Среднее время между первой и второй успешной сессией менти
WITH mentee_sessions AS (
    SELECT
        mentee_id,
        session_date_time,
        ROW_NUMBER() OVER (
            PARTITION BY mentee_id
            ORDER BY session_date_time
        ) AS rn
    FROM sessions
    WHERE session_status = 'finished'
),
first_second AS (
    SELECT
        mentee_id,
        MAX(CASE WHEN rn = 1 THEN session_date_time END) AS first_session,
        MAX(CASE WHEN rn = 2 THEN session_date_time END) AS second_session
    FROM mentee_sessions
    WHERE rn <= 2
    GROUP BY mentee_id
)
SELECT
    AVG(second_session - first_session) AS avg_time_between_sessions
FROM first_second
WHERE second_session IS NOT NULL;
