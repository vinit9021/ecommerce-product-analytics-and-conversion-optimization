-- ============================================================
-- Day 4: Monthly Cohort Retention
-- ============================================================

CREATE OR REPLACE VIEW
    `loyal-coyote-484615-e7.ecommerce_analytics.cohort_retention`
AS

WITH cohort_activity AS (

    SELECT
        cohort_month,

        month_number,

        COUNT(DISTINCT user_pseudo_id)
            AS active_users,

        SUM(sessions)
            AS sessions,

        SUM(purchasing_sessions)
            AS purchasing_sessions,

        ROUND(
            SUM(revenue),
            2
        ) AS revenue

    FROM
        `loyal-coyote-484615-e7.ecommerce_analytics.user_month_activity`

    GROUP BY
        cohort_month,
        month_number
),

with_size AS (

    SELECT
        *,

        MAX(
            IF(
                month_number = 0,
                active_users,
                NULL
            )
        ) OVER (
            PARTITION BY cohort_month
        ) AS cohort_size

    FROM
        cohort_activity
)

SELECT
    cohort_month,

    month_number,

    cohort_size,

    active_users,

    ROUND(
        100 * SAFE_DIVIDE(
            active_users,
            cohort_size
        ),
        2
    ) AS retention_pct,

    sessions,

    purchasing_sessions,

    revenue

FROM
    with_size

ORDER BY
    cohort_month,
    month_number;
