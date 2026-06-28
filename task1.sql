
SELECT
    month,
    mentors_cnt,
    mentees_cnt,
    mentors_cnt - LAG(mentors_cnt) OVER (ORDER BY month) AS mentors_change,
    mentees_cnt - LAG(mentees_cnt) OVER (ORDER BY month) AS mentees_change
FROM (
    SELECT
        DATE_TRUNC('month', session_date_time) AS month,
        COUNT(DISTINCT mentor_id) AS mentors_cnt,
        COUNT(DISTINCT mentee_id) AS mentees_cnt
    FROM sessions
    GROUP BY 1
) t
ORDER BY month;