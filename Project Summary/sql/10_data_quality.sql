-- 1. Total records
SELECT COUNT(*) AS total_records
FROM public.warehouse_stock;

-- 2. Missing location
SELECT COUNT(*) AS missing_location
FROM public.warehouse_stock
WHERE NULLIF(TRIM(location), '') IS NULL;

-- 3. Missing product code
SELECT COUNT(*) AS missing_product_code
FROM public.warehouse_stock
WHERE NULLIF(TRIM(product_code), '') IS NULL;

-- 4. Null FRN quantity
SELECT COUNT(*) AS null_frn_qty
FROM public.warehouse_stock
WHERE frn_qty IS NULL;

-- 5. Null actual issue quantity
SELECT COUNT(*) AS null_actual_issue_qty
FROM public.warehouse_stock
WHERE actual_issue_qty IS NULL;

-- 6. Null balance quantity
SELECT COUNT(*) AS null_balance_qty
FROM public.warehouse_stock
WHERE balance_qty IS NULL;

-- 7
SELECT
    COUNT(*) AS negative_frn_qty
FROM public.warehouse_stock
WHERE frn_qty < 0;

-- 8
SELECT
    COUNT(*) AS negative_actual_issue_qty
FROM public.warehouse_stock
WHERE actual_issue_qty < 0;

-- 9
SELECT
    COUNT(*) AS negative_balance_qty
FROM public.warehouse_stock
WHERE balance_qty < 0;
