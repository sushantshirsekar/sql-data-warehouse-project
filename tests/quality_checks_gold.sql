/*==============================================================
Script Name : Gold Layer - Data Quality Checks
Purpose     : To verify data integrity, consistency, and 
              referential accuracy in the Gold Layer after 
              transformation from the Silver Layer.
Usage       : Run this script after successful creation of 
              Gold Layer views. 
              Investigate and resolve discrepancies before 
              downstream analytics consumption.
==============================================================*/


---------------------------------------------------------------
-- 1. Check Uniqueness in Dimension: gold.dim_customers
--    Purpose : Ensure surrogate key uniqueness.
---------------------------------------------------------------
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


---------------------------------------------------------------
-- 2. Check for Null Keys in gold.dim_customers
--    Purpose : Validate key and essential attribute completeness.
---------------------------------------------------------------
SELECT *
FROM gold.dim_customers
WHERE customer_key IS NULL 
   OR customer_id IS NULL 
   OR customer_number IS NULL;


---------------------------------------------------------------
-- 3. Check Uniqueness in Dimension: gold.dim_products
--    Purpose : Ensure surrogate key uniqueness.
---------------------------------------------------------------
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


---------------------------------------------------------------
-- 4. Check for Null Keys in gold.dim_products
--    Purpose : Validate completeness of product identifiers.
---------------------------------------------------------------
SELECT *
FROM gold.dim_products
WHERE product_key IS NULL 
   OR product_id IS NULL 
   OR product_number IS NULL;


---------------------------------------------------------------
-- 5. Validate Referential Integrity in gold.fact_sales
--    Purpose : Ensure all fact records map to valid dimension keys.
---------------------------------------------------------------
SELECT 
    f.order_number,
    f.customer_key,
    f.product_key
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
WHERE c.customer_key IS NULL 
   OR p.product_key IS NULL;


---------------------------------------------------------------
-- 6. Check for Negative or Zero Values in Sales Measures
--    Purpose : Ensure business data consistency for reporting.
---------------------------------------------------------------
SELECT *
FROM gold.fact_sales
WHERE sales_amount <= 0 
   OR quantity <= 0 
   OR price <= 0;


---------------------------------------------------------------
-- 7. Check for Missing Dates in gold.fact_sales
--    Purpose : Validate completeness of order-related timestamps.
---------------------------------------------------------------
SELECT *
FROM gold.fact_sales
WHERE order_date IS NULL
   OR shipping_date IS NULL
   OR due_date IS NULL;
