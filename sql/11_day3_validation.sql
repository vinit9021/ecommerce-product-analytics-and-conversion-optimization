-- ============================================================
-- Day 3 Validation Queries
-- ============================================================


-- ------------------------------------------------------------
-- 1. Ordered funnel population
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS sessions,

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
        AS strict_purchase_sessions,

    SUM(recorded_purchase_session)
        AS all_recorded_purchase_sessions,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(step_6_purchase),
            SUM(step_1_view_item)
        ),
        2
    ) AS strict_view_to_purchase_pct

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.ordered_funnel_sessions`;


-- ------------------------------------------------------------
-- 2. Funnel summary
-- ------------------------------------------------------------

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_summary`
ORDER BY
    stage_order;


-- ------------------------------------------------------------
-- 3. Device funnel
-- ------------------------------------------------------------

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_by_device`
ORDER BY
    sessions DESC;


-- ------------------------------------------------------------
-- 4. Major acquisition channels
-- ------------------------------------------------------------

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_by_channel`
WHERE
    product_view_sessions >= 100
ORDER BY
    product_view_sessions DESC
LIMIT 20;


-- ------------------------------------------------------------
-- 5. New vs returning funnel
-- ------------------------------------------------------------

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.funnel_by_user_type`
ORDER BY
    sessions DESC;
