# 🧱 SQL Data Warehouse Project (Medallion Architecture)

## 📘 Overview

This project is part of my SQL learning journey, based on the **Data with Baraa (30-hour)** course.
The goal is to **build a complete Data Warehouse** using SQL — focusing on data modeling, ETL logic, and layer-wise data transformation using the **Medallion Architecture**.

Even though this project is SQL-only, it aims to demonstrate how data flows from raw sources to analytics-ready models.

---

## 🧩 Architecture Overview

**Layers of the Medallion Architecture:**

1. **Bronze Layer (Raw Data)**

   * Data loaded as-is from source files
   * Batch processing: full load, truncate & insert
   * No transformation
   * Data Model: None (as-is)

2. **Silver Layer (Clean Data)**

   * Data cleaned, standardized, and normalized
   * Batch load with truncate & insert
   * Transformations:

     * Data cleaning
     * Data standardization
     * Data enrichment
   * Data Model: None (as-is)

3. **Gold Layer (Business-Ready Data)**

   * Object Type: Views
   * Transformations:

     * Data integration
     * Data aggregation
     * Business logic
   * Data Model:

     * Star schema
     * Flat tables
     * Aggregated tables

**Flow:**
`Source Files → Bronze (Raw Tables) → Silver (Cleaned Tables) → Gold (Business Views)`

---

## ⚙️ Technology Used

* **Language:** SQL
* **Database:** SQL Server
* **Tools:** SQL Server Management Studio 2021

*(You can update this once you finalize your environment.)*

---

## 🎯 Project Goals

* Understand **data warehousing fundamentals** using SQL
* Practice **ETL and transformation logic** directly in SQL
* Learn to design **Medallion-style architecture** for structured data
* Build strong foundations before integrating Python or Spark later

---

## 🧠 Learning Notes

> This project is a work in progress.
> The aim is to focus on **SQL data transformation logic** and **understanding architecture**, not on tools or automation (for now).

---

## 🪪 Author

**Sushant Shirsekar**
*Exploring Data Engineering through hands-on SQL projects.*
