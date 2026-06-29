SELECT
    COUNT(*) AS mentors_without_sessions
FROM teachers t
WHERE t.id NOT IN (
    SELECT DISTINCT mentor_id
    FROM sessions
    
);

SELECT
    COUNT(*) AS mentees_without_sessions
FROM students s
WHERE s.id NOT IN (
    SELECT DISTINCT mentee_id
    FROM sessions
);