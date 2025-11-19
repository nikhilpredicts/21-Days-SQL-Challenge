
use hospital;


-- Day-15 SQL Challenge:
/*
Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, 
total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week.
Order by patients admitted descending.
*/
SELECT
    sw.week,
    sw.service,
    sw.Total_Patients_Admitted,
    sw.Total_Patients_Refused,
    sw.Average_Patient_Satisfaction,
    COUNT(DISTINCT s.staff_id) AS Staff_Assigned,
    COUNT(DISTINCT CASE WHEN sch.present = 1 THEN sch.staff_id END) AS Staff_Present
FROM (
    SELECT
        week,
        service,
        SUM(patients_admitted) AS Total_Patients_Admitted,
        SUM(patients_refused) AS Total_Patients_Refused,
        AVG(patient_satisfaction) AS Average_Patient_Satisfaction
    FROM services_weekly
    WHERE week = 20
    GROUP BY week, service
) sw
LEFT JOIN staff s 
    ON sw.service = s.service
LEFT JOIN staff_schedule sch 
    ON s.staff_id = sch.staff_id AND sw.week = sch.week
GROUP BY
    sw.week, sw.service,
    sw.Total_Patients_Admitted,
    sw.Total_Patients_Refused,
    sw.Average_Patient_Satisfaction
ORDER BY
    sw.Total_Patients_Admitted DESC;


-- Practice Questions:
-- 1.Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT
	p.patient_id,
    p.name,
    p.service,
    s.staff_name,
    s.role,
    sch.week,
    sch.present
FROM
	patients p 
    INNER JOIN staff s ON p.service=s.service
	INNER JOIN staff_schedule sch ON s.staff_id=sch.staff_id;
    
-- 2.Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT
	sw.service,
    sw.week,
    sw.patients_admitted,
    s.staff_name,
    sch.present
FROM 
	services_weekly sw
    INNER JOIN staff s ON sw.service=s.service
    LEFT JOIN staff_schedule sch ON s.staff_id=sch.staff_id AND sch.week =sw.week;

-- 3.Create a multi-table report showing patient admissions with staff information.
SELECT
	p.patient_id,
    p.name,
    sw.week,
    s.staff_name,
    s.role,
    sch.present
FROM
	patients p
    LEFT JOIN services_weekly sw ON p.service=sw.service
    LEFT JOIN staff s ON p.service=s.service
    LEFT JOIN  staff_schedule sch ON s.staff_id=sch.staff_id;