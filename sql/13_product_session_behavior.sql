-- ============================================================
-- Day 4: Product behavior within a session
-- Grain: one canonical product per viewing session
--
-- Product identity uses normalized item_name because diagnostics
-- showed that item_id is not stable across GA4 event types in
-- the obfuscated public dataset.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.product_session_behavior`
AS

WITH canonical_events AS (

    SELECT
        session_key,

        user_pseudo_id,

        event_timestamp,

        event_name,

        LOWER(
            TRIM(item_name)
        ) AS product_key,

        item_name,

        NULLIF(
            TRIM(item_category),
            ''
        ) AS item_category,

        quantity,

        merchandise_value

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.item_events`

    WHERE
        item_name IS NOT NULL
        AND TRIM(item_name) != ''
        AND LOWER(TRIM(item_name)) != '(not set)'
),

-- Product must first appear in a product-view event.
view_step AS (

    SELECT
        session_key,

        user_pseudo_id,

        product_key,

        ARRAY_AGG(
            item_name
            ORDER BY event_timestamp
            LIMIT 1
        )[SAFE_OFFSET(0)] AS item_name,

        ARRAY_AGG(
            item_category
            IGNORE NULLS
            ORDER BY event_timestamp
            LIMIT 1
        )[SAFE_OFFSET(0)] AS item_category,

        MIN(event_timestamp) AS first_view_ts

    FROM
        canonical_events

    WHERE
        event_name = 'view_item'

    GROUP BY
        session_key,
        user_pseudo_id,
        product_key
),

-- First cart event occurring after the product was viewed.
cart_step AS (

    SELECT
        v.session_key,

        v.product_key,

        MIN(e.event_timestamp)
            AS first_cart_ts

    FROM
        view_step AS v

    JOIN
        canonical_events AS e
        ON e.session_key = v.session_key
        AND e.product_key = v.product_key
        AND e.event_name = 'add_to_cart'
        AND e.event_timestamp >= v.first_view_ts

    GROUP BY
        v.session_key,
        v.product_key
),

-- First checkout event after that product reached cart.
checkout_step AS (

    SELECT
        c.session_key,

        c.product_key,

        MIN(e.event_timestamp)
            AS first_checkout_ts

    FROM
        cart_step AS c

    JOIN
        canonical_events AS e
        ON e.session_key = c.session_key
        AND e.product_key = c.product_key
        AND e.event_name = 'begin_checkout'
        AND e.event_timestamp >= c.first_cart_ts

    GROUP BY
        c.session_key,
        c.product_key
),

-- Purchase of the same canonical product after it was viewed.
purchase_step AS (

    SELECT
        v.session_key,

        v.product_key,

        MIN(e.event_timestamp)
            AS first_purchase_ts,

        SUM(e.quantity)
            AS purchased_quantity,

        SUM(e.merchandise_value)
            AS purchased_merchandise_value

    FROM
        view_step AS v

    JOIN
        canonical_events AS e
        ON e.session_key = v.session_key
        AND e.product_key = v.product_key
        AND e.event_name = 'purchase'
        AND e.event_timestamp >= v.first_view_ts

    GROUP BY
        v.session_key,
        v.product_key
)

SELECT
    v.session_key,

    v.user_pseudo_id,

    v.product_key,

    v.item_name,

    v.item_category,

    v.first_view_ts,

    c.first_cart_ts,

    co.first_checkout_ts,

    p.first_purchase_ts,

    1 AS viewed_product,

    IF(
        c.first_cart_ts IS NOT NULL,
        1,
        0
    ) AS added_to_cart_after_view,

    IF(
        co.first_checkout_ts IS NOT NULL,
        1,
        0
    ) AS reached_checkout_after_cart,

    IF(
        p.first_purchase_ts IS NOT NULL,
        1,
        0
    ) AS purchased_after_view,

    COALESCE(
        p.purchased_quantity,
        0
    ) AS purchased_quantity,

    ROUND(
        COALESCE(
            p.purchased_merchandise_value,
            0
        ),
        2
    ) AS purchased_merchandise_value

FROM
    view_step AS v

LEFT JOIN cart_step AS c
    USING (
        session_key,
        product_key
    )

LEFT JOIN checkout_step AS co
    USING (
        session_key,
        product_key
    )

LEFT JOIN purchase_step AS p
    USING (
        session_key,
        product_key
    );
