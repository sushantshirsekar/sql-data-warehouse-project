# 🏗️ SQL Data Warehouse Project (Medallion Architecture)

## 📘 Overview

This project is part of my SQL learning journey, inspired by the **Data with Baraa (30-hour)** course.  
It focuses on building a complete **Data Warehouse** using SQL — covering **data modeling, ETL logic**, and **layer-wise data transformation** using the **Medallion Architecture**.

Even though this project is SQL-only, it demonstrates how data flows from **raw sources** to **analytics-ready models**.

---

## 🧭 Data Architecture Diagram

<img width="1471" height="716" alt="data_flow" src="https://github.com/user-attachments/assets/a213380e-db5d-4242-ba36-e792b320d163" />

## 🧩 Architecture Overview

### 🥉 Bronze Layer (Raw Data)
- Data loaded **as-is** from source CSV files.  
- **Batch load** using truncate & insert.  
- **No transformation** applied.

### 🥈 Silver Layer (Clean Data)
- Data **cleaned, standardized, and normalized**.  
- **Data enrichment** and **validation** applied.  
- Batch load with **truncate & insert** strategy.

### 🥇 Gold Layer (Business-Ready Data)
- **Views** for analytical consumption.  
- Integrates, aggregates, and applies **business logic**.  
- **Star schema** model used for reporting and BI.

**Data Flow:**  
`Source Files → Bronze (Raw Tables) → Silver (Cleaned Tables) → Gold (Business Views)`

---

## 🧱 Project Folder Structure

SQL-Data-Warehouse/
│
├── datasets/
│   ├── crm/
│   │   ├── crm_cust_info.csv
│   │   ├── crm_prd_info.csv
│   │   └── crm_sales_details.csv
│   │
│   └── erp/
│       ├── erp_cust_az12.csv
│       ├── erp_loc_a101.csv
│       └── erp_px_cat_g1v2.csv
│
├── docs/
│   ├── data_architecture.png
│   ├── data_catalog.md
│   ├── data_flow.png
│   ├── data_integration.png
│   └── data_model.png
│
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   │
│   ├── silver/
│   │   └── init_database.sql
│   │
│   └── gold/
│       └── ddl_gold.sql
│
├── tests/
│   ├── crm_cust_info_checks.sql
│   ├── crm_prd_info_checks.sql
│   ├── crm_sales_details_checks.sql
│   ├── erp_cust_az12_checks.sql
│   ├── erp_loc_a101_checks.sql
│   ├── erp_px_cat_g1v2_checks.sql
│   └── quality_checks_gold.sql
│
├── LICENSE
└── README.md


---

## ⚙️ Technology Used
- **Language:** SQL  
- **Database:** SQL Server  
- **Tool:** SQL Server Management Studio (SSMS 2021)  

---

## 🎯 Project Goals
- Understand **data warehousing fundamentals** using SQL.  
- Practice **ETL and transformation logic** directly within SQL.  
- Learn to design **Medallion-style architecture** for structured datasets.  
- Build strong foundations before integrating **Python** or **Spark**.

---

## 🧠 Learning Notes
This project is a **work in progress** — the main focus is understanding **SQL-based transformations** and **data architecture**, not automation or orchestration (yet).

---

## 👤 About Me
Hi, I’m **Sushant Shirsekar** — I’ve worked **1.5 years as an Android Developer** and am now exploring **Data Engineering** through hands-on SQL projects.  
I’m currently looking for opportunities that align with my skills and passion for data — **any role that fits my background would be appreciated.**

📩 **Email:** sushantshirsekar54@gmail.com  
🔗 **LinkedIn:** [www.linkedin.com/in/sushant-shirsekar-886229222](https://www.linkedin.com/in/sushant-shirsekar-886229222)

---

⭐ **If you found this project insightful, consider giving it a star on GitHub!**
