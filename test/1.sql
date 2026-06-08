
SELECT 
  EXTRACT("MONTH" FROM ua.event_date) as month,  
  COUNT(DISTINCT ua.user_id) as monthly_active_users
FROM user_actions ua
JOIN user_actions ua1
ON ua1.user_id = ua.user_id
WHERE EXTRACT("MONTH" FROM ua.event_date) = 7
AND EXTRACT("MONTH" FROM ua1.event_date) = 6
GROUP BY (EXTRACT("MONTH" FROM ua.event_date));
