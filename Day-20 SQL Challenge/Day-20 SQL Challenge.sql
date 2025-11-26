
use hospital;

-- Day-20 Challenge:
/*
Create a trend analysis showing for each service and week: week number, patients_admitted,
running total of patients admitted (cumulative), 3-week moving average of patient satisfaction 
(current week and 2 prior weeks), and the difference between current week admissions and the service average.
Filter for weeks 10-20 only.
*/
SELECT
    service,
    week,
    patients_admitted,
    cumulative_admitted,
    moving_avg_3wk_satisfaction,
    diff_from_service_avg
FROM (
    SELECT
        service,
        week,
        patients_admitted,
        SUM(patients_admitted) OVER (
            PARTITION BY service
            ORDER BY week
        ) AS cumulative_admitted,
        ROUND(
            AVG(patient_satisfaction) OVER (
                PARTITION BY service
                ORDER BY week
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ),
            2
        ) AS moving_avg_3wk_satisfaction,
        ROUND(
            patients_admitted -
            AVG(patients_admitted) OVER (PARTITION BY service),
            2
        ) AS diff_from_service_avg
    FROM services_weekly
) AS derived
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;

-- Practice Questions:
-- 1.Calculate running total of patients admitted by week for each service.
SELECT
	service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER(PARTITION BY service ORDER BY week ) AS running_total_admitted
FROM
	services_weekly
ORDER BY service,week;

-- 2.Find the moving average of patient satisfaction over 4-week periods.
SELECT
	service,
    week,
    patient_satisfaction,
    ROUND(
		AVG(patient_satisfaction) OVER(PARTITION BY service ORDER BY week ROWS BETWEEN 3 PRECEDING AND CURRENT ROW),
        2) AS moving_avg_4wk_satisfaction
FROM
	services_weekly
ORDER BY service,week;

-- 3.Show cumulative patient refusals by week across all services.
SELECT
	week,
    week_refused,
    SUM(week_refused) OVER( ORDER BY week ) AS cummulative_refused
FROM(
	SELECT week,SUM(patients_refused) AS week_refused
    FROM services_weekly GROUP BY week) as weekly_totals
ORDER BY week;