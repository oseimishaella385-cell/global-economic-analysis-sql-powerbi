-- Top ten counteries by average Salary--
SELECT * 
FROM countries.country_analysis
ORDER BY Average_Annual_Salary_USD DESC
LIMIT 10;

-- Top ten countries by cost of living index--
SELECT * 
FROM countries.country_analysis
ORDER BY `Cost of Living Index` DESC
LIMIT 10;

-- Top ten countries by local purchasing power index--
SELECT * 
FROM countries.country_analysis
ORDER BY `Local Purchasing Power Index` DESC
LIMIT 10;

-- KPIs Created for dashboard Include--

-- Average Annual Salary (USD)
-- Average Cost of Living Index
-- Average Local Purchasing Power Index
-- Highest Salary Value Score
-- Number of Countries Analysed



SELECT

    ROUND(AVG(Average_Annual_Salary_USD), 2) AS Average_Annual_Salary_USD,

    ROUND(AVG(`Cost of Living Index`), 2) AS Average_Cost_of_Living_Index,

    ROUND(AVG(`Local Purchasing Power Index`), 2) AS Average_Local_Purchasing_Power,

    ROUND(
        MAX(
            Average_Annual_Salary_USD /
            `Cost of Living Index`
        ),
        2
    ) AS Highest_Salary_Value_Score,

    COUNT(*) AS Countries_Analysed

FROM country_analysis;


/*
=========================================================
Rank Countries by Salary Value Score
=========================================================

Business Question:
Which countries provide the highest salary value relative
to their cost of living?

*/

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
        ) AS Salary_Value_Score

    FROM country_analysis
)

SELECT

    Country,

    Average_Annual_Salary_USD,

    `Cost of Living Index`,

    `Local Purchasing Power Index`,

    Salary_Value_Score,

    RANK() OVER (
        ORDER BY Salary_Value_Score DESC
    ) AS Salary_Value_Rank

FROM country_metrics

ORDER BY Salary_Value_Rank;
