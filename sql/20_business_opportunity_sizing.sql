-- ============================================================
-- Day 5: Business Opportunity Sizing
--
-- Uses real observed funnel behavior to translate product-level
-- cart opportunities into estimated purchases and revenue.
--
-- These estimates are directional planning scenarios, not
-- causal forecasts.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.business_opportunity_sizing`
AS

WITH cart_start AS (

    SELECT
        session_key,

        MIN(event_timestamp)
            AS first_cart_ts

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.events_base`

    WHERE
        event_name = 'add_to_cart'

    GROUP BY
        session_key
),

post_cart_outcome AS (

    SELECT
        c.session_key,

        c.first_cart_ts,

        MIN(p.event_timestamp)
            AS purchase_after_cart_ts

    FROM
        cart_start AS c

    LEFT JOIN
        `loyal-coyote-484615-e7.ecommerce_analytics.events_base`
            AS p

        ON p.session_key = c.session_key
        AND p.event_name = 'purchase'
        AND p.event_timestamp >= c.first_cart_ts

    GROUP BY
        c.session_key,
        c.first_cart_ts
),

assumptions AS (

    SELECT
        COUNT(*) AS observed_cart_sessions,

        COUNTIF(
            p.purchase_after_cart_ts IS NOT NULL
        ) AS observed_post_cart_purchase_sessions,

        SAFE_DIVIDE(
            COUNTIF(
                p.purchase_after_cart_ts IS NOT NULL
            ),
            COUNT(*)
        ) AS post_cart_purchase_rate,

        AVG(
            IF(
                p.purchase_after_cart_ts IS NOT NULL,
                s.revenue,
                NULL
            )
        ) AS avg_revenue_per_converted_cart_session

    FROM
        post_cart_outcome AS p

    JOIN
        `loyal-coyote-484615-e7.ecommerce_analytics.session_summary`
            AS s
        USING (session_key)
),

scenarios AS (

    SELECT
        p.product_key,

        p.item_name,

        p.item_category,

        p.product_view_sessions,

        p.add_to_cart_sessions,

        p.purchase_sessions,

        p.view_to_cart_pct,

        p.view_to_purchase_pct,

        p.benchmark_view_to_cart_pct,

        p.conversion_gap_pct_points,

        p.estimated_incremental_cart_sessions,

        a.observed_cart_sessions,

        a.observed_post_cart_purchase_sessions,

        a.post_cart_purchase_rate,

        a.avg_revenue_per_converted_cart_session,

        p.estimated_incremental_cart_sessions
            * 0.25
            AS incremental_carts_25pct_gap_close,

        p.estimated_incremental_cart_sessions
            * 0.50
            AS incremental_carts_50pct_gap_close,

        p.estimated_incremental_cart_sessions
            AS incremental_carts_100pct_gap_close

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.product_opportunities`
            AS p

    CROSS JOIN
        assumptions AS a
)

SELECT
    product_key,

    item_name,

    item_category,

    product_view_sessions,

    view_to_cart_pct,

    benchmark_view_to_cart_pct,

    conversion_gap_pct_points,

    estimated_incremental_cart_sessions,

    observed_cart_sessions,

    observed_post_cart_purchase_sessions,

    ROUND(
        100 * post_cart_purchase_rate,
        2
    ) AS observed_post_cart_purchase_pct,

    ROUND(
        avg_revenue_per_converted_cart_session,
        2
    ) AS avg_revenue_per_converted_cart_session,

    ROUND(
        incremental_carts_25pct_gap_close,
        0
    ) AS incremental_carts_25pct,

    ROUND(
        incremental_carts_25pct_gap_close
        * post_cart_purchase_rate,
        1
    ) AS incremental_purchases_25pct,

    ROUND(
        incremental_carts_25pct_gap_close
        * post_cart_purchase_rate
        * avg_revenue_per_converted_cart_session,
        2
    ) AS incremental_revenue_25pct,

    ROUND(
        incremental_carts_50pct_gap_close,
        0
    ) AS incremental_carts_50pct,

    ROUND(
        incremental_carts_50pct_gap_close
        * post_cart_purchase_rate,
        1
    ) AS incremental_purchases_50pct,

    ROUND(
        incremental_carts_50pct_gap_close
        * post_cart_purchase_rate
        * avg_revenue_per_converted_cart_session,
        2
    ) AS incremental_revenue_50pct,

    ROUND(
        incremental_carts_100pct_gap_close,
        0
    ) AS incremental_carts_100pct,

    ROUND(
        incremental_carts_100pct_gap_close
        * post_cart_purchase_rate,
        1
    ) AS incremental_purchases_100pct,

    ROUND(
        incremental_carts_100pct_gap_close
        * post_cart_purchase_rate
        * avg_revenue_per_converted_cart_session,
        2
    ) AS incremental_revenue_100pct

FROM
    scenarios

ORDER BY
    incremental_revenue_100pct DESC;
