-- ============================================================
-- Day 2: Session-level analytical view
-- Grain: one row per user-session
--
-- Purchase events are used as the primary purchase-volume
-- measure because transaction_id contains obfuscated values
-- such as "(not set)" and some reused identifiers.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.session_summary`
AS

SELECT
    session_key,

    user_pseudo_id,

    ga_session_id,

    MIN(event_timestamp) AS session_start_time,

    MAX(event_timestamp) AS session_end_time,

    DATE(MIN(event_timestamp)) AS session_date,

    TIMESTAMP_DIFF(
        MAX(event_timestamp),
        MIN(event_timestamp),
        SECOND
    ) AS session_duration_seconds,

    ARRAY_AGG(
        device_category
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS device_category,

    ARRAY_AGG(
        country
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS country,

    ARRAY_AGG(
        region
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS region,

    ARRAY_AGG(
        first_user_source
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS first_user_source,

    ARRAY_AGG(
        first_user_medium
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS first_user_medium,

    ARRAY_AGG(
        first_user_campaign
        IGNORE NULLS
        ORDER BY event_timestamp
        LIMIT 1
    )[SAFE_OFFSET(0)] AS first_user_campaign,

    COUNT(*) AS event_count,

    COUNTIF(
        event_name = 'page_view'
    ) AS page_views,

    SUM(
        COALESCE(engagement_time_msec, 0)
    ) AS engagement_time_msec,

    MAX(
        IF(event_name = 'view_item', 1, 0)
    ) AS viewed_product,

    MAX(
        IF(event_name = 'add_to_cart', 1, 0)
    ) AS added_to_cart,

    MAX(
        IF(event_name = 'begin_checkout', 1, 0)
    ) AS began_checkout,

    MAX(
        IF(event_name = 'add_shipping_info', 1, 0)
    ) AS added_shipping,

    MAX(
        IF(event_name = 'add_payment_info', 1, 0)
    ) AS added_payment,

    MAX(
        IF(event_name = 'purchase', 1, 0)
    ) AS purchased,

    COUNTIF(
        event_name = 'purchase'
    ) AS purchase_events,

    COUNT(
        DISTINCT IF(
            event_name = 'purchase'
            AND transaction_id IS NOT NULL
            AND transaction_id != ''
            AND transaction_id != '(not set)',
            transaction_id,
            NULL
        )
    ) AS valid_transaction_ids_in_session,

    ROUND(
        SUM(
            IF(
                event_name = 'purchase',
                COALESCE(purchase_revenue, 0),
                0
            )
        ),
        2
    ) AS revenue

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.events_base`

GROUP BY
    session_key,
    user_pseudo_id,
    ga_session_id;
