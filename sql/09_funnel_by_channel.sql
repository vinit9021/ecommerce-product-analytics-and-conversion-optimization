-- ============================================================
-- Day 3: Ordered Funnel by First-User Acquisition Channel
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_by_channel`
AS

SELECT
    COALESCE(
        first_user_source,
        '(not set)'
    ) AS first_user_source,

    COALESCE(
        first_user_medium,
        '(not set)'
    ) AS first_user_medium,

    COUNT(*) AS sessions,

    SUM(step_1_view_item)
        AS product_view_sessions,

    SUM(step_2_add_to_cart)
        AS add_to_cart_sessions,

    SUM(step_3_begin_checkout)
        AS checkout_sessions,

    SUM(step_5_payment)
        AS payment_sessions,

    SUM(step_6_purchase)
        AS purchase_sessions,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_2_add_to_cart),
            SUM(step_1_view_item)
        ),
        2
    ) AS view_to_cart_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_3_begin_checkout),
            SUM(step_2_add_to_cart)
        ),
        2
    ) AS cart_to_checkout_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_6_purchase),
            SUM(step_5_payment)
        ),
        2
    ) AS payment_to_purchase_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_6_purchase),
            SUM(step_1_view_item)
        ),
        2
    ) AS view_to_purchase_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_6_purchase),
            COUNT(*)
        ),
        2
    ) AS session_to_purchase_pct,

    ROUND(
        SUM(
            IF(
                step_6_purchase = 1,
                revenue,
                0
            )
        ),
        2
    ) AS strict_funnel_revenue

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.ordered_funnel_sessions`

GROUP BY
    first_user_source,
    first_user_medium

ORDER BY
    product_view_sessions DESC;
