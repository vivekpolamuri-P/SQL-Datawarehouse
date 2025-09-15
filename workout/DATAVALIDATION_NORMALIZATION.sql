-- Duplicate values
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date desc) as flag_last
FROM bronze.crm_cust_info)t 
where flag_last !=1

-- check for unwanted spaces
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) --CHECKING EXTRA SPACES

--DATA STANDARDIZATION AND CONSISTENCY
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info


--prd_table
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY prd_id ORDER BY prd_start_dt desc) as flag_last
FROM bronze.crm_prd_info)t 
where flag_last !=1


--CHECK NEGATIVE NUMBERS or NULLS
SELECT prd_nm
FROM bronze.crm_prd_info
where prd_nm != TRIM(prd_nm)

SELECT prd_cost
FROM bronze.crm_prd_info
where prd_cost < 0 OR prd_cost IS NULL

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--CHECK FOR INVALID DATES
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--bad data/ person who is 100years older OR DOB IS greater that Today
SELECT DISTINCT bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924 -01-01' OR bdate > GETDATE();

--Data Standardization and consistency
SELECT DISTINCT gen
FROM bronze.erp_cust_az12;

-- check unwanted spaces
SELECT cat
FROM bronze.erp_px_cat_g1v2
WHERE cat!= TRIM(cat)

SELECT maintenanace
FROM bronze.erp_px_cat_g1v2
WHERE maintenanace != TRIM(maintenanace)

-- Data Standardization and consistency(Duplicates)
SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT maintenanace
FROM bronze.erp_px_cat_g1v2