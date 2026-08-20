-- ============================================================
-- Day 4: Item-level event layer
-- Grain: one product within one GA4 event
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.item_events`
AS

SELECT
    PARSE_DATE('%Y%m%d', raw.event_date)
        AS event_date,

    TIMESTAMP_MICROS(raw.event_timestamp)
        AS event_timestamp,

    raw.user_pseudo_id,

    (
        SELECT ep.value.int_value
        FROM UNNEST(raw.event_params) AS ep
        WHERE ep.key = 'ga_session_id'
    ) AS ga_session_id,

    CONCAT(
        raw.user_pseudo_id,
        '-',
        CAST(
            (
                SELECT ep.value.int_value
                FROM UNNEST(raw.event_params) AS ep
                WHERE ep.key = 'ga_session_id'
            ) AS STRING
        )
    ) AS session_key,

    raw.event_name,

    raw.device.category AS device_category,

    raw.geo.country AS country,

    raw.traffic_source.source
        AS first_user_source,

    raw.traffic_source.medium
        AS first_user_medium,

    item.item_id,

    item.item_name,

    item.item_brand,

    item.item_category,

    item.item_category2,

    item.item_category3,

    item.item_variant,

    item.price,

    COALESCE(item.quantity, 1)
        AS quantity,

    ROUND(
        COALESCE(item.price, 0)
        * COALESCE(item.quantity, 1),
        2
    ) AS merchandise_value

FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
        AS raw

CROSS JOIN
    UNNEST(raw.items) AS item

WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'

    AND raw.event_name IN (
        'view_item',
        'add_to_cart',
        'begin_checkout',
        'purchase'
    )

    AND raw.user_pseudo_id IS NOT NULL

    AND item.item_name IS NOT NULL;
