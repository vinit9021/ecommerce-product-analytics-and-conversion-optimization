-- ============================================================
-- 01: GA4 E-commerce Dataset Exploration
-- Dataset:
-- bigquery-public-data.ga4_obfuscated_sample_ecommerce
-- ============================================================


-- ------------------------------------------------------------
-- 1. Event volume by event type
-- ------------------------------------------------------------

SELECT
    event_name,
    COUNT(*) AS event_count,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY
    event_name
ORDER BY
    event_count DESC;


-- ------------------------------------------------------------
-- 2. Dataset date coverage
-- ------------------------------------------------------------

SELECT
    MIN(PARSE_DATE('%Y%m%d', event_date)) AS start_date,
    MAX(PARSE_DATE('%Y%m%d', event_date)) AS end_date,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';


-- ------------------------------------------------------------
-- 3. Daily users and events
-- ------------------------------------------------------------

SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    COUNT(*) AS events,
    COUNT(DISTINCT user_pseudo_id) AS users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY
    event_date
ORDER BY
    event_date;


-- ------------------------------------------------------------
-- 4. Device distribution
-- ------------------------------------------------------------

SELECT
    device.category AS device_category,
    COUNT(DISTINCT user_pseudo_id) AS users,
    COUNT(*) AS events
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY
    device_category
ORDER BY
    users DESC;


-- ------------------------------------------------------------
-- 5. Traffic sources
-- ------------------------------------------------------------

SELECT
    traffic_source.source,
    traffic_source.medium,
    COUNT(DISTINCT user_pseudo_id) AS users,
    COUNT(*) AS events
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY
    traffic_source.source,
    traffic_source.medium
ORDER BY
    users DESC;


-- ------------------------------------------------------------
-- 6. Core e-commerce funnel event counts
-- ------------------------------------------------------------

SELECT
    event_name,
    COUNT(*) AS events,
    COUNT(DISTINCT user_pseudo_id) AS users
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN (
        'view_item',
        'add_to_cart',
        'view_cart',
        'begin_checkout',
        'add_shipping_info',
        'add_payment_info',
        'purchase'
    )
GROUP BY
    event_name
ORDER BY
    users DESC;


-- ------------------------------------------------------------
-- 7. Basic purchase metrics
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS purchase_events,
    COUNT(DISTINCT user_pseudo_id) AS purchasers,
    COUNT(DISTINCT ecommerce.transaction_id) AS transactions,
    ROUND(SUM(ecommerce.purchase_revenue), 2) AS total_revenue,
    ROUND(AVG(ecommerce.purchase_revenue), 2) AS avg_purchase_revenue
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name = 'purchase';
