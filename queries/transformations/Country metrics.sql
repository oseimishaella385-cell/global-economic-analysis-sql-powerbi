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

