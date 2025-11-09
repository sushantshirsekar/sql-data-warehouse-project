/*==============================================================
Script Name : Silver Layer Data Validation - ERP Customer Info
Purpose     : To verify data integrity, consistency, and validity 
              in 'silver.erp_cust_az12' after transformation.
==============================================================*/

-- 1. Check for inconsistent Customer ID lengths
SELECT 
	LEN(cid) AS id_length,
	COUNT(*) AS row_count
FROM silver.erp_cust_az12
GROUP BY LEN(cid)
ORDER BY LEN(cid);


-- 2. Identify invalid Birth Dates
SELECT
	bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();


-- 3. Detect unwanted spaces in Gender field
SELECT
	gen
FROM silver.erp_cust_az12
WHERE gen != TRIM(gen);


-- 4. Verify allowed Gender values (Expected: Male, Female, Unknown)
SELECT DISTINCT
	gen
FROM silver.erp_cust_az12;


-- 5. Final data review
SELECT * 
FROM silver.erp_cust_az12;
