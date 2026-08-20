-- ============================================================
-- Day 3: Overall Ordered Funnel Summary
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_summary`
AS

WITH counts AS (

    SELECT
        COUNT(*) AS all_sessions,

        SUM(step_1_view_item)
            AS product_view_sessions,

        SUM(step_2_add_to_cart)
            AS add_to_cart_sessions,

        SUM(step_3_begin_checkout)
            AS checkout_sessions,

        SUM(step_4_shipping)
            AS shipping_sessions,

        SUM(step_5_payment)
            AS payment_sessions,

        SUM(step_6_purchase)
            AS purchase_sessions

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.ordered_funnel_sessions`
),

stages AS (

    SELECT
        0 AS stage_order,
        'Session' AS stage,
        all_sessions AS sessions
    FROM counts

    UNION ALL

    SELECT
        1,
        'Product View',
        product_view_sessions
    FROM counts

    UNION ALL

    SELECT
        2,
        'Add to Cart',
        add_to_cart_sessions
    FROM counts

    UNION ALL

    SELECT
        3,
        'Begin Checkout',
        checkout_sessions
    FROM counts

    UNION ALL

    SELECT
        4,
        'Shipping Information',
        shipping_sessions
    FROM counts

    UNION ALL

    SELECT
        5,
        'Payment Information',
        payment_sessions
    FROM counts

    UNION ALL

    SELECT
        6,
        'Purchase',
        purchase_sessions
    FROM counts
),

calculated AS (

    SELECT
        stage_order,

        stage,

        sessions,

        LAG(sessions)
        OVER (
            ORDER BY stage_order
        ) AS previous_stage_sessions,

        FIRST_VALUE(sessions)
        OVER (
            ORDER BY stage_order
        ) AS total_session_base,

        MAX(
            IF(
                stage_order = 1,
                sessions,
                NULL
            )
        ) OVER () AS product_view_base

    FROM
        stages
)

SELECT
    stage_order,

    stage,

    sessions,

    previous_stage_sessions,

    CASE
        WHEN previous_stage_sessions IS NULL
            THEN NULL
        ELSE previous_stage_sessions - sessions
    END AS dropoff_sessions,

    ROUND(
        100 * SAFE_DIVIDE(
            sessions,
            previous_stage_sessions
        ),
        2
    ) AS step_conversion_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            previous_stage_sessions - sessions,
            previous_stage_sessions
        ),
        2
    ) AS step_dropoff_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            sessions,
            total_session_base
        ),
        2
    ) AS session_to_stage_pct,

    CASE
        WHEN stage_order = 0
            THEN NULL
        ELSE ROUND(
            100 * SAFE_DIVIDE(
                sessions,
                product_view_base
            ),
            2
        )
    END AS product_view_to_stage_pct

FROM
    calculated

ORDER BY
    stage_order;
