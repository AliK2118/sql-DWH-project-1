/*
****************************************************************************************
Gold Layer Quality checks
****************************************************************************************
Script purpose:
  This script performs quality checks in order to validate the integrity, consistency,
  and security of the gold layer. These checks ensure:
  - uniqueness of the surrogate keys in the dimension tables
  - referential integrity between fact and dimension tables
  - validation of the relationship in the data model for analytical purposes
usage:
  - run these checks after loading data into the silver layer
  - investigate and resolve any discrepancies found during the checks.
****************************************************************************************
*/

--**************************************************************************************
-- checking the gold.dim_customers
--*************************************************************************************
--checking for the uniqueness of customer key in the gold.dim_customers
--expectation: No results

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;
--******************************************************************
-- checking the gold.dim_product table
--******************************************************************
--check for uniqueness of the product key in the gold.dim_products
-- expectations: No results

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;
  
--******************************************************************
-- checking the gold.fact_sales table
--******************************************************************
--check the dat model connectivity between fact table and the dimensions

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
