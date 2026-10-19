# **Warehouse Stock Analytics**

## **Inventory Loss Investigation**

_Excel → PostgreSQL → SQL → Power BI → Business Insights_

An independent portfolio project analysing warehouse inventory, issue activity, recorded loss measures, and reconciliation differences.

## **1. Project Overview**

This project covers data preparation in Excel, PostgreSQL ETL, SQL analysis, Power BI reporting, and recommendations for further investigation.
1. Understand and clean the data in Excel.
2. Explore patterns and define business questions.
3. Load and transform data in PostgreSQL.
4. Analyse inventory, issue activity, trends, loss measures, and reconciliation differences using SQL.
5. Build Power BI models, DAX measures, and interactive reports.
6. Interpret findings and recommend follow-up actions.

## **2. Business Questions**

- How much inventory is recorded as FRN quantity, actual issue quantity, and balance quantity?
- How is inventory balance distributed across locations and products?
- Which products have the largest recorded balances?
- Where is actual issue activity concentrated?
- How do FRN and actual issue quantities change over time?
- Where are Weight Loss, MC Loss, and Unexplained Loss concentrated?
- Where do calculated and recorded reconciliation differences occur?
- How should loss magnitude and loss rate be considered separately when prioritising further investigation?

The analysis is descriptive: it identifies patterns for review, not proven causes.

## **3. Tools & Technologies**

|**Tool**|**Purpose**|
|---|---|
|Microsoft Excel|Data understanding, cleaning documentation, validation, and exploratory analysis|
|PostgreSQL|Analytical database, staging, ETL, and validation|
|SQL|KPI baselines, inventory analysis, monthly trends, loss analysis, and reconciliation|
|Power BI|Data modelling, interactive dashboards, and reporting|
|DAX|Reusable KPI and analytical measures|
|Git / GitHub|Version control and portfolio presentation|

## **4. Dataset**

The prepared warehouse-stock dataset contains 2,129 records and 39 columns.

- Records: 2,129; columns: 39
- PostgreSQL table: public.warehouse_stock
- Clean analytical view: v_warehouse_stock_clean
- Key fields include receipt date, product, grade, location, FRN quantity, actual issue quantity, balance quantity, and recorded loss measures.

The confidential source file is excluded from the public repository. Public assets should not expose company data or identifiers.

## **5. Data Preparation**

Excel cleaning and exploration

The workbook documents checks for missing values, duplicate-looking records, data types, dates, text consistency, identifiers, unusual quantities, and potential anomalies.

Key treatment decisions

- Non-detail rows were excluded from the analytical dataset.
- Four records without FRN No were retained because the available evidence was insufficient to classify them as invalid.
- Missing values remain NULL rather than being automatically converted to zero.
- Text inconsistencies were standardised where appropriate.
- Exploration covered inventory by location/product, issue activity, and monthly FRN/issue patterns.

## **6. Analytical Methodology**

1. Understand: review fields, record types, missing values, and data meaning.
2. Prepare: clean and standardise fields, document decisions, and preserve meaningful NULL values.
3. Transform: load the prepared data into PostgreSQL and create a clean analytical view.
4. Establish baselines: calculate record counts, distinct entities, and core quantity measures.
5. Analyse: compare inventory by location/product, monthly activity, and loss measures.
6. Reconcile: compare FRN, actual issue, and balance quantities using a diagnostic difference.
7. Visualise and validate: build Power BI reports and compare KPI results with SQL baselines.
8. Interpret: distinguish observed patterns from hypotheses and propose follow-up checks.

## **7. SQL Analytics**

The PostgreSQL pipeline:

warehouse_stock_staging → warehouse_stock → v_warehouse_stock_clean → SQL analysis → Power BI

ETL scripts standardise text, parse dates, convert numeric fields, handle invalid values, map months, and prepare analytical fields.

SQL analyses cover KPI baselines, inventory by location/product, monthly receipt and issue trends, reconciliation, loss analysis, and data quality.

### Reconciliation measures

- Calculated Difference = Total FRN Qty − Total Actual Issue Qty − Total Balance Qty
- Recorded Difference = SUM(frn_balance_difference)

The measures are reported separately. Calculated Difference is diagnostic and is not automatically treated as physical inventory loss.

### Loss measures

Weight Loss, MC Loss, and Unexplained Loss are analysed separately because the available definitions do not establish that adding them would avoid double counting. Loss rates require a consistent, clearly defined denominator.

## **8. Power BI Dashboard**

Power BI uses v_warehouse_stock_clean as its main source. DAX measures support interactive KPIs. Dashboard narrative figures should be reconciled against the validated SQL baselines before publication; the L01 issue-volume note is rounded to approximately 6.39M kg in this revision because the source documents contain a 900 kg discrepancy.

### Dashboard 01 — Inventory Overview

<img width="1654" height="974" alt="01_Inventory-Overview" src="https://github.com/user-attachments/assets/3ce57ada-4408-4607-acfd-b464b6c689e6" />

● Tracks FRN quantity, balance quantity, and actual issue quantity, with balance distribution by location/product and monthly FRN versus issue activity.

### Dashboard 02 — Loss & Reconciliation Analysis

<img width="1654" height="977" alt="02_Loss- -Reconciliation-Analysis" src="https://github.com/user-attachments/assets/ba6eb2d7-6899-4f0f-a1cc-81ff7fde5edc" />

● Reviews Weight Loss, MC Loss, and Unexplained Loss separately, compares locationlevel loss measures and rates, and presents reconciliation differences as diagnostic indicators.

### Dashboard 03 — Warehouse Operations

<img width="1658" height="980" alt="03_Warehouse-Operations" src="https://github.com/user-attachments/assets/1fd8fe44-8249-4bba-a4ea-1d51b431d151" />

● Reviews actual issue and balance quantities across locations and products to show where recorded issue activity is concentrated.

The report also includes Business Insights and Root-Cause / Action Plan pages. These interpret patterns and propose follow-up actions; they do not prove operational causes.

### Dashboard 04 — Business Insights

<img width="1657" height="978" alt="04_Business-Insights" src="https://github.com/user-attachments/assets/d33fe5ae-10ed-4477-acf9-df926f042080" />

● Structured tabular presentation mapping Inventory, Product, Loss, and Reconciliation findings to evidence and business implications.

### Dashboard 05 — Weight Loss Root Cause Analysis & Action Plan

<img width="1653" height="976" alt="05_Weight-Loss-Root-Cause-Analysis- -Action-Plan" src="https://github.com/user-attachments/assets/5d66e299-e874-428d-ad4a-617d8b59856f" />

● Investigates inventory weight loss, validates potential root causes, and recommends evidence-based corrective actions.

### Dashboard 06 — Inventory Aging Investigation & Action Plan

<img width="1655" height="980" alt="06_Inventory-Aging-Investigation- -Action-Plan" src="https://github.com/user-attachments/assets/4b189279-5c30-4074-bf70-5ac2c5f60164" />

● Analyzes long-held inventory using average and weighted average ages alongside remaining balances to prioritize stock rotation reviews.

## **9. Key Findings** 

### 1. Inventory Concentration 

Recorded balances are concentrated in particular locations and products: 

- Location L01: highest recorded balance — 999,748 kg. 
- Product CV30: highest recorded balance — 338,529 kg. 

High balances warrant monitoring but do not, by themselves, establish overstocking. 

### 2. Issue Concentration 

Recorded issue activity is concentrated in particular locations: 

- Location L01: highest actual issue quantity — approximately 6.39M kg (rounded; confirm the exact KPI against the validated SQL baseline).

High issue volume indicates activity, not necessarily poor performance. 

### 3. Loss Concentration 

Recorded loss measures vary by location and product and should be assessed separately: 

- Location L10: largest recorded Weight Loss magnitude — 1,908,293 kg. 

- Location L10: largest recorded MC Loss magnitude — 231,639.70 kg. 

- Location L10: largest recorded Unexplained Loss magnitude — 1,676,640.20 kg. 

- Product PV159: largest recorded Weight Loss magnitude — 717,897 kg. 

These findings identify priorities for review but do not establish the causes of loss. 

### 4. Reconciliation Differences 

Two separate reconciliation measures are reported: 

- Recorded FRN Balance Difference (FRN Qty − Balance Qty): 15,484,379.90 kg. 

- Calculated Difference (FRN Qty − Actual Issue Qty − Balance Qty): 5,192,723.60 kg. 

- Location L10: highest location-level Calculated Difference — 1,908,280 kg. 

Calculated differences are diagnostic indicators, not automatic evidence of physical inventory loss. 

### 5. Unexplained Loss: Magnitude versus Rate 

Absolute unexplained-loss magnitude and loss rate highlight different investigation priorities: 

- Location L10: largest absolute Unexplained Loss — 1,676,640.20 kg; reported rate — −80.02%. 

- Location L08: second-largest absolute Unexplained Loss — 1,333,888 kg; reported rate — −94.96%, the largest absolute rate. 

## **10. Root Cause Investigation** 

The analysis flags locations/products with significant loss measures, reconciliation differences, or long-held inventory. These patterns do not independently establish operational causes. 

Further investigation could review: 

- Storage conditions 

- Operator or responsible process 

- Transaction type 

- Adjustment reason 

- Batch 

- Relevant transaction date and time 

- Inventory receipt and issue history 

Use average and weighted average age alongside remaining balances and loss measures. Age should not be treated as a confirmed cause of loss. 

Supporting transaction records are needed to test explanations. Until verified, potential causes remain hypotheses. 

## **11. Corrective Action Plan** 

|**Investigation Area**|**Recommended Action**|**Purpose**|
|---|---|---|
|Recorded Inventory Losses|Review supporting records for locations with the largest absolute unexplained losses. Validate receipt, issue, adjustment, and balance records.|Identify and explain significant inventory discrepancies.|
|Loss Rate Monitoring|Review locations with high unexplained-loss rates alongside their absolute loss amounts and inventory volumes.|Prioritise investigations using both loss magnitude and relative impact.|
|Inventory Ageing|Review long-held inventory by location and product, considering weighted average age and remaining balance quantity.|Identify aged stock that may require closer monitoring or operational review.|
|Combined Risk Assessment|Prioritise locations and products where significant unexplained losses, high loss rates, and aged inventory occur together.|Focus further investigation on records showing multiple potential risk indicators.|
|Inventory Reconciliation|Compare FRN quantities, actual issue quantities, balance quantities, and recorded differences against supporting transaction records.|Determine the basis of reconciliation discrepancies before classifying them as inventory losses.|
|Data Completeness|Review missing actual issue and balance quantities and improve the completeness of inventory transaction records.| Strengthen the reliability of future inventory and loss analysis.|
|Inventory Rotation|Where appropriate for the product and operational requirements, assess FIFO or FEFO practices and introduce ageing-based review alerts.|Support inventory rotation and reduce the risk of stock remaining unreviewed for extended periods.|



Recommended actions for operational review are summarised below. Their effectiveness and the underlying causes have not been established by this analysis. 

## **12. Data Quality & Validation** 

|**Check**|**Result**|
|---|---|
|Total records|2,129|
|Missing Location|0|
|Missing Product Code|0|
|NULL FRN Qty|0|
|NULL Actual Issue Qty|1,167|
|NULL Balance Qty|1,654|
|Negative FRN Qty|0|
|Negative Actual Issue Qty|0|
|Negative Balance Qty|0|

NULL Actual Issue Qty and NULL Balance Qty remain missing rather than being converted to zero. Four records without FRN No were retained because evidence was insufficient to classify them as invalid. 

The cleaning workbook records dataset-count and quantity checks, Power BI KPI validation, dashboard refresh, and technical QA. Age is calculated from the recorded receipt date using 15 October 2026 as a fixed reference date; weighted average age uses balance quantities. 

These checks document the prepared dataset and analytical assumptions; they do not confirm that every source-data issue or operational cause has been resolved. 

## **13. Limitations** 

Key limitations: 

- Source data: the company-origin raw file is excluded from the public repository for confidentiality and data security. 

- Completeness: missing actual issue and balance quantities limit interpretation of some records; missing values are not treated as zero. 

- Root causes: loss measures and reconciliation differences identify records for review but do not prove operational causes. 

- Ageing: age is measured from the recorded warehouse receipt date to 15 October 2026 and is only a supporting risk indicator. 

- Actions: recommendations are proposed for review; their effectiveness has not been tested. 

- Validation: quality checks and KPI comparisons support the reported analysis but do not guarantee that all source-data issues are resolved. 

Treat the findings as indicators for inventory monitoring and further investigation, not definitive evidence of the causes of inventory loss. 

## **14. Repository Structure** 

```text
warehouse-stock-analysis/
├── README.md
├── LICENSE
├── .gitignore
├── .gitattributes
└── Project Summary/
    │
    ├── README.md
    ├── data/
    │   └── data_dictionary.md
    │
    ├── excel/
    │   └── data_cleaning_documentation.xlsx
    │
    ├── sql/
    │   ├── 01_create_staging.sql
    │   ├── 02_create_warehouse_stock.sql
    │   ├── 03_etl_insert.sql
    │   ├── 04_create_clean_view.sql
    │   ├── 05_inventory_analysis.sql
    │   ├── 06_dataset_kpi_baseline.sql
    │   ├── 07_monthly_inventory_&_issue_trend.sql
    │   ├── 08_inventory_reconciliation.sql
    │   ├── 09_loss_analysis_by_location.sql
    │   └── 10_data_quality.sql
    │
    ├── screenshots/
    │   ├── 01_Inventory-Overview.png
    │   ├── 02_Loss-&-Reconciliation-Analysis.png
    │   ├── 03_Warehouse-Operations.png
    │   ├── 04_Business-Insights.png
    │   └── 05_Weight-Loss-Root-Cause-Analysis-&-Action-Plan.png
    │   └── 06_Inventory-Aging-Investigation-&-Action-Plan.png
    │
    └── docs/
        └── project_notes.md
```

|**Folder / File**|**Description**|
|---|---|
|README.md|Project overview, analytical findings, investigation recommendations, validation results, and limitations.|
|data/|Data dictionary describing the dataset fields and their meanings.|
|excel/|Documentation of data cleaning, validation checks, and Power BI KPI verification.|
|sql/|SQL scripts covering staging-table preparation, data transformation, inventory analysis, KPI calculations, reconciliation, loss analysis, and data quality checks.|
|powerbi/|Power BI dashboard file for exploring inventory balances, recorded losses, reconciliation differences, and inventory ageing.|
|screenshots/|Screenshots illustrating the dashboard and project outputs.|

## **15. Data Confidentiality**
The original company source file is excluded from the public repository to protect confidential data. 

## **16. Project Scope**
This repository documents the analytical workflow, technical methods, and portfolio demonstrations.
