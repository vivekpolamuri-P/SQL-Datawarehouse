use DataWareHouse;
SELECT * FROM silver.crm_prd_info;

SELECT 
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--DATA STANDARDIZATION AND CONSISTENCY
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

--CHECK FOR INVALID DATE
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt