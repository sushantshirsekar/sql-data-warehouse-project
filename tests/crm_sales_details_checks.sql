/*==============================================================
Script Name : Silver Layer Data Validation - Sales Details
Purpose     : To verify data integrity, consistency, and validity 
              in 'silver.crm_sales_details' after transformation.
Description : Performs key quality checks to ensure data accuracy 
              and consistency in the Silver Layer.
Usage Notes: 
	- Run these checks after loading data into silver layer.
	- Investigate and resolve any discripancies found during the checks.
==============================================================*/

-- 1. Check for unwanted spaces in Order Number
SELECT
	sls_ord_num
FROM silver.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num);


-- 2. Validate Product Key integrity (must exist in Product Info)
SELECT 
	sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (
	SELECT prd_key
	FROM silver.crm_prd_info
);


-- 3. Validate Customer ID integrity (must exist in Customer Info)
SELECT 
	sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN (
	SELECT cst_id
	FROM silver.crm_cust_info
);


-- 4. Check for invalid or missing Order Dates
SELECT
	sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt IS NULL;


-- 5. Check for invalid Ship Dates (length or range issues)
SELECT
	NULLIF(sls_ship_dt, 0) AS sls_ship_dt
FROM silver.crm_sales_details
WHERE LEN(sls_ship_dt) > 8 
   OR LEN(sls_ship_dt) < 8 
   OR sls_ship_dt > 20500101 
   OR sls_ship_dt < 19000101;


-- 6. Check for invalid Due Dates (length or range issues)
SELECT
	NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM silver.crm_sales_details
WHERE LEN(sls_due_dt) > 8 
   OR LEN(sls_due_dt) < 8 
   OR sls_due_dt > 20500101 
   OR sls_due_dt < 19000101;


-- 7. Validate logical date order (Order < Ship < Due)
SELECT
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt
   OR sls_ship_dt > sls_due_dt;


-- 8. Check for invalid or missing Quantity values
SELECT
	sls_quantity
FROM silver.crm_sales_details
WHERE sls_quantity <= 0 OR sls_quantity IS NULL;


-- 9. Check for invalid or missing Sales values
SELECT
	sls_sales
FROM silver.crm_sales_details
WHERE sls_sales <= 0 OR sls_sales IS NULL;


-- 10. Identify inconsistent records between Price, Quantity, and Sales
SELECT
	sls_price, 
	sls_quantity,
	sls_sales
FROM silver.crm_sales_details
WHERE sls_sales IS NULL 
   OR sls_sales <= 0 
   OR sls_price IS NULL 
   OR sls_price <= 0;


-- 11. Final data review
SELECT * 
FROM silver.crm_sales_details;
