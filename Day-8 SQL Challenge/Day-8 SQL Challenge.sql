

use hospital;

-- Day-6 Challenge:
/*
Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, 
age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length.
Only show patients whose name length is greater than 10 characters.
*/
SELECT
	patient_id,
    UPPER(name) AS Patient_Name,
    LOWER(service) AS Service,
    age,
CASE 
	WHEN age >=65 THEN 'Senior'
    WHEN age >=18 THEN 'Adult'
    ELSE 'Minor'
END AS Age_Category,
LENGTH(name) AS Name_length
FROM patients
WHERE LENGTH(name) >10;

-- Practice Questions:
-- 1.Convert all patient names to uppercase.
SELECT
	UPPER(name) AS Names_Upper_Case
FROM 
	patients;
    
-- 2.Find the length of each staff member's name.
SELECT
	staff_name,
	LENGTH(staff_name) as Staff_Name_Length
FROM
	staff;
    
-- 3.Concatenate staff_id and staff_name with a hyphen separator.
SELECT
	CONCAT(staff_id,'-',staff_name) AS "Staff_id-Staff_Name"
FROM
	staff;