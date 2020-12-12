-- Task 3
SELECT v.position_name, a.area_name, e.employer_name
FROM vacancy AS v
         INNER JOIN employer AS e
                    ON e.employer_id = v.employer_id
         INNER JOIN area AS a
                    ON e.area_id = a.area_id
WHERE v.compensation_gross IS NULL
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
FROM (SELECT employer_name AS name, COUNT(*) AS num_of_responces
      FROM employer AS e
               INNER JOIN vacancy AS v
                          ON e.employer_id = v.employer_id
               INNER JOIN response AS r
                          ON v.vacancy_id = r.vacancy_id
      GROUP BY employer_name) AS nnor
ORDER BY num_of_responces DESC, name
LIMIT 5 ;

--Task 6
SELECT percentile_cont(0.50) WITHIN GROUP ( ORDER BY n) AS median
FROM (SELECT COUNT(*) AS n
      FROM employer
               LEFT JOIN vacancy v ON employer.employer_id = v.employer_id
      GROUP BY employer_name) AS evn ;

--Task 7
SELECT area_name, min(r.created_on - v.created_on), max(r.created_on - v.created_on)
FROM area AS a
         LEFT JOIN employer e on a.area_id = e.area_id
         LEFT JOIN vacancy v on e.employer_id = v.employer_id
         LEFT JOIN response r on v.vacancy_id = r.vacancy_id
GROUP BY area_name;
