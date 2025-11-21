

use hospital;

-- Day-16 SQL Challenge:
/*  Find all patients who were admitted to services that had at least one week where patients were refused 
AND the average patient satisfaction for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.
*/
SELECT 
	patient_id,
    name,
    service,
    satisfaction
FROM patients
WHERE service IN (
SELECT service
FROM services_weekly sw
WHERE patients_refused > 0 
GROUP BY service
HAVING AVG(patient_satisfaction)<(SELECT AVG(patient_satisfaction) FROM services_weekly)
);

-- Practise Questions:
-- 1.Find patients who are in services with above-average staff count.
SELECT
	*
FROM
patients p
WHERE p.service IN(
SELECT service
FROM staff
GROUP BY service
HAVING COUNT(DISTINCT staff_id) > (
	SELECT AVG(staff_cnt)
	FROM (
      SELECT COUNT(DISTINCT staff_id) as staff_cnt
      FROM staff 
      GROUP BY service
    ) t 
)
);

-- 2.List staff who work in services that had any week with patient satisfaction below 70.
SELECT
	*
FROM staff
WHERE service IN(
	SELECT DISTINCT(service)
	FROM services_weekly
    WHERE patient_satisfaction < 70
);

-- 3.Show patients from services where total admitted patients exceed 1000.
SELECT
	*
FROM
	patients
WHERE service IN(
SELECT
	service
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted)>1000
);