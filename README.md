# UK House Market Analysis 
## Project Overview
This project builds an end-to-end data system that collects, stores, analyses, and visualises English and Welsh house price data by using Python, Apache Airflow, and PostgreSQL.

The system was **originally designed and deployed on AWS RDS (PostgreSQL)**, then **migrated to a local PostgreSQL database** for cost efficiency and reproducibility after AWS Free Tier expiration.

The final Power BI dashboard allows users to explore historical trends, and compare regional differences.

This project involves:
1. **Data Architecture:** Designing a Data Warehouse using Medallion Architecture.
2. **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.
3. **Analytics and Reporting:** Creating SQL-based reports and dashboards for actionable insights.

## Data Architecture
The project follows **Medallion Architecture (Bronze, Silver, Gold)** and supports two deployment environments:

### Original Cloud Architecture (AWS – deprecated)
![Cloud Architecture](docs/Cloud%20DA.png)
- **Bronze Layer:** Raw CSV data ingested into AWS RDS PostgreSQL.
- **Silver Layer:** Data cleansing and standardisation using SQL and Python.
- **Gold Layer:** Analytics-ready tables for reporting and dashboards.
> This architecture demonstrates experience in designing and operating a cloud-based relational data store using AWS RDS.

### Current Local Architecture (Active)
![Local Architecture](docs/Local%20DA.png)
- **Bronze Layer:** Stores raw data as-is from the source systems. Data is ingested from CSV Files into local PostgreSQL.
- **Silver Layer:** This layer includes data cleansing and standardization processes to prepare data for analysis.
- **Gold Layer:** Stores ready house price data required for reporting and analytics.
> The migration preserves the same schema, transformations, and queries, enabling reviewers to run the project locally without cloud costs.