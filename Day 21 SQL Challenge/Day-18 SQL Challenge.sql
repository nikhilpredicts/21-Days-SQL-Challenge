
use hospital;

-- Day: 18 Challenge:
/* 
Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'),
and associated service. Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.
*/
SELECT 
 patient_id as identifier,
 name as full_name,
 'patient' as type,
 service
FROM patients
WHERE service IN('surgery','emergency')
UNION
SELECT
staff_id as identifier,
 staff_name as full_name,
 'staff' as type,
service
FROM staff
WHERE service IN('surgery','emergency')
ORDER BY type,service,full_name;

-- Practice Questions:
-- 1. Combine patient names and staff names into a single list.
SELECT
	name
FROM 
	patients
UNION ALL
SELECT
	staff_name
FROM
	staff;
    
-- 2.Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT
	patient_satisfaction
FROM services_weekly
WHERE patient_satisfaction> 90
UNION
SELECT
	patient_satisfaction
FROM services_weekly
WHERE patient_satisfaction< 50;

-- 3.List all unique names from both patients and staff tables.
SELECT
	name 
FROM patients
UNION
SELECT
	staff_name
FROM staff;