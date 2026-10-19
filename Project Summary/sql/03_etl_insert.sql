INSERT INTO public.warehouse_stock (
    frn_date, location, age_days, stack,
    product_name, product_code, sap_code, grade,
    frn_no, tally_sheet_no, 
    tally_sheet_bags, tally_sheet_qty, frn_bags, stock,
    frn_qty, mc_in, d_in, fm_in,
    mld, lb_pct, vo, rmin_bags, rmin_qty,
    issue_date, balance_bags, balance_qty, frn_balance_difference,
    actual_issue_bags, actual_issue_qty,
    issue_mc, issue_d, weight_loss, mc_loss, unexplained_loss,
    weight_loss_pct, mc_loss_pct, unexplained_loss_pct,
    month, year
)
SELECT
    -- Date & Text Identification
    TO_DATE(NULLIF(TRIM(frn_date), ''), 'DD,Mon,YY') AS frn_date,
    TRIM(location) AS location,
    NULLIF(REGEXP_REPLACE(age_days, '[^0-9.]', '', 'g'), '')::NUMERIC::INTEGER AS age_days,
    TRIM(stack) AS stack,
    TRIM(product_name) AS product_name,
    TRIM(product_code) AS product_code,
    TRIM(sap_code) AS sap_code,
    TRIM(grade) AS grade,
    TRIM(frn_no) AS frn_no,
    TRIM(tally_sheet_no) AS tally_sheet_no,

    -- Tally & Receipt Quantities
    NULLIF(REGEXP_REPLACE(tally_sheet_bags, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS tally_sheet_bags,
    NULLIF(REGEXP_REPLACE(tally_sheet_qty, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS tally_sheet_qty,
    NULLIF(REGEXP_REPLACE(frn_bags, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS frn_bags,
    TRIM(stock) AS stock,
    NULLIF(REGEXP_REPLACE(frn_qty, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS frn_qty,

    -- Lab & QA Metrics
    NULLIF(REGEXP_REPLACE(mc_in, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS mc_in,
    NULLIF(REGEXP_REPLACE(d_in, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS d_in,
    NULLIF(REGEXP_REPLACE(fm_in, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS fm_in,
    NULLIF(REGEXP_REPLACE(mld, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS mld,
    NULLIF(REGEXP_REPLACE(lb_pct, '[^0-9.]', '', 'g'), '')::NUMERIC(10,4) AS lb_pct,
    NULLIF(REGEXP_REPLACE(vo, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS vo,

    -- Issue / Outbound Metrics
    NULLIF(REGEXP_REPLACE(rmin_bags, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS rmin_bags,
    NULLIF(REGEXP_REPLACE(rmin_qty, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS rmin_qty,
    TO_DATE(NULLIF(TRIM(issue_date), ''), 'DD,Mon,YY') AS issue_date,

    -- Balances & Differences
    NULLIF(REGEXP_REPLACE(balance_bags, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS balance_bags,
    NULLIF(REGEXP_REPLACE(balance_qty, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS balance_qty,
    CASE 
        WHEN frn_balance_difference ~ '^-?[0-9,.]+$' 
        THEN REPLACE(frn_balance_difference, ',', '')::NUMERIC(18,2) 
        ELSE NULL 
    END AS frn_balance_difference,

    NULLIF(REGEXP_REPLACE(actual_issue_bags, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS actual_issue_bags,
    NULLIF(REGEXP_REPLACE(actual_issue_qty, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS actual_issue_qty,
    NULLIF(REGEXP_REPLACE(issue_mc, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS issue_mc,
    NULLIF(REGEXP_REPLACE(issue_d, '[^0-9.]', '', 'g'), '')::NUMERIC(18,2) AS issue_d,

    -- Loss Quantities (Supports negative values)
    CASE WHEN weight_loss ~ '^-?[0-9,.]+$' THEN REPLACE(weight_loss, ',', '')::NUMERIC(18,2) ELSE NULL END AS weight_loss,
    CASE WHEN mc_loss ~ '^-?[0-9,.]+$' THEN REPLACE(mc_loss, ',', '')::NUMERIC(18,2) ELSE NULL END AS mc_loss,
    CASE WHEN unexplained_loss ~ '^-?[0-9,.]+$' THEN REPLACE(unexplained_loss, ',', '')::NUMERIC(18,2) ELSE NULL END AS unexplained_loss,

    -- Loss Percentages (Strips '%', safely converts '#DIV/0!' to NULL, stores as decimal rate)
    CASE 
        WHEN weight_loss_pct ~ '^-?[0-9,.]+(%)?$' 
        THEN (REPLACE(REPLACE(weight_loss_pct, '%', ''), ',', '')::NUMERIC) / 100.0 
        ELSE NULL 
    END::NUMERIC(10,4) AS weight_loss_pct,

    CASE 
        WHEN mc_loss_pct ~ '^-?[0-9,.]+(%)?$' 
        THEN (REPLACE(REPLACE(mc_loss_pct, '%', ''), ',', '')::NUMERIC) / 100.0 
        ELSE NULL 
    END::NUMERIC(10,4) AS mc_loss_pct,

    CASE 
        WHEN unexplained_loss_pct ~ '^-?[0-9,.]+(%)?$' 
        THEN (REPLACE(REPLACE(unexplained_loss_pct, '%', ''), ',', '')::NUMERIC) / 100.0 
        ELSE NULL 
    END::NUMERIC(10,4) AS unexplained_loss_pct,

    -- Map text Month ('MAR', 'DEC', etc.) to 1-12 INTEGER
    CASE UPPER(TRIM(month))
        WHEN 'JAN' THEN 1
        WHEN 'FEB' THEN 2
        WHEN 'MAR' THEN 3
        WHEN 'APR' THEN 4
        WHEN 'MAY' THEN 5
        WHEN 'JUN' THEN 6
        WHEN 'JUL' THEN 7
        WHEN 'AUG' THEN 8
        WHEN 'SEP' THEN 9
        WHEN 'OCT' THEN 10
        WHEN 'NOV' THEN 11
        WHEN 'DEC' THEN 12
        ELSE NULLIF(REGEXP_REPLACE(month, '[^0-9]', '', 'g'), '')::INTEGER
    END AS month,

    NULLIF(REGEXP_REPLACE(year, '[^0-9]', '', 'g'), '')::INTEGER AS year
FROM warehouse_stock_staging;
