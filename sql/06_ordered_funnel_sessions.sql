-- ============================================================
-- Day 3: Ordered Session Funnel
-- Grain: one row per user-session
--
-- A funnel step is reached only when it occurs after the
-- previous step within the same session.
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.ordered_funnel_sessions`
AS

WITH relevant_events AS (

    SELECT
        session_key,
        event_timestamp,
        event_name

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.events_base`

    WHERE
        event_name IN (
            'view_item',
            'add_to_cart',
            'begin_checkout',
            'add_shipping_info',
            'add_payment_info',
            'purchase'
        )
),

-- Step 1: Product view
view_step AS (

    SELECT
        session_key,
        MIN(event_timestamp) AS view_item_ts

    FROM
        relevant_events

    WHERE
        event_name = 'view_item'

    GROUP BY
        session_key
),

-- Step 2: Add to cart AFTER product view
cart_step AS (

    SELECT
        v.session_key,
        MIN(e.event_timestamp) AS add_to_cart_ts

    FROM
        view_step AS v

    JOIN
        relevant_events AS e
        ON e.session_key = v.session_key
        AND e.event_name = 'add_to_cart'
        AND e.event_timestamp >= v.view_item_ts

    GROUP BY
        v.session_key
),

-- Step 3: Begin checkout AFTER add to cart
checkout_step AS (

    SELECT
        c.session_key,
        MIN(e.event_timestamp) AS begin_checkout_ts

    FROM
        cart_step AS c

    JOIN
        relevant_events AS e
        ON e.session_key = c.session_key
        AND e.event_name = 'begin_checkout'
        AND e.event_timestamp >= c.add_to_cart_ts

    GROUP BY
        c.session_key
),

-- Step 4: Shipping AFTER checkout
shipping_step AS (

    SELECT
        c.session_key,
        MIN(e.event_timestamp) AS shipping_ts

    FROM
        checkout_step AS c

    JOIN
        relevant_events AS e
        ON e.session_key = c.session_key
        AND e.event_name = 'add_shipping_info'
        AND e.event_timestamp >= c.begin_checkout_ts

    GROUP BY
        c.session_key
),

-- Step 5: Payment AFTER shipping
payment_step AS (

    SELECT
        s.session_key,
        MIN(e.event_timestamp) AS payment_ts

    FROM
        shipping_step AS s

    JOIN
        relevant_events AS e
        ON e.session_key = s.session_key
        AND e.event_name = 'add_payment_info'
        AND e.event_timestamp >= s.shipping_ts

    GROUP BY
        s.session_key
),

-- Step 6: Purchase AFTER payment
purchase_step AS (

    SELECT
        p.session_key,
        MIN(e.event_timestamp) AS purchase_ts

    FROM
        payment_step AS p

    JOIN
        relevant_events AS e
        ON e.session_key = p.session_key
        AND e.event_name = 'purchase'
        AND e.event_timestamp >= p.payment_ts

    GROUP BY
        p.session_key
),

-- GA4 first_visit identifies new-user sessions.
session_type AS (

    SELECT
        session_key,

        IF(
            COUNTIF(event_name = 'first_visit') > 0,
            'new',
            'returning'
        ) AS user_type

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.events_base`

    GROUP BY
        session_key
)

SELECT
    ss.session_key,

    ss.user_pseudo_id,

    ss.ga_session_id,

    ss.session_date,

    ss.session_start_time,

    ss.device_category,

    ss.country,

    ss.region,

    ss.first_user_source,

    ss.first_user_medium,

    COALESCE(st.user_type, 'unknown') AS user_type,

    -- Ordered timestamps
    v.view_item_ts,

    c.add_to_cart_ts,

    co.begin_checkout_ts,

    sh.shipping_ts,

    pa.payment_ts,

    pu.purchase_ts,

    -- Strict ordered-funnel indicators
    IF(v.view_item_ts IS NOT NULL, 1, 0)
        AS step_1_view_item,

    IF(c.add_to_cart_ts IS NOT NULL, 1, 0)
        AS step_2_add_to_cart,

    IF(co.begin_checkout_ts IS NOT NULL, 1, 0)
        AS step_3_begin_checkout,

    IF(sh.shipping_ts IS NOT NULL, 1, 0)
        AS step_4_shipping,

    IF(pa.payment_ts IS NOT NULL, 1, 0)
        AS step_5_payment,

    IF(pu.purchase_ts IS NOT NULL, 1, 0)
        AS step_6_purchase,

    -- Recorded purchase regardless of strict funnel completion
    ss.purchased AS recorded_purchase_session,

    ss.purchase_events,

    ss.revenue

FROM
    `loyal-coyote-484615-e7.ecommerce_analytics.session_summary`
        AS ss

LEFT JOIN view_step AS v
    USING (session_key)

LEFT JOIN cart_step AS c
    USING (session_key)

LEFT JOIN checkout_step AS co
    USING (session_key)

LEFT JOIN shipping_step AS sh
    USING (session_key)

LEFT JOIN payment_step AS pa
    USING (session_key)

LEFT JOIN purchase_step AS pu
    USING (session_key)

LEFT JOIN session_type AS st
    USING (session_key);
