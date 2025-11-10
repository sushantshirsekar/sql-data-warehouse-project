# Data Catalog for Gold Layer

### Overview
The Gold Layer provides the final, analytics-ready data representation.  
It consists of dimension and fact tables designed to support business intelligence, reporting, and analytics use cases.

> *Reference:* This catalog was inspired by **Data with Bara’s** Gold Layer design and adapted for this project.

---

### 1. gold.dim_customers
**Purpose:** Stores enriched customer details with demographic and regional attributes.

| Column Name | Data Type | Description |
|--------------|------------|-------------|
| customer_key | INT | Surrogate key uniquely identifying each customer. |
| customer_id | INT | Source system identifier for the customer. |
| customer_number | NVARCHAR(50) | Alphanumeric customer code for tracking. |
| first_name | NVARCHAR(50) | Customer’s first name. |
| last_name | NVARCHAR(50) | Customer’s last name. |
| country | NVARCHAR(50) | Country of residence. |
| marital_status | NVARCHAR(50) | Customer’s marital status. |
| gender | NVARCHAR(50) | Gender of the customer (*Male*, *Female*, *Unknown*). |
| birthdate | DATE | Date of birth. |
| create_date | DATE | Record creation date. |

---

### 2. gold.dim_products
**Purpose:** Contains product information and related attributes.

| Column Name | Data Type | Description |
|--------------|------------|-------------|
| product_key | INT | Surrogate key for each product. |
| product_id | INT | Unique product identifier. |
| product_number | NVARCHAR(50) | Structured alphanumeric product code. |
| product_name | NVARCHAR(50) | Product name and details. |
| category_id | NVARCHAR(50) | Identifier for product category. |
| category | NVARCHAR(50) | Main category (e.g., *Bikes*, *Components*). |
| subcategory | NVARCHAR(50) | Detailed classification of the product. |
| maintenance_required | NVARCHAR(50) | Indicates if maintenance is required (*Yes*, *No*, *Unknown*). |
| cost | INT | Base cost of the product. |
| product_line | NVARCHAR(50) | Product line or series. |
| start_date | DATE | Availability start date. |

---

### 3. gold.fact_sales
**Purpose:** Stores sales transaction data for analytical processing.

| Column Name | Data Type | Description |
|--------------|------------|-------------|
| order_number | NVARCHAR(50) | Unique sales order identifier. |
| product_key | INT | Links to `dim_products`. |
| customer_key | INT | Links to `dim_customers`. |
| order_date | DATE | Date when the order was placed. |
| shipping_date | DATE | Date when the order was shipped. |
| due_date | DATE | Payment due date. |
| sales_amount | INT | Total sale amount. |
| quantity | INT | Number of units sold. |
| price | INT | Unit price. |

---
