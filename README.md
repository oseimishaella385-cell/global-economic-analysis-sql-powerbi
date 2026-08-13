# Which Countries Offer the Best Value? A Global Salary and Cost of Living Analysis
Which countries offer the strongest balance between average salary, cost of living and local purchasing power?

>This project combines OECD salary data with Numbeo cost of living data to evaluate global affordability by comparing average annual salaries, living costs and purchasing power, using SQL and Power BI to identify which countries offer the greatest value.

---




---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Objectives](#2-objectives)
3. [Project Scope & Tools](#3-project-scope--tools)
4. [Repository Structure](#4-repository-structure)
5. [Data Workflow](#5-data-workflow)
6. [Data Model & Schema](#6-data-model--schema)
7. [ERD - Entity Relationship Diagram](#7-erd--entity-relationship-diagram) 
8. [Analysis & Metrics](#8-analysis--metrics)
9. [Key Insights](#9-key-insights)
10. [Practical Implications](#10-practical-implications)
11. [Assumptions & Limitations](#11-assumptions--limitations)
12. [Future Enhancements](#12-future-enhancements)
13. [Deliverables](#13-deliverables)
14. [Author](#14-author)

---

## 1. Project Overview
**Context:**
In recent years, the increased cost of living has become a significant global issue, making it difficult for many people to maintain their standard of living. This project was motivated by the desire to understand how living costs compare with average annual salaries across different countries, and to explore which countries offer stronger salary value relative to living costs.

**Problem statement:**
A high salary does not necessarily translate into greater affordability when the cost of living is also high.

**Approach:**
Datasets from the OECD and Numbeo were reviewed and consolidated into a single analytical dataset using SQL (MySQL). I then developed an interactive Power BI dashboard to compare countries using Average Annual Salary, Cost of Living Index, Local Purchasing Power Index (PPI), and a custom Salary Value Score (SVS) to evaluate relative affordability.

**Outcome:**
The analysis showed that countries with the highest salaries were not always the most affordable. Based on the Salary Value Score (SVS), Luxembourg achieved the highest score, indicating a strong relationship between average salary and its Cost of Living Index. Overall, the findings demonstrate why salary should be considered alongside living costs and purchasing power when comparing relative affordability across countries.

---

## 2. Objectives
- **Primary Objective:** To assess how average annual salaries compare with the cost of living across countries.
- **Secondary Objective 1:** To identify the five countries with the strongest salary value relative to living costs using a custom Salary Value Score (SVS).
- **Secondary Objective 2:**  To examine whether countries with higher average salaries also demonstrate higher local purchasing power.
  
**Analytical Questions**
The analysis was structured around four questions:

- Which countries report the highest average annual salaries?
  
- Are countries with higher salaries also more expensive to live in?
  
- Which countries offer the strongest salary relative to their Cost of Living Index?
  
- Do countries ranked highly by the custom Salary Value Score (SVS) also demonstrate strong local purchasing power?
---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | OECD 2024 Average Annual Salary data (USD PPP-adjusted) and Numbeo 2024 Cost of Living Index data for countries available in both datasets. |
| **Out of Scope** | City-level comparisons, Restaurant Index, historical trend analysis, taxation, household-level affordability factors and countries not available in both datasets. |
| **Time Period** | 2024 |
| **Granularity** | Country-level analysis  |

---

### Tools & Technologies

  

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage | CSV files |
| Data Processing |  SQL, Excel |
| Analysis |  Custom SQL queries |
| Visualization | Power BI |
| Version Control |  GitHub |
| Documentation | Markdown |


---

## 4. Repository Structure

```
[project-root]/
│
├── data/
│   ├── raw/                  # Original, unmodified source data - never edited
│   ├── processed/            # Cleaned and transformed data
│
│
├── queries/                  # SQL files 
│   ├── transformations/      # Cleaning and reshaping logic
│   └── final/                # Final analysis and presentation queries
│
│
├── visuals/                  # Exported charts, dashboard screenshots, ERD diagrams
│
├── docs/                     # Data dictionaries, schema notes, reference material
│
└── README.md                 # You are here
```

---

## 5. Data Workflow
```
Data Sources
      ↓
Ingestion (MySQL)
      ↓
Cleaning & Transformation (SQL)
      ↓
Analysis (SQL + Power BI)
      ↓
Dashboard & Documentation
```
1. **Source:** Two publicly available datasets were used: the OECD Average Annual Wages dataset and the Numbeo Cost of Living Index dataset. Both datasets were downloaded as CSV files and contain country-level data for 2024.
   
2. **Ingestion:** Both CSV files were imported into MYSQL, creating two relational tables (`Salaries` and `cost_of_living`) that served as the project's primary data sources.

3. **Cleaning:** The OECD salary dataset was prepared by filtering to 2024 observations, retaining salaries reported in USD (PPP-adjusted) with the required price base and removing duplicate country records. Aggregate and regional records that did not represent individual countries were also removed because they could not be matched appropriately with the country-level Cost of Living dataset.

4.  **Transformation:** SQL views were created to prepare the data for analysis. A custom Salary Value Score (SVS), Salary Value Rank, and Salary Value Category were developed, with countries grouped into quartiles based on SVS using SQL window functions.

5.  **Analysis:** Query-based and descriptive statistical analysis was conducted using SQL joins, aggregate functions, CTEs and window functions alongside Power BI visualisations to identify country-level patterns, rank countries by SVS, and compare Average Annual Salary, Cost of Living, and Local Purchasing Power Index (PPI).

6.  **Output:** Interactive Power BI dashboard, SQL scripts, processed datasets and project documentation (README).
   

---

## 6. Data Model & Schema

### Dataset / Table: `Cost_of_living`
---
| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| Country | VARCHAR| Country name used to join datasets | Australia |
| Cost of living Index | DECIMAL | Relative cost of living index (NYC = 100) | 70.20 |
| Local Purchasing Power Index | DECIMAL | Relative local purchasing power index (NYC = 100) | 127.40 |

> **Row count (approx.):** 122 Rows
> **Date range:** 2024
> **Key join / relationship:** cost_of_living.Country → salaries_2024.ReferenceArea
---
### Dataset / Table: Salaries_2024

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| ReferenceArea| VARCHAR | Country name | Australia |
| Average_Annual_Salary_USD | DECIMAL | Average annual salary (USD PPP adjusted)| 71,238.24 |
| TIME_PERIOD | INT | Reporting year | 2024 |                                    
| UNIT_MEASURE | VARCHAR | Salary reporting unit | USD_PPP| 

> **Row count (approx.):** 34 Rows
> **Date range:** 2024
> **Key join / relationship:**  ReferenceArea →  cost_of_living.Country


### Dataset / Table: `Country_analysis`

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| Country | VARCHAR| Country name | Australia |
| Average_Annual_Salary_USD | DECIMAL | Average annual salary (USD PPP adjusted) | 71238.24 |
| Cost of living Index | DECIMAL | cost of living index (NYC = 100) | 70.20 |
| Local Purchasing Power Index | DECIMAL | local purchasing power index (NYC = 100) | 127.40 |
| Salary Value Score | Decimal | Salary divided by Cost of Living Index | 1014.79 |
| Salary Value Rank | INT | Ranking based on Salary Value Score | 20 |
| Salary Value Category | VARCHAR | Affordabillty quartile | Top 25% |

> **Row count (approx.):** 34 Rows
> **Date range:** 2024
> **Key join / relationship:**  created by joining salaries_2024.ReferenceArea with cost_of_living.Country  

## 7. ERD - Entity Relationship Diagram

The diagram below illustrates the relationship between the OECD salary dataset, the Numbeo Cost of Living dataset, and the final analytical view (`country_analysis`) used throughout this project.

![Entity Relationship Diagram](/visuals/erd.png)

*Figure 1. Entity Relationship Diagram showing the data transformation from the raw salary dataset to the final `country_analysis` view used for SQL analysis and the Power BI dashboard.*


**Table Relationships Summary:**

| Relationship | Join Key | Type |
|-------------|----------|------|
| `cost_of_living` ↔ `salaries_2024` | `cost_of_living.Country = Salaries_2024.ReferenceArea` | one-to-One |
| Country_analysis| created from an inner join of cost_of_living and salaries_2024 | SQL View |

---


## 8. Analysis & Metrics

### Analytical Approach
This project followed an analytical approach to investigate whether average annual salaries keep pace with the cost of living across countries. Rather than testing a predefined hypothesis, the analysis explored relationships among Salary, living costs, and purchasing power to identify patterns in global affordability.

The initial assumption was that countries with higher salaries would also achieve higher Salary Value Score (SVS), as greater earnings were expected to offset higher living costs. Conversely, countries with lower salaries and higher living costs were expected to produce lower Salary-to-Cost Ratios. 

The second assumption was that countries with a higher local Purchasing Power Index would also achieve a higher Salary Value Score (SVS), as stronger purchasing power was expected to reflect greater affordability.

### Key Metrics Defined

| Metric | Plain-Language Definition | Why It Matters |
|--------|--------------------------|----------------|
| Average Annual Salary | Average yearly wage (USD PPP) reported by the OECD. | Enables salary comparisons across countries |
| Cost of living index | Relative cost of living compared with New York City (NYC = 100) | Indicates how expensive it is to live in each country |
| Local Purchasing Power Index | Relative purchasing power compared with New York City (NYC = 100) | Measures how much residents can afford with local incomes |
| Salary-to-Cost Ratio | Custom metric calculated as Average Annual Salary / Cost of living index | Provides a simple comparison of salaries relative to living costs|
| Salary-to-Cost Rank | Ranking countries based on Salary-to-Cost Ratio | Identifies countries where salaries appear strongest relative to living costs |


**Salary Value Score (SVS)**
The Salary Value Score is a custom comparative metric developed for this project to evaluate average annual salary relative to a country's cost of living.

Formula:
Salary Value Score = Average Annual Salary (USD PPP) / Cost of Living Index

A higher SVS indicates that average salary is larger relative to the country's Cost of Living Index, while a lower score indicates that salary is smaller relative to living costs.

For example, Luxembourg's average annual salary of approximately $97,462 USD PPP divided by its Cost of Living Index of 62.4 produces an SVS of approximately 1,561.9.

The score should not be interpreted as disposable income, household purchasing power, or the number of dollars remaining after living expenses. The Cost of Living Index is a relative index rather than a monetary expenditure value. SVS is therefore intended primarily as a ranking and screening measure for comparing countries within this dataset.


### Methods Used
**SQL INNER JOIN** – Combined the salary and cost of living datasets.
**Data filtering** – Selected 2024 observations and USD (PPP) salary values.
**Data cleaning** – Standardised country names and removed unmatched records.
**Calculated metric** – Created a custom Salary-to-Cost Ratio (salary/cost of living index) to compare salary against living costs.
**SQL Window Functions** – Used RANK() to rank countries and NTILE() to group countries into affordability quartiles.
**Comparative analysis**– Compared salary, cost of living and purchasing power across countries.
**Power BI visualisation** – Presented findings using interactive charts and maps

---

## 9. Key Insights
 
**Insight 1 — Higher salaries often coincide with higher living costs**

Six of the ten countries with the highest average annual salaries also appeared among the ten countries with the highest Cost of Living Indexes, including Iceland, the United States, Switzerland, Denmark, Austria and Norway. This suggests that higher salaries are often accompanied by higher living expenses, meaning higher income alone does not necessarily improve affordability.

Among the ten most expensive countries, nine had a Cost of Living Index at least 17% lower than New York City (NYC = 100). Switzerland was the only exception, recording a Cost of Living Index of 101.1, making it approximately 1% more expensive than New York City.

This indicates that comparing salaries in isolation can give a misleading picture of affordability. Cost of living should be considered alongside income when comparing countries, as higher wages are often offset by higher everyday expenses.

**Insight 2 — The custom Salary Value Score (SVS) identified countries offering the strongest salary relative to living costs**

The Salary Value Score (SVS) identified Luxembourg as the highest-ranking country, with a score of 1,561.89, followed by Turkey. Although Luxembourg did not have the highest average annual salary, its combination of a high salary ($97,462.05 USD PPP) and a comparatively lower Cost of Living Index (62.4) resulted in the strongest Score. This demonstrates that countries with lower living costs can outperform countries with higher salaries when salaries are evaluated relative to living costs rather than income alone.

This highlights the value of using comparative metrics rather than salary alone when assessing affordability, as countries with slightly lower salaries may provide residents with better overall value for money.

**Insight 3 — Higher salaries do not always correspond to higher purchasing power**
Switzerland recorded the third-highest average annual salary ($92,160.55 USD PPP) and the second-highest Local Purchasing Power Index (158.7), despite having the highest Cost of Living Index (101.1) in the dataset. This suggests that high living costs do not necessarily translate into weak purchasing power when income levels are also sufficiently high.

Turkey presents a contrasting result. Although it ranked second using the custom Salary Value Score (SVS), it recorded one of the lowest Local Purchasing Power Index values (49.0). This divergence is analytically important because it shows that the SVS captures a narrower relationship, average salary relative to the Cost of Living Index, rather than overall household affordability or real purchasing power.

Comparing SVS with the Local Purchasing Power Index therefore provides a useful sense-check on the custom metric. Where the two measures produce different rankings, this indicates that other economic factors may be influencing affordability, such as taxation, housing costs, household spending patterns, wage distribution and differences in how local prices affect residents.

For this reason, the Salary Value Score (SVS) should be interpreted as a comparative screening indicator rather than a standalone measure of affordability. It is useful for identifying countries where average salary appears relatively strong compared with the Cost of Living Index, but it should be considered alongside Local Purchasing Power and other economic indicators.

---


## 10. Practical Implications
The findings demonstrate why salary figures should not be used in isolation when comparing  affordability across countries. The SVS can be used as an initial comparative indicator, but it should be interpreted alongside Local Purchasing Power and other relevant economic measures when evaluating how far income may stretch across countries.


---

## 11. Assumptions & Limitations

### Assumptions
- The OECD and Numbeo datasets accurately represent 2024 conditions. The analysis assumes both data sources provide reliable and comparable measures of average annual salaries, cost of living, and purchasing power for each country.

- Average annual salary is representative of a country's workforce. The analysis assumes that the reported average salary is an appropriate measure for comparing countries, despite differences in income distribution, occupations, and regional wage variation.

-  PPP-adjusted salary: OECD average annual wages are expressed in USD using Purchasing Power Parity (PPP), improving comparability between countries by accounting for differences in price levels.

- Purchasing Power Index (PPI): The Purchasing Power Index is taken from the Cost of Living dataset and is used as a separate indicator of the relative purchasing power available to residents within each country. In this project, PPI is used alongside the Salary Value Score rather than as part of the SVS calculation.

- The Cost of Living Index and Local Purchasing Power Index are comparable across countries. The analysis accepts Numbeo's methodology, where New York City = 100, as a consistent benchmark for international comparisons.

- The custom Salary Value Score is treated as a comparative indicator rather than a measure of actual disposable income. It assumes that dividing average salary by the Cost of Living Index provides a useful way to compare countries, while recognising that it does not capture every aspect of affordability.

---

### Limitations

 **1) Different source methodologies**
Salary and cost-of-living measures originate from different organisations and are produced using different methodologies. OECD wage estimates are based on official economic and labour statistics, whereas Numbeo's cost-of-living measures are compiled using its own price-data methodology. Joining these datasets enables useful exploratory comparisons, but the resulting metrics should not be interpreted as official OECD affordability measures.

**2) PPP adjustment and cost-of-living measurement**
OECD salaries used in this analysis are already expressed in PPP-adjusted USD, meaning differences in national price levels are partially incorporated into the salary measure. Dividing a PPP-adjusted salary by a separate Cost of Living Index therefore creates an exploratory comparative score rather than a pure economic measure of affordability.

**3) Dataset coverage and time period**
 The analysis was limited to countries available in both the OECD salary dataset and the Numbeo Cost of Living dataset. Countries that could not be matched between the two sources were excluded, reducing the overall sample size. In addition, the analysis uses 2024 data only and therefore does not capture changes in salaries, living costs or purchasing power over time. 

**4) Use of national average salaries**
National averages can mask substantial differences in income distribution, occupations and regions within each country. As a result, the reported average salary may not represent the earnings experienced by a typical individual.

**5) Scope of the Salary Value Score (SVS)**
SVS is a simplified comparative indicator based only on annual salary and the Cost of Living Index measure. It does not account for additional factors such as  taxation, housing costs, healthcare costs, social benefits or household composition. Therefore, it should not be interpreted as a complete measure of individual or household affordability.

**6) Cost of Living Index measurement**
The cost of living index is a relative index rather than a direct measure of expenditure. Dividing salary by the Index therefore produces a comparative indicator rather than an estimate of disposable income remaining after essential living expenses.

---

## 12. Future Enhancements
**Enhancement 1** - Expand the analysis to multiple years, preferably (2021-2025), to examine how salaries, cost of living and purchasing power have changed over time and identify long-term affordability trends.

**Enhancement 2** - Preferably replace average annual salary with median annual salary, as a median income is less affected by extremely high earners and provides a representative measure of typical workers' earnings

**Enhancement 3** - Incorporate an additional affordability measure such as income tax or housing

**Enhancement 4** - Extend the analysis to city- level data, which would allow for affordability comparisons within countries rather than relying solely on national averages

**Key takeaway:** The country with the highest salary is not necessarily the country where income provides the strongest relative value. This project demonstrates both the usefulness—and the limitations—of combining salary and cost-of-living data when evaluating international affordability.

---

## 13. Deliverables


| Deliverable               | Description                                                                                | Location  |

| **README.md**             | Project overview, methodology, analysis, findings, recommendations and documentation.      | `/README.md`                           |

| **SQL Scripts**           | SQL scripts used for data cleaning, transformation, view creation and analytical queries.  | `/sql/`                                |
| **Raw Datasets**          | Original OECD salary data and Numbeo Cost of Living dataset used for the analysis.         | `/data/raw/`                           |
| **Processed Dataset**     | Final `country_analysis` dataset used for Power BI visualisations.                         | `/data/processed/`                     |
| **ERD Diagram**           | Entity Relationship Diagram illustrating the database structure and table relationships.   | `/visuals/erd.png`                     |
| **Dashboard Screenshots** | Images of the final Power BI dashboard used in the README.                                 | `/visuals/`                            |

---

## 14. Author

**Mishaella Osei**
Aspiring Data Analyst

- 🔗 www.linkedin.com/in/mishaella-osei-1510mo
- 💼 []
- 📧 Email - Oseimishaella385@gmail.com

---

*Last updated: June 2026

