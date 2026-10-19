SELECT
    year,
    month,
    SUM(frn_qty) AS frn_qty,
    SUM(actual_issue_qty) AS actual_issue_qty,
    SUM(balance_qty) AS balance_qty
FROM public.warehouse_stock
WHERE year IS NOT NULL
  AND month IS NOT NULL
GROUP BY
    year,
    month
ORDER BY
    year,
    month;