-- Task 3
SELECT v.position_name, a.area_name, e.employer_name
FROM vacancy AS v
         INNER JOIN employer AS e
                    ON e.employer_id = v.employer_id
         INNER JOIN area AS a
                    ON e.area_id = a.area_id
WHERE v.compensation_from IS NULL AND v.compensation_to IS NULL
ORDER BY v.created_on DESC
LIMIT 10;

-- Task 4
SELECT AVG(compensation_from) AS min_avg,
       AVG(compensation_to) AS max_avg,
       AVG((compensation_from + compensation_to) / 2) AS avg_avg
FROM (SELECT
             CASE
                 WHEN compensation_gross IS TRUE
                     THEN compensation_to * 0.87
                 ELSE compensation_to
                 END AS compensation_to,
             CASE
                 WHEN compensation_gross IS TRUE
                     THEN compensation_from * 0.87
                 ELSE compensation_from
                 END AS compensation_from
      FROM vacancy) AS ctcf;

-- Task 5
SELECT name, num_of_responces
FROM (SELECT employer_name AS name, COUNT(response_id) AS num_of_responces
      FROM employer AS e
               LEFT JOIN vacancy AS v
                         ON e.employer_id = v.employer_id
               LEFT JOIN response AS r
                         ON v.vacancy_id = r.vacancy_id
      GROUP BY e.employer_id) AS nnor
ORDER BY num_of_responces DESC, name
LIMIT 5;

--Task 6
SELECT percentile_cont(0.50) WITHIN GROUP ( ORDER BY n) AS median
FROM (SELECT COUNT(*) AS n
      FROM employer
               LEFT JOIN vacancy v ON employer.employer_id = v.employer_id
      GROUP BY employer_name) AS evn ;

--Task 7
SELECT area_name, min(response_time) AS min, max(response_time) AS max
FROM (SELECT r.vacancy_id, min(r.created_on - v.created_on) AS response_time
      FROM response AS r
               INNER JOIN vacancy AS v ON v.vacancy_id = r.vacancy_id
      GROUP BY r.vacancy_id) AS virt
         INNER JOIN employer AS e ON e.employer_id = vacancy_id
         INNER JOIN area AS a ON e.area_id = a.area_id
GROUP BY area_name;
