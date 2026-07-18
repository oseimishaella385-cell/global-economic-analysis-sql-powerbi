SELECT * 
FROM countries.salaries
Where UNIT_MEASURE = 'USD_PPP' AND TIME_PERIOD = 2024;

-- Correct country names
UPDATE salaries
SET ReferenceArea = 'Turkey'
WHERE ReferenceArea = 'Türkiye';

-- Check for duplicate countries
SELECT ReferenceArea, COUNT(*)
FROM salaries
GROUP BY ReferenceArea
HAVING COUNT(*) > 1;
    
    SELECT
    c.Country,
    s.Average_Annual_Salary_USD,
    c.`Cost of Living Index`,
    c.`Local Purchasing Power Index`
FROM cost_of_living c
INNER JOIN salaries s
    ON c.Country = s.ReferenceArea;