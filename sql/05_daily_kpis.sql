-- ============================================================
-- Day 2: Daily Product KPI View
-- Grain: one row per calendar date
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.daily_kpis`
AS

SELECT
    session_date,

    COUNT(*) AS sessions,

    COUNT(DISTINCT user_pseudo_id) AS users,

    SUM(viewed_product) AS product_view_sessions,

    SUM(added_to_cart) AS add_to_cart_sessions,

    SUM(began_checkout) AS checkout_sessions,

    SUM(added_shipping) AS shipping_sessions,

    SUM(added_payment) AS payment_sessions,

    SUM(purchased) AS purchasing_sessions,

    SUM(purchase_events) AS purchase_events,

    ROUND(
        SUM(revenue),
        2
    ) AS revenue,

    ROUND(
        100 * SAFE_DIVIDE(
            SUM(purchased),
            COUNT(*)
        ),
        2
    ) AS session_purchase_rate_pct,

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
    `loyal-coyote-484615-e7.ecommerce_analytics.session_summary`

GROUP BY
    session_date

ORDER BY
    session_date;
