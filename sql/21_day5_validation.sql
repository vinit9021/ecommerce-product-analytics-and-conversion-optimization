-- ============================================================
-- Day 5 Validation Queries
-- ============================================================


-- 1. Downstream assumptions

SELECT DISTINCT
    observed_cart_sessions,
    observed_post_cart_purchase_sessions,
    observed_post_cart_purchase_pct,
    avg_revenue_per_converted_cart_session

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.business_opportunity_sizing`;


-- 2. Highest-value product opportunities

SELECT
    item_name,
    item_category,
    product_view_sessions,
    view_to_cart_pct,
    benchmark_view_to_cart_pct,
    conversion_gap_pct_points,

    incremental_carts_50pct,
    incremental_purchases_50pct,
    incremental_revenue_50pct,

    incremental_carts_100pct,
    incremental_purchases_100pct,
    incremental_revenue_100pct

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.business_opportunity_sizing`

ORDER BY
    incremental_revenue_100pct DESC

LIMIT 15;


-- 3. Top-five portfolio scenario

WITH ranked AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            ORDER BY incremental_revenue_100pct DESC
        ) AS opportunity_rank

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.business_opportunity_sizing`
)

SELECT
    ROUND(
        SUM(incremental_purchases_25pct),
        1
    ) AS purchases_25pct,

    ROUND(
        SUM(incremental_revenue_25pct),
        2
    ) AS revenue_25pct,

    ROUND(
        SUM(incremental_purchases_50pct),
        1
    ) AS purchases_50pct,

    ROUND(
        SUM(incremental_revenue_50pct),
        2
    ) AS revenue_50pct,

    ROUND(
        SUM(incremental_purchases_100pct),
        1
    ) AS purchases_100pct,

    ROUND(
        SUM(incremental_revenue_100pct),
        2
    ) AS revenue_100pct

FROM
    ranked

WHERE
    opportunity_rank <= 5;
