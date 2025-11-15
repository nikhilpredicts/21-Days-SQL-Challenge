
use hospital;

-- Day 12: Challenge
/*
Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status 
('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. 
Order by average patient satisfaction descending.
*/
SELECT
  CASE 
    WHEN event = 'none' THEN 'No Event'
    ELSE 'With Event'
  END AS event_status,
  COUNT(DISTINCT week) AS week_count,
  ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction,
  ROUND(AVG(staff_morale), 2) AS avg_staff_morale
FROM
  services_weekly
GROUP BY
  CASE 
    WHEN event = 'none' THEN 'No Event'
    ELSE 'With Event'
  END
ORDER BY
  avg_patient_satisfaction DESC;
  
  -- Practice Questions:
  -- 1. Find all weeks in services_weekly where no special event occurred.
SELECT 
    *
FROM services_weekly
WHERE event IS NULL OR event = 'none';

-- 2.Count how many records have null or empty event values.
SELECT 
  COUNT(*) AS null_or_empty_event_count
FROM 
  services_weekly
WHERE 
  event IS NULL 
  OR TRIM(event) = '';


-- 3.List all services that had at least one week with a special event.
SELECT DISTINCT service
FROM services_weekly
WHERE event IS NOT NULL 
  AND event <> '' 
  AND event <> 'none';