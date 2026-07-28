# Which Countries Offer the Best Value? A Global Salary and Cost of Living Analysis
> *One sentence. What did you analyze, build, or solve - and why does it matter?*

---

## ⚙️ Project Type Flags
> *Check what applies. This helps reviewers and collaborators understand the nature of the work at a glance. Delete this block before publishing.*

- [ ] Exploratory Data Analysis (EDA)
- [ ] SQL Analysis / Querying
- [ ] Dashboard / Data Visualization
- [ ] Data Pipeline / ETL
- [ ] Predictive Modelling / Machine Learning
- [ ] Data Cleaning / Wrangling
- [ ] End-to-End (multiple of the above)


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
10. [Recommendations](#10-recommendations)
11. [Assumptions & Limitations](#11-assumptions--limitations)
12. [Future Enhancements](#12-future-enhancements)
13. [Deliverables](#13-deliverables)
14. [Author](#14-author)

---

## 1. Project Overview
Context:
In recent years, the increased cost of living has become a significant global issue, making it difficult for many people to maintain their standard of living. This project was motivated by the desire to understand how living costs compare with average annual salaries across different countries, and to explore which countries offer the greatest affordability.

Problem statement:
" A high salary does not necessarily mean a better quality of life if the cost of living is also high"

Approach:
Datasets from the OECD and Numbeo were reviewed and consolidated into a single analytical dataset using SQL (MySQL). I then developed an interactive Power BI dashboard to compare countries using salary, cost of living, purchasing power, and a custom Salary Value Score to evaluate overall affordability.

Outcome:
The analysis showed that countries with the highest salaries were not always the most affordable. Using the Salary Value Score, the project identified [Top Country] as offering one of the strongest balances between salary and living costs, demonstrating that affordability depends on both income and the cost of goods and services rather than salary alone.

---

## 2. Objectives
- **Primary Objective:** To assess whether average annual salaries keep pace with the cost of living across countries
- **Secondary Objective 1:** Identify which top 5 countries offer the best balance between average annual salary and cost of living by developing a custom Salary Value Score.
- **Secondary Objective 2:** Do countries with higher average salaries also have higher local purchasing power?

---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | OECD 2024-2026 Average Annual Salary data (USD PPP adjusted) and Numbeo 2024 Cost of Living Index data for countries available in both datasets. |
| **Out of Scope** | City-level comparisons, restaurant index, historical trend analysis, taxation and countries and years not available in both datasets. |
| **Time Period** | 2024 |
| **Granularity** | Country level analysis  |

---

### Tools & Technologies

<!--
  List only what you actually used on this project.
  This is not your skills section - it's the project's technical context.
-->

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage | CSV files |
| Data Processing |  SQL, Excel |
| Analysis |  custom SQL queries |
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
│   └── final/                # Production-ready or presentation queries
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


[Data Source(s)]
      ↓
[Ingestion ]
      ↓
[Cleaning & Transformation]
      ↓
[Analysis]
      ↓
[Output]


```
Source: Two publicly available datasets were used: the OECD Average Annual Wages dataset and the Numbeo Cost of Living Index dataset. Both datasets were downloaded as CSV files and contain country-level data for 2024.

Ingestion: Both CSV files were imported into MYSQL, creating two relational tables (Salaries and cost_of_living) that serve as the project's primary data sources.

Cleaning: Prepared the OECD salary dataset by filtering to 2024 data, retaining only salaries reported in USD (PPP adjusted) with the required price base and removing duplicate country records. Removed aggregate and regional records that did not represent individual countries, as these could not be matched with the country-level Cost of Living dataset.

Transformation: Created views to prepare the data for analysis. Developed a custom Salary Value Score, Salary Value Rank, and Salary Value Category, grouping countries into quartiles based on affordability using SQL window functions.

Analysis: Query-based and descriptive statistical analysis using SQL joins, aggregate functions, CTEs, window functions, and Power BI visualisations to identify affordability trends, rank countries, and compare salary, cost of living, and purchasing power.

Output: Interactive Power BI dashboard, SQL scripts, and project documentation (README).



## 6. Data Model & Schema
### Dataset / Table: `Cost_of_living`

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| Country | VARCHAR| Country name used to join datasets | Australia |
| Cost of living Index | DECIMAL | Relative cost of living index (NYC = 100) | 70.20 |
| Local Purchasing Power Index | DECIMAL | Relative local purchasing power index (NYC = 100) | 127.40 |

> **Row count (approx.):** 122 Rows
> **Date range:** 2024
> **Key join / relationship:** cost_of_living.Country → salaries_2024.ReferenceArea

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
| Cost of living Index | DECIMAL |  cost of living index (NYC = 100) | 70.20 |
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

The initial assumption was that countries with a higher salaries would also achieve higher Salary-to-Cost Rattion, as greated earnings were expected to offset higher living costs. Conversely, ountries with lower salaries and higher living costs were expected to produce lower Salary-to-Cost Ratios. 

The second assumption was that countries with a higher local purchasing Power Index would ge

[Describe how you approached the analysis. Were you exploring patterns? Testing a hypothesis? Building and validating a pipeline? Be honest about your method - exploratory work is valid, just call it that.]

### Key Metrics Defined

| Metric | Plain-Language Definition | Why It Matters |
|--------|--------------------------|----------------|
| '[Average Annual Salary]' | Average yearly wage (USD PPP) reported by the OECD. | Enables salary comparisons across countries |
| `[Cost of living index]` | Relative cost of living compared with New York City (NYC = 100) | Indicates how expensive it is to live in each country |
| `[Local Purchasing Power Index]` | Relative purchasing power compared with New York City (NYC = 100) | Measures how much residents can afford with local incomes |
| '[Salary-to-Cost Ratio]' | Custom metric calculated as Average Annual Salary / Cost of living index | Provides a simple comparison of salaries relative to living costs|
|'[Salary-to-Cost Rank]'| Ranking countries based on Salary-to-Cost Ratio | Identifies countries where salaries appear strongest relative to living costs |

### Methods Used


- [e.g., Descriptive statistics - distribution, central tendency, outlier detection]
- [e.g., Trend analysis across [time period]]
- [e.g., Segmentation / group comparison by [dimension]]
- [e.g., Correlation analysis between [variable A] and [variable B]]
- [e.g., SQL window functions for [specific aggregation]]
- [e.g., Custom aggregation or transformation logic in [tool]]

---

## 9. Key Insights

<!--
 
-->Insight 1 — Higher salaries often coincide with higher living costs

Six of the ten countries with the highest average annual salaries also appeared among the ten countries with the highest Cost of Living Indexes, including Iceland, the United States, Switzerland, Denmark, Austria and Norway. This suggests that higher salaries are often accompanied by higher living expenses, meaning higher income alone does not necessarily improve affordability.

Among the ten most expensive countries, nine had a Cost of Living Index at least 17% lower than New York City (NYC = 100). Switzerland was the only exception, recording a Cost of Living Index of 101.1, making it approximately 1% more expensive than New York City.

This indicates that comparing salaries in isolation can give a misleading picture of affordability. Cost of living should be considered alongside income when comparing countries, as higher wages are often offset by higher everyday expenses.

Insight 2 — The custom Salary-to-Cost Ratio identified countries offering the strongest salary relative to living costs

The custom Salary-to-Cost Ratio identified Luxembourg as the highest-ranking country, with a ratio of 1,561.89, followed by Turkey. Although Luxembourg did not have the highest average annual salary, its combination of a high salary ($97,462.05 USD PPP) and a comparatively lower Cost of Living Index (62.4) resulted in the strongest Salary-to-Cost Ratio. This demonstrates that countries with lower living costs can outperform countries with higher salaries when salaries are evaluated relative to living costs rather than income alone.

This highlights the value of using comparative metrics rather than salary alone when assessing affordability, as countries with slightly lower salaries may provide residents with better overall value for money.

Insight 3 — Higher salaries do not always correspond to higher purchasing power

Switzerland recorded the third-highest average annual salary ($92,160.55 USD PPP) and the second-highest Local Purchasing Power Index (158.7), despite having the highest Cost of Living Index (101.1) in the dataset. This indicates that residents have strong purchasing power even though Switzerland is one of the world's most expensive countries to live in.

Conversely, Turkey ranked second using the custom Salary-to-Cost Ratio but recorded one of the lowest Local Purchasing Power Index values (49.0). This suggests that purchasing power is influenced by factors beyond average salary and cost of living alone. While the custom Salary-to-Cost Ratio provides a useful comparison between salaries and living costs, it does not fully capture the broader economic factors that influence real affordability.

This demonstrates that affordability should be assessed using multiple economic indicators rather than a single metric. Combining salary, cost of living and purchasing power provides a more balanced and realistic assessment of how far income is likely to stretch in different countries

---


## 10. Recommendations

| Priority | Recommendation | Based On | Suggested Owner |
|----------|---------------|----------|-----------------|
| High | Evaluate affordabilty using multiple indicators (salary, cost of living and purchasing power) rather than salary alone when comparing countries | Insight 3 - Higher Salaries do not always correspond to higher purchasing power |Analysts|
| Medium | Use the custom Salary-to-Cost Ratio as an initial screening too to identify countries where salaries appear to offer strong value, then validate findings using Purchasing Power Index data | Insight 2 - The custom Salary-to ratio identified different "best value" countries| Data Analysts |
| Low | Expand the analysis by incorporating additional variables such as housing costs, taxation, disposable income and inflation to produce a more comprehensive affordability measure.| Insights 1-3 |Future Project/Researchers|

---

## 11. Assumptions & Limitations

### Assumptions
- The OECD and Numbeo datasets accurately represent 2024 conditions. The analysis assumes both data sources provide reliable and comparable measures of average annual salaries, cost of living, and purchasing power for each country.

- Average annual salary is representative of a country's workforce. The analysis assumes that the reported average salary is an appropriate measure for comparing countries, despite differences in income distribution, occupations, and regional wage variation.

- Salary values reported in USD (PPP adjusted) provide a fair basis for comparison. Using Purchasing Power Parity (PPP) assumes that differences in exchange rates and price levels have already been accounted for, making salaries comparable across countries.

- The Cost of Living Index and Local Purchasing Power Index are comparable across countries. The analysis accepts Numbeo's methodology, where New York City = 100, as a consistent benchmark for international comparisons.

- The custom Salary-to-Cost Ratio is treated as a comparative indicator rather than a measure of actual disposable income. It assumes that dividing average salary by the Cost of Living Index provides a useful way to compare countries, while recognising that it does not capture every aspect of affordability.

---

### Limitations

- The analysis was limited to countries available in both the OECD salary dataset and the Numbeo Cost of Living dataset. Countries that could not be matched between the two sources were excluded from the analysis, reducing the overall sample size. In addition, the use of 2024 data only means changes in salaries over time were not captured; therefore, there was not a chance to identify long-term trends. 
- The analysis used national average salaries, which can be limiting as average salaries do not reflect differences in income distribution, occupations or regions within each country.

- The custom Salary-to-Cost Ratio is a simplified affordability measure. Although it provides useful comparisons between salaries and  cost for all countries, it does not account for additional factors, e.g. taxation, housing affordability, healthcare costs or even social benefits. This was observed with Switzerland, which ranked  relatively low using the custom ratio despite have on of the highest Local Purchasing Power Index values.

- The cost of living index is a relative index rather than a direct measure of expenditure. Dividing salary by the Cost of Living Index creates a comparative indicator rather than a true measure of how much disposable income residents have after essential living expenses.

---

## 12. Future Enhancements
- [ ] [Enhancement 1 - Expand the analysis to multiple years, preferably (2021-2025), to examine how salaries, cost of living and purchasing power have changed over time and identify long-term affordability trends. ]
- [ ] [Enhancement 2 - Preferably replace average annual salary with median annual salary as a median income is less affected by extremely high earners and provides a representative measure of typical workers' earnings]
- [ ] [Enhancement 3 - Incorporate an additional affordability measure such as income tax or housing]
- [ ] [Enhancement 4- Extend the analysis to city- level data, which would allow for affordability comparisons within countries rather than relying solely on national averages]

---

## 13. Deliverables


| Deliverable               | Description                                                                                | Location                               |
| ------------------------- | ------------------------------------------------------------------------------------------ | -------------------------------------- |
| **README.md**             | Project overview, methodology, analysis, findings, recommendations and documentation.      | `/README.md`                           |

| **SQL Scripts**           | SQL scripts used for data cleaning, transformation, view creation and analytical queries.  | `/sql/`                                |
| **Raw Datasets**          | Original OECD salary data and Numbeo Cost of Living dataset used for the analysis.         | `/data/raw/`                           |
| **Processed Dataset**     | Final `country_analysis` dataset used for Power BI visualisations.                         | `/data/processed/`                     |
| **ERD Diagram**           | Entity Relationship Diagram illustrating the database structure and table relationships.   | `/visuals/erd.png`                     |
| **Dashboard Screenshots** | Images of the final Power BI dashboard used in the README.                                 | `/visuals/`                            |

---

## 14. Author

**[Mishaella Osei]**
[Your role or title - current or target]

- 🔗 [www.linkedin.com/in/mishaella-osei-1510mo]
- 💼 []
- 📧 [Email - Oseimishaella385@gmail.com]

---

*Last updated: June 2026

