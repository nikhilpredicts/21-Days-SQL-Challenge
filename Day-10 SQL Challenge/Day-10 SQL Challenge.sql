

USE hospital;

-- Day-10 SQL Challenge:
/*
Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85,
'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
*/
SELECT 
	service,
    SUM(patients_admitted) as Total_Patients_Admitted,
    ROUND(AVG(patient_satisfaction), 2) AS Avg_Satisfaction,
CASE
	WHEN AVG(patient_satisfaction) >=85 THEN 'Excellent'
    WHEN AVG(patient_satisfaction) >=75 THEN 'Good'
    WHEN AVG(patient_satisfaction) >=65 THEN 'Fair'
	ELSE 'Needs Improvement'
END AS Performance_Category
FROM services_weekly
GROUP BY service
ORDER BY AVG(patient_satisfaction) DESC;

-- Practice Questions:
-- 1.Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT
	patient_id,
    name,
    age,
CASE
	WHEN satisfaction >=80 THEN 'High'
    WHEN satisfaction >=60 THEN 'Medium'
	ELSE 'Low'
END AS Satisfaction_Level
FROM patients;

-- 2.Label staff roles as 'Medical' or 'Support' based on role type.
SELECT
	*,
CASE
	WHEN role IN ('doctor','nurse') THEN 'Medical'
    ELSE 'Support'
end as Role_Type
FROM staff;

-- 3.Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT
	patient_id,
    name,
    age,
CASE
	WHEN age >65 THEN 'Senior Citizen'
    WHEN age >40 and age <=65 THEN 'Middle-Aged'
    WHEN age >18 and age <=40 THEN 'Major'
ELSE 'Minor'
END AS Age_Group
FROM patients;