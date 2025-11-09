

use hospital;

-- Gay-6 Challenge:
/*
  For each hospital service, calculate the total number of patients admitted, total patients refused, 
  and the admission rate (percentage of requests that were admitted). Order by admission rate descending. 
*/

SELECT 
	service,
    SUM(patients_admitted) AS Total_no_of_Patients_Admitted, 
    SUM(patients_refused) AS Total_no_of_Patients_Refused,
	ROUND((SUM(patients_admitted)/SUM(patients_request))*100,2) AS Admission_rate 
FROM services_weekly 
GROUP BY service 
ORDER BY Admission_rate DESC;

-- Practice Questions:
-- 1.Count the number of patients by each service.
SELECT
	service,
    COUNT(patient_id) as No_of_Patients
FROM patients
GROUP BY service;

-- 2.Calculate the average age of patients grouped by service.
SELECT
 service,
 ROUND(AVG(age),2) as Average_Age
FROM patients
GROUP BY service;

-- 3.Find the total number of staff members per role.
SELECT
	role,
    count(staff_id) as Total_Staff_Members
FROM staff
GROUP BY role;
	