CREATE VIEW salaries_2024 AS
SELECT
    ReferenceArea,
    TIME_PERIOD,
    OBS_VALUE,
    UnitMeasure
FROM salaries
WHERE TIME_PERIOD = 2024;

SELECT
    s.ReferenceArea
FROM salaries_2024 s
LEFT JOIN cost_of_living c
ON s.ReferenceArea = c.Country
WHERE c.Country IS NULL;