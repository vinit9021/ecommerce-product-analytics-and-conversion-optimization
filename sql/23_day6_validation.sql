-- ============================================================
-- Day 6 Validation
-- ============================================================


-- Executive metrics

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_overview`;


-- Daily trend coverage

SELECT
    COUNT(*) AS days,
    MIN(session_date) AS start_date,
    MAX(session_date) AS end_date,
    SUM(sessions) AS sessions,
    ROUND(SUM(revenue), 2) AS revenue

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.daily_kpis`;


-- Funnel

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_summary`
ORDER BY
    stage_order;


-- Product opportunity ranking

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_product_opportunities`
ORDER BY
    opportunity_rank;


-- Cohort retention

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.cohort_retention`
ORDER BY
    cohort_month,
    month_number;


-- Synthetic experiment summary

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_experiment_summary`;
