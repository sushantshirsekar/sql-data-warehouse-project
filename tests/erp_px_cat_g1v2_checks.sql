/*==============================================================
Script Name : Silver Layer Data Validation - ERP Product Category
Purpose     : To validate data quality and consistency in 
              'silver.erp_px_cat_g1v2' table.
Description : Performs key quality checks to ensure data accuracy 
              and consistency in the Silver Layer.
Usage Notes: 
	- Run these checks after loading data into silver layer.
	- Investigate and resolve any discripancies found during the checks.
==============================================================*/

-- 1. Validate ID length and consistency
SELECT 
	LEN(id) AS id_length,
	COUNT(*) AS row_count
FROM silver.erp_px_cat_g1v2
GROUP BY LEN(id);

-- 2. Identify null, blank, or improperly formatted IDs
SELECT 
	id
FROM silver.erp_px_cat_g1v2
WHERE id IS NULL 
   OR TRIM(id) != id 
   OR TRIM(id) = '';

-- 3. Review distinct Category values
SELECT DISTINCT 
	cat
FROM silver.erp_px_cat_g1v2;

-- 4. Identify invalid or blank Category entries
SELECT 
	cat
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR TRIM(cat) = '';

-- 5. Review distinct Subcategory values
SELECT DISTINCT 
	subcat
FROM silver.erp_px_cat_g1v2;

-- 6. Identify invalid or blank Subcategory entries
SELECT 
	subcat
FROM silver.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat) 
   OR TRIM(subcat) = '';

-- 7. Review distinct Maintenance values
SELECT DISTINCT 
	maintenance
FROM silver.erp_px_cat_g1v2;

-- 8. Identify invalid or blank Maintenance entries
SELECT 
	maintenance
FROM silver.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance) 
   OR TRIM(maintenance) = '';

-- 9. Final data review
SELECT * 
FROM silver.erp_px_cat_g1v2;
