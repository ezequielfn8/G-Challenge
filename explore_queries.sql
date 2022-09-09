--query1

WITH hired_employees_final AS(
    SELECT id, name, department_id, job_id,
    'Q'+CAST(DATEPART(QUARTER, datetime)AS VARCHAR(MAX)) AS Quarter
    FROM hired_employees
)
SELECT d.departments,
j.jobs,
ISNULL([Q1],0) AS Q1,
ISNULL([Q2],0) AS Q2,
ISNULL([Q3],0) AS Q3,
ISNULL([Q4],0) AS Q4
FROM hired_employees_final e
LEFT JOIN jobs j
ON e.job_id = j.job_id
RIGHT JOIN departments d
ON e.department_id = d.id
GROUP BY 1,2
ORDER BY 1,2 ASC
PIVOT (COUNT(*) FOR e.Quarter IN ([Q1],[Q2],[Q3],[Q4])) AS PVT



--query2
SELECT d.id, d.department, count(e.id) AS hired
FROM hired_employees e
RIGHT JOIN department d
ON e.department_id = d.id
GROUP BY 2
HAVING COUNT(e.id) > (
    SELECT AVG(id) FROM hired_employees
    WHERE YEAR(datetime) = 2021)
ORDER BY hired DESC