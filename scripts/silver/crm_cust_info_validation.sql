/*====================================================================
Script Name  : Silver Layer Data Quality Checks - CRM Customer Info
Purpose      : To validate the data quality, standardization, and 
               consistency of the 'silver.crm_cust_info' table.
               
Description  :
This script performs key data quality checks after transforming 
data from the Bronze Layer into the Silver Layer. It ensures that 
the CRM Customer Information table is clean, standardized, and 
ready for downstream analytical processing.

Checks Included:
1. Primary Key Validation:
   - Ensures no NULLs or duplicate values in the 'cst_id' column.
2. Data Cleanliness:
   - Detects leading or trailing spaces in text fields.
3. Data Standardization:
   - Verifies consistent values for gender and marital status.
     Expected Values:
       • Gender → 'Male', 'Female', 'Unknown'
       • Marital Status → 'Single', 'Married', 'Unknown'
4. Final Review:
   - Displays cleaned records for verification.

Expected Result:
- No records should appear in error-check queries.
====================================================================*/

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
