use hospital;

-- Day-3 Challenge
/* Retrieve the top 5 weeks with the highest patient refusals across all services,
 showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order. */
SELECT week,service,patients_refused,patients_request 
FROM services_weekly ORDER BY patients_refused DESC LIMIT 5;

-- Practice Questions:
-- List all patients sorted by age in descending order.
SELECT * FROM patients ORDER BY age desc;

-- Show all services_weekly data sorted by week number ascending and patients_request descending.
SELECT * FROM services_weekly ORDER BY week ASC,patients_request desc;

-- Display staff members sorted alphabetically by their names.
SELECT * FROM staff ORDER BY staff_name ASC;
