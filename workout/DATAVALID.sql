SELECT 
	NULLIF(sls_ship_dt,0)
FROM bronze.crm_sales_details
WHERE sls_ship_dt > 20500101 or sls_ship_dt < 19000101
or sls_ship_dt <= 0 or sls_ship_dt != 8

-- check for invalid date orders
SELECT * FROM
bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt

-- check data consistency
-- >> sales = quantity * price
-- >> values must not be zero, NULL, neagative

SELECT 
sls_sales as old_sales,

CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

sls_quantity,
sls_price as old_price,

CASE WHEN sls_price IS NULL OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity,0)
	ELSE sls_price
END sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,sls_price,sls_quantity