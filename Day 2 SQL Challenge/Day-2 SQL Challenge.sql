
-- Day-2 Challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, 
-- showing their patient_id, name, age, and satisfaction score.
SELECT patient_id, name, age,service
FROM patients WHERE service="surgery" and satisfaction <70; 

-- Practice Questions:
-- Find all patients who are older than 60 years.
SELECT * FROM patients where age>60;

-- Retrieve all staff members who work in the 'Emergency' service.
SELECT * FROM staff where service="Emergency";

-- List all weeks where more than 100 patients requested admission in any service.
SELECT DISTINCT * FROM services_weekly WHERE patients_request > 100;
