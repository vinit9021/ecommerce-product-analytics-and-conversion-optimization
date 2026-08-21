import pandas as pd

from dashboard.charts import (
    cohort_heatmap,
    funnel_chart,
    opportunity_bar,
)


def test_funnel_chart_contains_single_trace():
    frame = pd.DataFrame(
        {
            "stage_order": [
                0,
                1,
                2,
            ],
            "stage": [
                "Session",
                "Product View",
                "Add to Cart",
            ],
            "sessions": [
                100,
                40,
                10,
            ],
        }
    )

    figure = funnel_chart(
        frame
    )

    assert len(
        figure.data
    ) == 1

    assert list(
        figure.data[0]["x"]
    ) == [
        100,
        40,
        10,
    ]


def test_opportunity_bar_respects_top_n():
    frame = pd.DataFrame(
        {
            "item_name": [
                "A",
                "B",
                "C",
            ],
            "incremental_revenue_50pct": [
                100.0,
                300.0,
                200.0,
            ],
        }
    )

    figure = opportunity_bar(
        frame,
        "incremental_revenue_50pct",
        2,
        "Opportunity",
    )

    assert len(
        figure.data[0]["x"]
    ) == 2


def test_cohort_heatmap_builds_month_columns():
    frame = pd.DataFrame(
        {
            "cohort_month": [
                "2020-11-01",
                "2020-11-01",
                "2020-12-01",
            ],
            "month_number": [
                0,
                1,
                0,
            ],
            "retention_pct": [
                100.0,
                5.84,
                100.0,
            ],
        }
    )

    figure = cohort_heatmap(
        frame
    )

    assert list(
        figure.data[0]["x"]
    ) == [
        "M0",
        "M1",
    ]
