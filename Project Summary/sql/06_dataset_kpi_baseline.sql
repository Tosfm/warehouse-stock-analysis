SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT location) AS locations,
    COUNT(DISTINCT product_code) AS products,

    SUM(frn_qty) AS total_frn_qty,
    SUM(balance_qty) AS total_balance_qty,
    SUM(actual_issue_qty) AS total_actual_issue_qty,

    SUM(frn_bags) AS total_frn_bags,
    SUM(balance_bags) AS total_balance_bags,
    SUM(actual_issue_bags) AS total_actual_issue_bags
FROM public.warehouse_stock;
