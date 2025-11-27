
use hospital;

-- Day-21 SQL Challenge:
/*
Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions,
refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score (weighted average
of admission rate and satisfaction). Order by performance score descending.
*/
WITH service_level_metrices AS (
    SELECT service, SUM(patients_admitted) AS total_patients_admitted, SUM(patients_refused) AS total_patients_refused,
           SUM(patients_request) AS total_request, ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
    FROM services_weekly GROUP BY service),
staff_metrice_per_service AS(
    SELECT s.service, COUNT(DISTINCT s.staff_id) AS total_staff,
           ROUND(AVG(ss.tp), 2) AS avg_present_staff
    FROM staff_schedule AS s
    JOIN (
            SELECT week, service, SUM(present) AS tp
            FROM staff_schedule
            GROUP BY week, service
        ) ss
    USING (service, week) GROUP BY s.service),
patient_demographics AS (
    SELECT service, ROUND(AVG(age), 2) AS average_age, COUNT(*) AS count_of_patients
    FROM patients
    GROUP BY service)
SELECT s.service, s.total_patients_admitted, s.total_patients_refused, s.avg_satisfaction, sm.total_staff,
       sm.avg_present_staff, pd.average_age, pd.count_of_patients,
       ROUND(((s.total_patients_admitted * 100.0 / s.total_request) + s.avg_satisfaction) / 2, 2) AS performance_score
FROM service_level_metrices s
JOIN staff_metrice_per_service AS sm ON s.service = sm.service
JOIN patient_demographics AS pd ON s.service = pd.service
ORDER BY performance_score DESC;
