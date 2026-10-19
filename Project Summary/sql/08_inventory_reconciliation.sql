SELECT
    location,

    SUM(frn_qty) AS frn_qty,

    SUM(actual_issue_qty) AS actual_issue_qty,

    SUM(balance_qty) AS balance_qty,

    SUM(frn_qty)
        - COALESCE(SUM(actual_issue_qty), 0)
        - COALESCE(SUM(balance_qty), 0)
        AS calculated_difference,

    SUM(frn_balance_difference) AS recorded_difference

FROM public.warehouse_stock

WHERE NULLIF(TRIM(location), '') IS NOT NULL

GROUP BY location

ORDER BY
    ABS(
        SUM(frn_qty)
        - COALESCE(SUM(actual_issue_qty), 0)
        - COALESCE(SUM(balance_qty), 0)
    ) DESC;