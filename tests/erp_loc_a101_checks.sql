/*==============================================================
Script Name : Silver Layer Data Validation - ERP Location Info
Purpose     : To ensure customer linkage and country data consistency 
              in 'silver.erp_loc_a101' after transformation.
Description : Performs key quality checks to ensure data accuracy 
              and consistency in the Silver Layer.
Usage Notes: 
	- Run these checks after loading data into silver layer.
	- Investigate and resolve any discripancies found during the checks.
==============================================================*/

-- 1. Validate Customer ID integrity (must exist in CRM Customer Info)
SELECT
	REPLACE(cid, '-', '') AS cid
FROM silver.erp_loc_a101
WHERE cid NOT IN (
	SELECT 
		cst_key
	FROM silver.crm_cust_info
);


-- 2. Review distinct Country values for consistency
SELECT 
	cntry 
FROM silver.erp_loc_a101
GROUP BY cntry
ORDER BY cntry;


-- 3. Final data review
SELECT * 
FROM silver.erp_loc_a101;
