/*==============================================================
Script Name : Silver Layer Data Validation - Product Info
Purpose     : To validate standardized product data in 
              'silver.crm_prd_info' after transformation from Bronze.
Description : Performs key quality checks to ensure data accuracy 
              and consistency in the Silver Layer.
Usage Notes: 
	- Run these checks after loading data into silver layer.
	- Investigate and resolve any discripancies found during the checks.
==============================================================*/

-- 1. Check for nulls or duplicate product IDs
-- Expectation: No Result
SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


-- 2. Check for unwanted leading or trailing spaces in product names
-- Expectation: No Result
SELECT
	prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);


-- 3. Check for missing product cost values
-- Expectation: All products should have valid (non-zero) cost
SELECT
	ISNULL(prd_cost, 0) AS prd_info
FROM silver.crm_prd_info;


-- 4. View distinct product lines for consistency verification
SELECT DISTINCT
	prd_line
FROM silver.crm_prd_info;


-- 5. Validate product start and end date continuity
--    Ensures logical sequencing of product validity periods
SELECT 
	prd_id,
	prd_key,
	prd_nm,
	prd_start_dt,
	prd_end_dt,
	LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS prd_end_dt_test
FROM silver.crm_prd_info
