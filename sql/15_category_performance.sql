-- ============================================================
-- Day 4: Category Performance
-- Category is based on product-view metadata.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.category_performance`
AS

SELECT
    COALESCE(
        item_category,
        '(uncategorized)'
    ) AS item_category,

    SUM(product_view_sessions)
        AS product_view_sessions,

    SUM(add_to_cart_sessions)
        AS add_to_cart_sessions,

    SUM(checkout_sessions)
        AS checkout_sessions,

    SUM(purchase_sessions)
        AS purchase_sessions,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(add_to_cart_sessions),
            SUM(product_view_sessions)
        ),
        2
    ) AS view_to_cart_pct,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(purchase_sessions),
            SUM(product_view_sessions)
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
    `loyal-coyote-484615-e7.ecommerce_analytics.product_performance`

GROUP BY
    item_category

ORDER BY
    product_view_sessions DESC;
