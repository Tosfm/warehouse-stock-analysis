# Project Notes

## 1. Project Overview

**Project:** Warehouse Stock Analytics

This project analyses warehouse stock and inventory movement data using Excel, PostgreSQL and Power BI.

The project focuses on understanding inventory balances, stock movements, warehouse operations, loss-related measures and reconciliation patterns.

The analytical workflow follows:

```text
Excel
  ↓
Data Understanding
  ↓
Data Cleaning & Data Quality
  ↓
PostgreSQL
  ↓
SQL Analytics
  ↓
Power BI Data Model & DAX
  ↓
Dashboard & Business Insights
```

## 2. Project Objectives

The main objectives are to:

* understand the structure and meaning of the warehouse stock dataset;
* clean and standardise data before analysis;
* identify data quality issues and document their treatment;
* analyse inventory quantities by location, product and warehouse;
* analyse stock movement and operational activity;
* analyse weight loss, MC loss and unexplained loss separately;
* perform inventory reconciliation;
* build an interactive Power BI dashboard;
* communicate business findings using data-supported evidence.

## 3. Dataset

The final production dataset contains:

| Attribute | Value |
| --- | --- |
| Records | 2,129 |
| Columns | 39 |
| Primary analytical source | `v_warehouse_stock_clean` |
| Main platform | PostgreSQL |
| Visualisation platform | Power BI |

The production dataset was prepared from the original Excel warehouse stock report.

The analytical dataset contains detail-level records used for SQL analysis and Power BI reporting.

## 4. Data Cleaning Principles

The project follows several data cleaning principles.

### 4.1 Preserve Source Meaning

Data is not modified simply because a value appears unusual.

Cleaning decisions are based on the meaning of the field and the available business context.

### 4.2 NULL Is Not Automatically Zero

NULL values are retained when the source does not provide a value.

In particular:

* NULL `Actual Issue Qty` is not automatically converted to zero.
* NULL `Balance Qty` is not automatically converted to zero.

This prevents missing information from being incorrectly interpreted as a recorded zero quantity.

### 4.3 Negative Quantities

The following quantity fields were checked for negative values:

* FRN Qty
* Actual Issue Qty
* Balance Qty

No negative values were identified in the final production dataset for these checks.

### 4.4 Missing Values

The final data quality checks identified:

* Missing Location: 0
* Missing Product Code: 0
* NULL FRN Qty: 0
* NULL Actual Issue Qty: 1,167
* NULL Balance Qty: 1,654

Missing values were documented rather than automatically replaced without sufficient evidence.

## 5. Record Treatment

The original dataset contained non-detail rows that were not appropriate for the production analytical dataset.

These non-detail rows were excluded from the production dataset.

Four records without FRN No were retained because there was insufficient evidence to classify them as invalid records.

The final production baseline is therefore:

**2,129 records × 39 columns**

## 6. PostgreSQL Architecture

The PostgreSQL workflow separates source ingestion, production data and analytical logic.

The main production table is:

```text
public.warehouse_stock
```

The main analytical cleaning view is:

```text
v_warehouse_stock_clean
```

The general SQL workflow is:

```text
Staging
  ↓
Production Table
  ↓
Clean Analytical View
  ↓
Data Quality Checks
  ↓
Analytical Queries
  ↓
Power BI
```

This separation helps keep data preparation and analytical reporting more structured and reproducible.

## 7. Key Analytical Measures

The project uses several core inventory measures.

### Inventory Measures

* Total FRN Qty
* Total Balance Qty
* Total Actual Issue Qty
* Total FRN Bags
* Total Balance Bags
* Total Actual Issue Bags

### Loss Measures

* Total Weight Loss
* Total MC Loss
* Total Unexplained Loss

### Operational Measures

* Actual Issue Qty
* Actual Issue Bags
* Balance Qty
* Balance Bags

## 8. Reconciliation Logic

The project uses the following diagnostic reconciliation calculation:

```text
Calculated Difference = FRN Qty − Actual Issue Qty − Balance Qty
```

A separate recorded difference is also analysed:

```text
Recorded Difference = FRN Balance Difference
```

`Calculated Difference` is treated as a **reconciliation diagnostic**.

It is not automatically interpreted as physical loss because differences may require further investigation and business context.

## 9. Loss Analysis

Loss-related measures are kept separate:

* Weight Loss
* MC Loss
* Unexplained Loss

These measures are not automatically combined into a generic `Total Loss`.

The purpose is to preserve the distinction between different types of loss-related measurements and avoid unsupported assumptions about their causes.

## 10. Power BI Structure

The Power BI report contains the following analytical pages:

1. `01_Inventory-Overview`
2. `02_Loss-&-Reconciliation-Analysis`
3. `03_Warehouse-Operations`
4. `04_Business-Insights`
5. `05_Weight-Loss-Root-Cause-Analysis-&-Action-Plan`
6. `06_Inventory-Aging-Investigation-&-Action-Plan`

## 11. Dashboard Scope

### Inventory Overview

Focuses on:

```text
* FRN quantity;
* balance quantity;
* actual issue quantity;
* balance distribution by location/product;
* monthly FRN versus issue activity.
```

### Loss & Reconciliation Analysis

Focuses on:

```text
* Weight Loss;
* MC Loss;
* Unexplained Loss;
* location-level loss measures and rates;
* reconciliation differences.
```

### Warehouse Operations

Focuses on:

```text
* actual issue quantity by location/product;
* balance quantitiy by location.
```

### Business Insights

Focuses on:

```text
Structured tabular presentation mapping Inventory, Product, Loss, and Reconciliation findings to evidence and business implications.
```

### Weight Loss Root Cause Analysis & Action Plan

Focuses on:

```text
Investigates inventory weight loss, validates potential root causes, and recommends evidence-based corrective actions.
```

### Inventory Aging Investigation & Action Plan

Focuses on:

```text
Analyzes long-held inventory using average and weighted average ages alongside remaining balances to prioritize stock rotation reviews.
```

## 12. Important Analytical Interpretation Rules

The following rules should be maintained when interpreting the project:

1. `Balance Qty` represents stock/balance rather than a flow measure.
2. `FRN Qty` and `Actual Issue Qty` are movement-related measures.
3. `Calculated Difference` is a reconciliation diagnostic, not automatically physical loss.
4. Weight Loss, MC Loss and Unexplained Loss should remain separate.
5. NULL values should not automatically be interpreted as zero.
6. Missing business attributes should be documented rather than silently replaced.
7. Business findings should distinguish observed patterns from possible explanations.
8. Causal claims should not be made unless supported by additional evidence.

## 13. Data Quality Status

The final data quality and technical validation process included:

* record count validation;
* NULL checks;
* missing-value checks;
* negative-value checks;
* text standardisation checks;
* Power BI refresh validation;
* KPI validation;
* dashboard page validation;

Final production record count:

```text
2,129
```
## 14. GitHub Repository and Deliverables

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

The SQL scripts are intended to document the complete workflow from staging and production-table preparation through data-quality checks and inventory, loss, and operations analysis. The final repository should contain all 10 scripts.

### Publication safeguards

- Do not commit raw or sensitive source data, credentials, connection strings, personal information, or temporary backups.
- Review `.gitignore` before the first commit.
- Add a `LICENSE` only if a suitable licence has been deliberately selected.
- Ensure the README, data dictionary, cleaning documentation, SQL scripts, and six screenshots agree with the final project state.
- Do not claim a deliverable is complete unless it exists and has been checked in the repository.

## 15. Portfolio

This project demonstrates an end-to-end data analytics workflow:

```text
Data Understanding
       ↓
Data Cleaning
       ↓
Data Quality
       ↓
SQL Transformation
       ↓
SQL Analytics
       ↓
Data Modelling
       ↓
DAX
       ↓
Dashboard
       ↓
Business Insights
```

The project is designed to demonstrate practical skills in:

* Excel data preparation;
* data quality analysis;
* PostgreSQL;
* SQL;
* data modelling;
* DAX;
* Power BI;
* dashboard design;
* analytical reasoning;
* business insight communication;
