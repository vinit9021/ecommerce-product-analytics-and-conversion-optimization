-- ============================================================
-- Day 2: Base GA4 event view
-- Grain: one row per GA4 event
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.events_base`
AS

SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date,

    TIMESTAMP_MICROS(event_timestamp) AS event_timestamp,

    user_pseudo_id,

    (
        SELECT ep.value.int_value
        FROM UNNEST(event_params) AS ep
        WHERE ep.key = 'ga_session_id'
    ) AS ga_session_id,

    CONCAT(
        user_pseudo_id,
        '-',
        CAST(
            (
                SELECT ep.value.int_value
                FROM UNNEST(event_params) AS ep
                WHERE ep.key = 'ga_session_id'
            ) AS STRING
        )
    ) AS session_key,

    event_name,

    device.category AS device_category,

    geo.country AS country,

    geo.region AS region,

    traffic_source.source AS first_user_source,

    traffic_source.medium AS first_user_medium,

    traffic_source.name AS first_user_campaign,

    ecommerce.transaction_id,

    ecommerce.purchase_revenue,

    ecommerce.total_item_quantity,

    (
        SELECT ep.value.int_value
        FROM UNNEST(event_params) AS ep
        WHERE ep.key = 'engagement_time_msec'
    ) AS engagement_time_msec

FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND user_pseudo_id IS NOT NULL;
