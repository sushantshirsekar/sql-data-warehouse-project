/*==============================================================
Script Name : Gold Layer - Dimension & Fact Views Creation
Purpose     : To create analytical-ready dimensional and fact 
              tables in the Gold Layer for reporting and BI.
Usage       : Run this script after successful loading and 
              validation of the Silver Layer data. 
              These views are consumed by downstream dashboards 
              and analytics models.
==============================================================*/

---------------------------------------------------------------
-- 1. Create Customer Dimension (gold.dim_customers)
--    Purpose : To provide a unified and cleansed customer view
--              combining CRM and ERP sources.
---------------------------------------------------------------

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE OR ALTER VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_marital_status AS marital_status,
	CASE
		WHEN ci.cst_gndr != 'Unknown' THEN cst_gndr
		ELSE COALESCE(ca.gen, 'Unknown')
	END AS gender,
	ci.cst_create_date AS create_date,
	ca.bdate AS birth_date,
	la.cntry AS country
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
	ON ca.cid = ci.cst_key
LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_key = la.cid;


---------------------------------------------------------------
-- 2. Create Product Dimension (gold.dim_products)
--    Purpose : To store product master data enriched with 
--              category, sub-category, and maintenance details.
---------------------------------------------------------------

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE OR ALTER VIEW gold.dim_products AS
	SELECT 
		ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
		pn.prd_id			AS product_id,
		pn.prd_key			AS product_number,
		pn.prd_nm			AS product_name,
		pn.cat_id			AS category_id,
		pc.cat				AS category,
		pc.subcat			AS sub_category,
		pc.maintenance,
		pn.prd_cost			AS cost,
		pn.prd_line			AS product_line,
		pn.prd_start_dt		AS start_date
	FROM silver.crm_prd_info AS pn
	LEFT JOIN silver.erp_px_cat_g1v2 AS pc
		ON pn.cat_id = pc.id
	WHERE pn.prd_end_dt IS NULL;


---------------------------------------------------------------
-- 3. Create Sales Fact (gold.fact_sales)
--    Purpose : To store transactional sales data linked to 
--              product and customer dimensions for reporting.
---------------------------------------------------------------

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
	sd.sls_ord_num		AS order_number,
	pr.product_key,
	cust.customer_key,
	sd.sls_order_dt		AS order_date,
	sd.sls_ship_dt		AS shipping_date,
	sd.sls_due_dt		AS due_date,
	sd.sls_sales		AS sales_amount,
	sd.sls_quantity		AS quantity,
	sd.sls_price		AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS pr
	ON pr.product_number = sd.sls_prd_key
LEFT JOIN gold.dim_customers AS cust
	ON sd.sls_cust_id = cust.customer_id;
