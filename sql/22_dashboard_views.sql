-- ============================================================
-- Day 6: Dashboard-ready analytical views
-- Used by the Streamlit Product Analytics application
-- ============================================================


-- ============================================================
-- 1. Executive Overview
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_overview`
AS

SELECT
    COUNT(*) AS sessions,

    COUNT(DISTINCT user_pseudo_id)
        AS users,

    SUM(step_1_view_item)
        AS product_view_sessions,

    SUM(recorded_purchase_session)
        AS purchasing_sessions,

    SUM(purchase_events)
        AS purchase_events,

    ROUND(
        SUM(revenue),
        2
    ) AS revenue,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(recorded_purchase_session),
            COUNT(*)
        ),
        2
    ) AS recorded_session_purchase_rate_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_6_purchase),
            SUM(step_1_view_item)
        ),
        2
    ) AS strict_view_to_purchase_pct,

    ROUND(
        SAFE_DIVIDE(
            SUM(revenue),
            COUNT(*)
        ),
        2
    ) AS revenue_per_session,

    ROUND(
        SAFE_DIVIDE(
            SUM(revenue),
            SUM(purchase_events)
        ),
        2
    ) AS avg_revenue_per_purchase_event

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.ordered_funnel_sessions`;


-- ============================================================
-- 2. Product Opportunities
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_product_opportunities`
AS

WITH ranked AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            ORDER BY incremental_revenue_50pct DESC
        ) AS opportunity_rank

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.business_opportunity_sizing`
)

SELECT
    opportunity_rank,

    item_name,

    item_category,

    product_view_sessions,

    view_to_cart_pct,

    benchmark_view_to_cart_pct,

    conversion_gap_pct_points,

    incremental_carts_25pct,
    incremental_purchases_25pct,
    incremental_revenue_25pct,

    incremental_carts_50pct,
    incremental_purchases_50pct,
    incremental_revenue_50pct,

    incremental_carts_100pct,
    incremental_purchases_100pct,
    incremental_revenue_100pct

FROM
    ranked

WHERE
    opportunity_rank <= 15

ORDER BY
    opportunity_rank;


-- ============================================================
-- 3. Synthetic Experiment Summary
--
-- The public dataset contains no experiment assignment.
-- These values reproduce the synthetic Day 5 demonstration.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.dashboard_experiment_summary`
AS

SELECT
    'Synthetic Product Detail Page Experiment'
        AS experiment_name,

    'SYNTHETIC'
        AS experiment_type,

    0.1703
        AS control_conversion_rate,

    0.1873
        AS treatment_conversion_rate,

    0.0170
        AS absolute_lift,

    0.0998
        AS relative_lift,

    0.0052
        AS p_value,

    0.0051
        AS confidence_interval_low,

    0.0289
        AS confidence_interval_high,

    7944
        AS sample_size_per_variant,

    15888
        AS total_sample_size,

    'SIGNIFICANT POSITIVE LIFT'
        AS statistical_result;
