SELECT
    location,

    SUM(weight_loss) AS weight_loss,

    SUM(mc_loss) AS mc_loss,

    SUM(unexplained_loss) AS unexplained_loss,

    ROUND(
        100.0 * SUM(weight_loss)
        / NULLIF(SUM(frn_qty), 0),
        2
    ) AS weight_loss_pct,

    ROUND(
        100.0 * SUM(mc_loss)
        / NULLIF(SUM(frn_qty), 0),
        2
    ) AS mc_loss_pct,

    ROUND(
        100.0 * SUM(unexplained_loss)
        / NULLIF(SUM(frn_qty), 0),
        2
    ) AS unexplained_loss_pct

FROM public.warehouse_stock

WHERE NULLIF(TRIM(location), '') IS NOT NULL

GROUP BY location

ORDER BY
    ABS(SUM(unexplained_loss)) DESC NULLS LAST;