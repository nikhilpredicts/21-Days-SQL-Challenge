
USE hospital;

-- Day:9 SQL Challenge
/* 1. Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending. */
SELECT
	service,
    COUNT(patient_id) as Patient_Count,
    ROUND(AVG(DATEDIFF(departure_date,arrival_date)),2) as Average_Stay_Days
FROM patients
GROUP BY service
HAVING Average_Stay_Days >7
ORDER BY Average_Stay_Days DESC;

-- Practice Questions:
-- 1.Extract the year from all patient arrival dates.
SELECT
	patient_id,
    name,
	arrival_date,
	YEAR(arrival_date) as Arrival_Year
FROM patients;

-- 2.Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT
	patient_id,
	name AS Patient_Name,
    DATEDIFF(departure_date,arrival_date) as Length_Of_Stay
FROM patients;

-- 3.Find all patients who arrived in a specific month.
SELECT
	*
FROM patients
WHERE MONTH(arrival_date)=4;