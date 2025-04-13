/*
===================================================================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accurancy as well as standardization across
  the silver schema. The checks performed include:
  - Null or duplicated primary keys
  - unwanted spaces in string fields
  - data stadardization and consistency
  - invalid date ranges and orders
  - data consistency between related fields.

Usage Notes:
  - Run the the checks after loading data into the silver layer
  - Investogate and resolve any discrepancies found during the checks
===================================================================================================================
*/
--**************************************************************
-- Checking  the silver.crm_cust_info table
--**************************************************************
-- check for NULLs or Duplicates in the Primary Key
-- Expectation: No results
SELECT 
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- check for unwanted spaces
-- Expectation: No results
SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- data standardization and consistency
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

--***************************************************************
-- Checking  the silver.crm_prd_info table
--****************************************************************
--check for NULLs or Duplicates in the Primary Key
--Expectation: No results
SELECT 
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- check for unwanted spaces
-- Expectation: No results
SELECT 
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative values in Cost
-- Expectation: No results
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- data standardization and consistency
SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;

-- check for Invalid date orders (start date > end date)
-- Expectations: No results
SELECT 
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--****************************************************************
-- Checking  the silver.crm_sales_details table
--****************************************************************
-- check for invalid dates
-- Expectation: No Invalid dates
SELECT
  NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
  OR LEN(sls_due_dt) != 0
  OR sls_due_dt > ------------------------------------------------------------
  OR sls_due_dt <-------------------;

--check for invalid date Orders (order date > shipping/Due dates)
-- Expectation: No Result
SELECT 
  *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
  OR  sls_order_dt > sls_due_dt;

-- check data consistency: Sales = Quantity * Price
-- Expectations: No results
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;
  
--****************************************************************
-- Checking  the silver.erp_cust_az12 table
--****************************************************************
-- identify out-of-range dates
-- Expectation: Birthdates between 1924.01.01 and today 
SELECT DISTINCT 
  bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924.01.02'
  OR  bdate > GETDATE();

-- data standardization and consistency
SELECT DISTINCT 
  gen
FROM silver.erp_cust_az12;

--****************************************************************
-- Checking  the silver.erp_loc_a101 table
--****************************************************************
-- data standardization and consistency
SELECT DISTINCT 
  cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

--****************************************************************
-- Checking  the silver.erp_px_cat_g1v2 table
--****************************************************************
-- check for unwanted spaces
-- Expectation: No results
SELECT 
  *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
  OR subcat != TRIM(subcat)
  OR maintenance != TRIM(maintenance);

-- data consistency and consistency
SELECT DISTINCT 
  maintenance
FROM silver.erp_px_cat_g1v2;

