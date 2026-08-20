-- ============================================================
-- Day 4: Product Opportunity Ranking
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.product_opportunities`
AS

WITH benchmark AS (

    SELECT
        SAFE_DIVIDE(
            SUM(add_to_cart_sessions),
            SUM(product_view_sessions)
        ) AS overall_view_to_cart_rate

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.product_performance`
),

scored AS (

    SELECT
        p.*,

        b.overall_view_to_cart_rate,

        GREATEST(
            b.overall_view_to_cart_rate
            - SAFE_DIVIDE(
                p.add_to_cart_sessions,
                p.product_view_sessions
            ),
            0
        ) AS conversion_gap,

        p.product_view_sessions
        * GREATEST(
            b.overall_view_to_cart_rate
            - SAFE_DIVIDE(
                p.add_to_cart_sessions,
                p.product_view_sessions
            ),
            0
        ) AS estimated_incremental_cart_sessions

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.product_performance`
            AS p

    CROSS JOIN
        benchmark AS b

    WHERE
        p.product_view_sessions >= 100
)

SELECT
    product_key,

    item_name,

    item_category,

    product_view_sessions,

    add_to_cart_sessions,

    purchase_sessions,

    view_to_cart_pct,

    view_to_purchase_pct,

    ROUND(
        100 * overall_view_to_cart_rate,
        2
    ) AS benchmark_view_to_cart_pct,

    ROUND(
        100 * conversion_gap,
        2
    ) AS conversion_gap_pct_points,

    ROUND(
        estimated_incremental_cart_sessions,
        0
    ) AS estimated_incremental_cart_sessions,

    purchased_merchandise_value

FROM
    scored

ORDER BY
    estimated_incremental_cart_sessions DESC;
