-- Inventory by Location
SELECT
    location,
    SUM(frn_qty) AS frn_qty,
    SUM(balance_qty) AS balance_qty,
    SUM(actual_issue_qty) AS actual_issue_qty,
    SUM(frn_bags) AS frn_bags,
    SUM(balance_bags) AS balance_bags
FROM public.warehouse_stock
WHERE NULLIF(TRIM(location), '') IS NOT NULL
GROUP BY location
ORDER BY balance_qty DESC NULLS LAST;

-- Inventory by Product
SELECT
    product_code,
    COUNT(*) AS records,
    SUM(frn_qty) AS frn_qty,
    SUM(balance_qty) AS balance_qty,
    SUM(actual_issue_qty) AS actual_issue_qty
FROM public.warehouse_stock
WHERE NULLIF(TRIM(product_code), '') IS NOT NULL
GROUP BY product_code
ORDER BY balance_qty DESC NULLS LAST;