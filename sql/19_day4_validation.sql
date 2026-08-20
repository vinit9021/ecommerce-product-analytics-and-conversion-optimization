-- ============================================================
-- Day 4 Validation Queries
-- ============================================================


-- 1. Item-layer quality

SELECT
    COUNT(*) AS item_event_rows,

    COUNT(DISTINCT item_name)
        AS unique_item_names,

    COUNT(DISTINCT NULLIF(item_id, ''))
        AS unique_item_ids

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.item_events`;


-- 2. Highest-volume products

SELECT
    item_name,
    item_category,
    product_view_sessions,
    add_to_cart_sessions,
    purchase_sessions,
    view_to_cart_pct,
    view_to_purchase_pct,
    purchased_merchandise_value

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.product_performance`

WHERE
    product_view_sessions >= 100

ORDER BY
    product_view_sessions DESC

LIMIT 20;


-- 3. Highest product opportunities

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.product_opportunities`

ORDER BY
    estimated_incremental_cart_sessions DESC

LIMIT 20;


-- 4. Category performance

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.category_performance`

ORDER BY
    product_view_sessions DESC;


-- 5. Cohort retention

SELECT *
FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.cohort_retention`

ORDER BY
    cohort_month,
    month_number;
