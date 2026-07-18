SELECT * FROM countries.salaries_2024;
CREATE VIEW country_analysis AS
SELECT
    c.Country,
    s.OBS_VALUE AS Average_Annual_Salary_USD,
    c.`Cost of Living Index`,
    c.`Rent Index`,
    c.`Cost of Living Plus Rent Index`,
    c.`Groceries Index`,
    c.`Restaurant Price Index`,
    c.`Local Purchasing Power Index`
FROM cost_of_living c
INNER JOIN salaries_2024 s
    ON c.Country = s.ReferenceArea;