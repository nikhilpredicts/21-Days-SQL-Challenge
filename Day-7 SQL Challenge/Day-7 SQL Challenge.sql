

use hospital;

-- Day-6 Challenge:
/*
Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. 
Show service name, total refused, and average satisfaction.
*/
SELECT
	service,
    SUM(patients_refused) AS Total_Refused,
    AVG(patient_satisfaction) AS Average_Satisfaction
FROM services_weekly
GROUP BY service
HAVING Total_Refused > 100 AND Average_Satisfaction < 80; 

-- Practice Questions.
-- 1.Find services that have admitted more than 500 patients in total. 
SELECT
	service,
    SUM(patients_admitted) AS Patients_Admitted
FROM services_weekly
GROUP BY service
HAVING Patients_admitted > 500;

-- 2.Show services where average patient satisfaction is below 75.
SELECT
	service,
    AVG(patient_satisfaction) AS Avg_Patient_Satisfaction
FROM services_weekly
GROUP BY service
HAVING Avg_Patient_Satisfaction < 75;

-- 3.List weeks where total staff presence across all services was less than 50.
SELECT
	week
FROM staff_schedule
GROUP BY week
HAVING SUM(present) < 50;