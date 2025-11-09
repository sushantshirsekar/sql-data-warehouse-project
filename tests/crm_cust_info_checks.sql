/*==============================================================
Script Name : Silver Layer Data Quality Checks - CRM Customer Info
Purpose     : To validate data consistency and standardization in 
              'silver.crm_cust_info'.
Checks      :
  1. Duplicates or NULLs in Primary Key (cst_id)
  2. Unwanted spaces in text columns
  3. Standard values for Gender & Marital Status
Expected    : No invalid records found

Usage Notes: 
	- Run these checks after loading data into silver layer.
	- Investigate and resolve any discripancies found during the checks.
==============================================================*/

-- Check for nulls or duplicates in Primary key
-- Expectation : No Result
SELECT 
	cst_id, 
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL


-- Check for unwanted spaces
-- Expectation : No Result
-- Use for different parameters -> cst_lastname,
-- cst_marital_status, cst_gndr
SELECT 
	cst_id,
	cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
  

-- Data Standardization and Consistency
-- Expectation : 
-- Gender -> Male, Female, Unknown
-- Marital Status -> Single, Married, Unknown
SELECT DISTINCT 
	cst_gndr
FROM silver.crm_cust_info

SELECT DISTINCT 
	cst_marital_status
FROM silver.crm_cust_info
