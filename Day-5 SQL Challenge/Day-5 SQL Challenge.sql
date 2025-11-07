
USE hospital;

-- Day-5 Challenge
/* Calculate the total number of patients admitted, total patients refused, 
and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places. */
SELECT
  SUM(patients_admitted) AS Total_Patients_Admitted,
  SUM(patients_refused) AS Total_Patients_Refused,
  ROUND(AVG(patient_satisfaction), 2) AS Average_Patient_Satisfaction
FROM services_weekly;

-- Practice Questions:
-- Count the total number of patients in the hospital.
SELECT COUNT(patient_id) as Total_Patients FROM patients;

-- Calculate the average satisfaction score of all patients.
SELECT AVG(satisfaction) as Average_Patient_Satisfaction FROM patients;

-- Find the minimum and maximum age of patients.
SELECT MIN(age) as Minimum_Age, MAX(age) as Maximum_Age from patients;