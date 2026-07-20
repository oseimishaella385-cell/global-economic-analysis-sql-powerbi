# Data Preparation and Transformation Queries

 The SQL scripts in this project were used to clean, standardise, and transform the datasets before analysis and visualisation in Power BI.

The transformation process included:

Standardising country names across both datasets to ensure successful joins.

Filtering the Global Average Annual Salary dataset to include 2024 observations only.

Selecting salary values reported in USD (PPP adjusted) to enable consistent cross-country comparisons.

Creating the salaries_2024 view by preparing the salary dataset for analysis.

Join the salaries_2024 view with the Cost of Living dataset using an INNER JOIN to create the final country_analysis analytical view.

Creating custom analytical metrics to support affordability analysis, including:
- Salary Value Score
  
- Salary Value Category

- Salary Value Rank


Transformations documented in _Data cleaning_transform.sql


