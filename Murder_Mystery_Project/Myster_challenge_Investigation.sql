/* 1. Identify where and when the crime happened */
SELECT *
FROM evidence
WHERE found_time BETWEEN '2025-10-15 20:45:00'
                     AND '2025-10-15 21:15:00'
ORDER BY found_time;

/* 2. Analyze who accessed critical areas at the time */
SELECT 
    k.log_id,
    k.employee_id,
    e.name,
    k.room,
    k.entry_time,
    k.exit_time
FROM keycard_logs AS k
JOIN employees AS e 
    ON k.employee_id = e.employee_id
WHERE k.room = 'CEO Office'
  AND (
        k.entry_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:15:00'
        OR
        k.exit_time  BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:15:00'
      )
ORDER BY k.entry_time;

/* 3. Cross-check alibis with actual logs */
SELECT 
    a.alibi_id,
    a.employee_id,
    a.claimed_location,
    a.claim_time,
    k.log_id,
    k.room AS actual_room,
    k.entry_time,
    k.exit_time
FROM alibis AS a
JOIN employees AS e 
    ON a.employee_id = e.employee_id
LEFT JOIN keycard_logs AS k
    ON a.employee_id = k.employee_id
    AND a.claim_time BETWEEN k.entry_time AND k.exit_time
WHERE a.claim_time BETWEEN '2025-10-15 20:45:00'
                       AND '2025-10-15 21:15:00';

/* 4. Investigate suspicious calls made around the time */
SELECT 
    caller.name AS caller_name,
    receiver.name AS receiver_name,
    c.call_id,
    c.caller_id,
    c.receiver_id,
    c.call_time
FROM calls AS c
LEFT JOIN employees AS caller
       ON c.caller_id = caller.employee_id
LEFT JOIN employees AS receiver
       ON c.receiver_id = receiver.employee_id
WHERE c.call_time BETWEEN '2025-10-15 20:45:00'
                      AND '2025-10-15 21:15:00'
ORDER BY c.call_time;

/* 5. Match evidence with movements and claims */
SELECT 
    ev.evidence_id,
    ev.room,
    ev.description,
    ev.found_time,
    k.employee_id,
    emp.name,
    k.entry_time,
    k.exit_time
FROM evidence AS ev
LEFT JOIN keycard_logs AS k
       ON ev.room = k.room
      AND ev.found_time BETWEEN k.entry_time AND k.exit_time
LEFT JOIN employees AS emp
       ON k.employee_id = emp.employee_id
WHERE ev.room = 'CEO Office'
ORDER BY ev.found_time;

/* 6. Combine all findings to identify the killer */

WITH in_office AS (
    SELECT DISTINCT k.employee_id
    FROM keycard_logs k
    WHERE k.room = 'CEO Office'
      AND k.entry_time <= DATE_SUB('2025-10-15 21:00:00', INTERVAL -5 MINUTE)
      AND k.exit_time  >= DATE_SUB('2025-10-15 21:00:00', INTERVAL 20 MINUTE)
),

bad_alibi AS (
    SELECT DISTINCT a.employee_id
    FROM alibis a
    LEFT JOIN keycard_logs k
           ON a.employee_id = k.employee_id
          AND a.claim_time BETWEEN k.entry_time AND k.exit_time
    WHERE a.claim_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:05:00'
      AND (k.room IS NULL OR k.room <> a.claimed_location)
),

calls_nearby AS (
    SELECT DISTINCT c.caller_id AS employee_id
    FROM calls c
    WHERE c.call_time BETWEEN '2025-10-15 20:40:00' AND '2025-10-15 21:05:00'
)

SELECT emp.name AS killer
FROM employees emp
WHERE emp.employee_id IN (SELECT employee_id FROM in_office)
  AND emp.employee_id IN (SELECT employee_id FROM bad_alibi)
  AND emp.employee_id IN (SELECT employee_id FROM calls_nearby);
  
  
  
  
  
  
  use murder_mystery;
