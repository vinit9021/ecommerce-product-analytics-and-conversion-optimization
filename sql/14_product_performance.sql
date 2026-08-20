-- ============================================================
-- Day 4: Product Performance
-- Grain: one canonical product
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.product_performance`
AS

SELECT
    product_key,

    APPROX_TOP_COUNT(
        item_name,
        1
    )[SAFE_OFFSET(0)].value
        AS item_name,

    APPROX_TOP_COUNT(
        item_category,
        1
    )[SAFE_OFFSET(0)].value
        AS item_category,

    COUNT(*) AS product_view_sessions,

    SUM(added_to_cart_after_view)
        AS add_to_cart_sessions,

    SUM(reached_checkout_after_cart)
        AS checkout_sessions,

    SUM(purchased_after_view)
        AS purchase_sessions,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(added_to_cart_after_view),
            COUNT(*)
        ),
        2
    ) AS view_to_cart_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(reached_checkout_after_cart),
            SUM(added_to_cart_after_view)
        ),
        2
    ) AS cart_to_checkout_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(purchased_after_view),
            COUNT(*)
        ),
        2
    ) AS view_to_purchase_pct,

    SUM(purchased_quantity)
        AS purchased_quantity,

    ROUND(
        SUM(purchased_merchandise_value),
        2
    ) AS purchased_merchandise_value

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.product_session_behavior`

GROUP BY
    product_key;
