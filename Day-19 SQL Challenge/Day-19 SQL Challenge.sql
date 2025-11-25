
use hospital;

-- Day-19 SQL Challenge:
/*
For each service, rank the weeks by patient satisfaction score (highest first). 
Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
*/
SELECT service, week, patient_satisfaction, patients_admitted, rnk
FROM(
SELECT
	service,
    week,
    patient_satisfaction,
    patients_admitted,
    RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction DESC) as rnk
FROM services_weekly
) t
WHERE rnk <=3
ORDER BY service,rnk;

-- Practice Questions:
-- 1.Rank patients by satisfaction score within each service.
SELECT
	*,
    RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction DESC) AS patients_rank
FROM services_weekly;

-- 2.Assign row numbers to staff ordered by their name.
SELECT 
	staff_id,
    staff_name,
    role,
    ROW_NUMBER() OVER(ORDER BY staff_name) AS staff_row_number
FROM staff;

-- 3.Rank services by total patients admitted.
SELECT
	service,
    SUM(patients_admitted) as total_patients_admitted,
    RANK() OVER(ORDER BY SUM(patients_admitted) DESC ) AS admission_rank
FROM
	services_weekly
GROUP BY service;