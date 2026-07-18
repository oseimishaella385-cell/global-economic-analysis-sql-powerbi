# Transformation Queries

   Transformations include:
    • Standardising country names 
    • Filtering salary data to 2024
    • Selecting salary values reported in USD (PPP)
    Found in Exploratory script.sql
    
    • Joining the 'cost of living' dataset with the "Global Annual Average salary" dataset to create the view salaries_2024, which was later used to create the second view ' Country analysis'.
    
    • Custom metric created for
    salary index ratio,
    Salary Value category,
    salary value score
    can be found in Country metrics.sql


    These SQL scripts were used to clean, standardise, transform, and prepare the datasets for analysis and visualisation in Power BI.

The transformation process included:

Standardising country names across both datasets to ensure successful joins
Filtering the Global Average Annual Salary dataset to include 2024 observations only.
Selecting salary values reported in USD (PPP adjusted) to enable consistent cross-country comparisons.
These transformation steps are documented in the Exploratory script.sql

Creating the salaries_2024 view by filtering and preparing the salary dataset for analysis.
Joining the salaries_2024 view with the Cost of Living dataset using an INNER JOIN to create the final country_analysis view, which served as the analytical dataset for the project.
Creating custom analytical fields to support affordability analysis, including:
Salary Value Score (Average Annual Salary ÷ Cost of Living Index)
Salary Value Category
Salary Value Rank
These transformations are documented in Country metrics.sql,
