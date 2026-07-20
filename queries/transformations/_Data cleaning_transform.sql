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
    
    
    -- Country metrics/ranked by salary cost index ratio --
    SELECT * FROM countries.country_analysis;
WITH country_metrics AS
(
    SELECT
        Country,
        Average_Annual_Salary_USD,
        `Cost of Living Index`,
        `Local Purchasing Power Index`,

        ROUND(
            Average_Annual_Salary_USD /
            `Cost of Living Index`,
            2
        ) AS SalaryCostIndexRatio
    FROM country_analysis
)

SELECT
    Country,
    Average_Annual_Salary_USD,
    `Cost of Living Index`,
    `Local Purchasing Power Index`,
    SalaryCostIndexRatio,

    RANK() OVER (
        ORDER BY SalaryCostIndexRatio DESC
    ) AS RatioRank

FROM country_metrics;

WITH country_metrics AS
(
    SELECT
        Country,
        Average_Annual_Salary_USD,
        `Cost of Living Index`,
        `Local Purchasing Power Index`,

        ROUND(
            Average_Annual_Salary_USD /
            `Cost of Living Index`,
            2
        ) AS SalaryCostIndexRatio

    FROM country_analysis
),

ranked AS
(
    SELECT
        *,
        NTILE(4) OVER(
            ORDER BY SalaryCostIndexRatio DESC
        ) AS RatioQuartile

    FROM country_metrics
)

SELECT
    *,
    CASE
        WHEN RatioQuartile = 1 THEN 'Top 25%'
        WHEN RatioQuartile = 2 THEN 'Upper Middle'
        WHEN RatioQuartile = 3 THEN 'Lower Middle'
        ELSE 'Bottom 25%'
    END AS SalaryValueCategory

FROM ranked;