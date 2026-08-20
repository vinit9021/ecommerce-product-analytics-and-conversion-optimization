-- ============================================================
-- Day 4: User Monthly Activity
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.user_month_activity`
AS

WITH monthly_activity AS (

    SELECT
        user_pseudo_id,

        DATE_TRUNC(
            session_date,
            MONTH
        ) AS activity_month,

        COUNT(*) AS sessions,

        SUM(purchased) AS purchasing_sessions,

        SUM(purchase_events) AS purchase_events,

        ROUND(
            SUM(revenue),
            2
        ) AS revenue

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.session_summary`

    GROUP BY
        user_pseudo_id,
        activity_month
),

cohorts AS (

    SELECT
        user_pseudo_id,

        MIN(activity_month)
            AS cohort_month

    FROM
        monthly_activity

    GROUP BY
        user_pseudo_id
)

SELECT
    m.user_pseudo_id,

    c.cohort_month,

    m.activity_month,

    DATE_DIFF(
        m.activity_month,
        c.cohort_month,
        MONTH
    ) AS month_number,

    m.sessions,

    m.purchasing_sessions,

    m.purchase_events,

    m.revenue

FROM
    monthly_activity AS m

JOIN
    cohorts AS c
    USING (user_pseudo_id);
