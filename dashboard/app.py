from __future__ import annotations

from datetime import date

import pandas as pd
import streamlit as st
from google.auth.exceptions import (
    DefaultCredentialsError,
)

from dashboard.charts import (
    benchmark_chart,
    category_chart,
    cohort_heatmap,
    experiment_bar,
    funnel_chart,
    line_chart,
    opportunity_bar,
    segment_bar,
    step_conversion_chart,
)
from dashboard.data_loader import (
    DATASET_ID,
    PROJECT_ID,
    clear_dashboard_cache,
    load_dashboard_data,
)

st.set_page_config(
    page_title=(
        "E-commerce Product Analytics"
    ),
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded",
)


st.markdown(
    """
    <style>

    .block-container {
        padding-top: 1.4rem;
        padding-bottom: 2rem;
    }

    [data-testid="stMetric"] {
        border:
            1px solid
            rgba(128,128,128,0.22);

        border-radius: 12px;

        padding:
            14px 16px;

        background:
            rgba(250,250,250,0.75);
    }

    [data-testid="stMetricLabel"] {
        font-weight: 600;
    }

    div[data-testid="stDataFrame"] {
        border-radius: 10px;
    }

    </style>
    """,
    unsafe_allow_html=True,
)


def _int(
    value: object,
) -> int:
    return round(
        float(value)
    )


def _number(
    value: object,
    digits: int = 2,
) -> str:
    return (
        f"{float(value):,.{digits}f}"
    )


@st.dialog(
    "BigQuery authentication required"
)
def auth_help() -> None:
    st.write(
        "Authenticate Python with the "
        "same Google account used for BigQuery."
    )

    st.code(
        "gcloud auth application-default login"
    )

    st.code(
        f"gcloud config set project "
        f"{PROJECT_ID}"
    )


st.title(
    "E-commerce Product Analytics "
    "& Funnel Optimization"
)

st.caption(
    "Google Merchandise Store | "
    "Nov 2020 - Jan 2021 | "
    "BigQuery + Python + Streamlit"
)


with st.sidebar:
    st.header(
        "Dashboard controls"
    )

    top_n = st.slider(
        "Products shown",
        min_value=5,
        max_value=15,
        value=8,
        step=1,
    )

    scenario = st.selectbox(
        "Opportunity scenario",
        options=[
            25,
            50,
            100,
        ],
        index=1,
        format_func=(
            lambda value:
            f"{value}% gap closure"
        ),
    )

    min_channel_views = (
        st.number_input(
            "Minimum channel product views",
            min_value=0,
            value=100,
            step=100,
        )
    )

    min_category_views = (
        st.number_input(
            "Minimum category product views",
            min_value=0,
            value=10000,
            step=5000,
        )
    )

    if st.button(
        "Refresh BigQuery data"
    ):
        clear_dashboard_cache()
        st.rerun()

    st.divider()

    st.caption(
        f"Project: {PROJECT_ID}"
    )

    st.caption(
        f"Dataset: {DATASET_ID}"
    )

    st.caption(
        "Dashboard queries are cached "
        "for 30 minutes."
    )


try:
    with st.spinner(
        "Loading dashboard data "
        "from BigQuery..."
    ):
        data = (
            load_dashboard_data()
        )

except DefaultCredentialsError:
    st.error(
        "Google Application Default "
        "Credentials were not found."
    )

    auth_help()

    st.stop()

except (ValueError, RuntimeError) as exc:
    st.error(
        "The dashboard could not load "
        "data from BigQuery."
    )

    st.exception(
        exc
    )

    st.stop()


overview = data["overview"].iloc[0]

daily = data[
    "daily"
].copy()

funnel = data[
    "funnel"
].copy()

device = data[
    "device"
].copy()

user_type = data[
    "user_type"
].copy()

channel = data[
    "channel"
].copy()

opportunities = data[
    "opportunities"
].copy()

category = data[
    "category"
].copy()

cohort = data[
    "cohort"
].copy()

experiment = data[
    "experiment"
].iloc[0]


daily[
    "session_date"
] = pd.to_datetime(
    daily["session_date"]
)


min_date = (
    daily["session_date"]
    .min()
    .date()
)

max_date = (
    daily["session_date"]
    .max()
    .date()
)


with st.sidebar:
    date_range = st.date_input(
        "Daily trend date range",
        value=(
            min_date,
            max_date,
        ),
        min_value=min_date,
        max_value=max_date,
    )


if (
    isinstance(
        date_range,
        tuple,
    )
    and len(date_range) == 2
):
    start_date, end_date = (
        date_range
    )

else:
    start_date = min_date
    end_date = max_date


if (
    not isinstance(
        start_date,
        date,
    )
    or not isinstance(
        end_date,
        date,
    )
):
    start_date = min_date
    end_date = max_date


mask = (
    daily[
        "session_date"
    ].dt.date >= start_date
) & (
    daily[
        "session_date"
    ].dt.date <= end_date
)


daily_filtered = (
    daily.loc[mask]
    .sort_values(
        "session_date"
    )
)


(
    exec_tab,
    funnel_tab,
    product_tab,
    retention_tab,
) = st.tabs(
    [
        "Executive Overview",
        "Funnel & Segments",
        "Product Opportunities",
        "Retention & Experiment",
    ]
)


# ============================================================
# TAB 1 — EXECUTIVE OVERVIEW
# ============================================================

with exec_tab:
    st.subheader(
        "Executive Overview"
    )

    (
        k1,
        k2,
        k3,
        k4,
        k5,
        k6,
    ) = st.columns(6)

    k1.metric(
        "Users",
        f"{_int(overview['users']):,}",
    )

    k2.metric(
        "Sessions",
        f"{_int(overview['sessions']):,}",
    )

    k3.metric(
        "Purchasing Sessions",
        (
            f"{_int(
                overview[
                    'purchasing_sessions'
                ]
            ):,}"
        ),
    )

    k4.metric(
        "Purchase Rate",
        (
            f"{float(
                overview[
                    'recorded_session_'
                    'purchase_rate_pct'
                ]
            ):.2f}%"
        ),
    )

    k5.metric(
        "Recorded Revenue",
        _number(
            overview[
                "revenue"
            ],
            0,
        ),
    )

    k6.metric(
        "Revenue / Session",
        _number(
            overview[
                "revenue_per_session"
            ],
            2,
        ),
    )


    left, right = st.columns(2)

    with left:
        st.plotly_chart(
            line_chart(
                daily_filtered,
                "session_date",
                "sessions",
                "Daily Sessions",
                "Sessions",
            ),
            use_container_width=True,
        )

    with right:
        st.plotly_chart(
            line_chart(
                daily_filtered,
                "session_date",
                "revenue",
                "Daily Recorded Revenue",
                "Revenue",
            ),
            use_container_width=True,
        )


    st.plotly_chart(
        line_chart(
            daily_filtered,
            "session_date",
            "session_purchase_rate_pct",
            "Daily Session Purchase Rate",
            "Purchase rate (%)",
        ),
        use_container_width=True,
    )


    st.info(
        "Key insight: Product View to "
        "Add to Cart is the largest major "
        "post-discovery bottleneck, with "
        "an 80.31% strict-funnel drop-off."
    )


# ============================================================
# TAB 2 — FUNNEL & SEGMENTS
# ============================================================

with funnel_tab:
    st.subheader(
        "Funnel & Segments"
    )

    left, right = st.columns(2)

    with left:
        st.plotly_chart(
            funnel_chart(
                funnel
            ),
            use_container_width=True,
        )

    with right:
        st.plotly_chart(
            step_conversion_chart(
                funnel
            ),
            use_container_width=True,
        )


    left, right = st.columns(2)

    with left:
        st.plotly_chart(
            segment_bar(
                device,
                "device_category",
                "view_to_purchase_pct",
                "View-to-Purchase by Device",
            ),
            use_container_width=True,
        )

    with right:
        st.plotly_chart(
            segment_bar(
                user_type,
                "user_type",
                "view_to_purchase_pct",
                (
                    "View-to-Purchase: "
                    "New vs Returning"
                ),
            ),
            use_container_width=True,
        )


    st.markdown(
        "#### First-user acquisition quality"
    )


    channel_filtered = (
        channel.loc[
            channel[
                "product_view_sessions"
            ] >= min_channel_views
        ]
        .sort_values(
            "product_view_sessions",
            ascending=False,
        )
    )


    st.dataframe(
        channel_filtered[
            [
                "first_user_source",
                "first_user_medium",
                "product_view_sessions",
                "view_to_cart_pct",
                "view_to_purchase_pct",
                "session_to_purchase_pct",
            ]
        ],

        use_container_width=True,

        hide_index=True,

        column_config={
            "product_view_sessions":
                st.column_config.NumberColumn(
                    "Product Views",
                    format="%d",
                ),

            "view_to_cart_pct":
                st.column_config.NumberColumn(
                    "View to Cart",
                    format="%.2f%%",
                ),

            "view_to_purchase_pct":
                st.column_config.NumberColumn(
                    "View to Purchase",
                    format="%.2f%%",
                ),

            "session_to_purchase_pct":
                st.column_config.NumberColumn(
                    "Session to Purchase",
                    format="%.2f%%",
                ),
        },
    )


    st.info(
        "Returning users reach 4.23% "
        "strict View-to-Purchase conversion "
        "versus 1.36% for new users, while "
        "mobile and desktop performance is "
        "comparatively similar."
    )


# ============================================================
# TAB 3 — PRODUCT OPPORTUNITIES
# ============================================================

with product_tab:
    st.subheader(
        "Product Opportunities"
    )


    revenue_column = (
        f"incremental_revenue_"
        f"{scenario}pct"
    )

    purchases_column = (
        f"incremental_purchases_"
        f"{scenario}pct"
    )


    top_five = (
        opportunities.nlargest(
            5,
            revenue_column,
        )
    )


    p1, p2, p3 = (
        st.columns(3)
    )


    p1.metric(
        "Portfolio View-to-Cart Benchmark",
        "24.67%",
    )


    p2.metric(
        (
            f"Top-5 Purchases "
            f"({scenario}% scenario)"
        ),
        _number(
            top_five[
                purchases_column
            ].sum(),
            1,
        ),
    )


    p3.metric(
        (
            f"Top-5 Revenue "
            f"({scenario}% scenario)"
        ),
        _number(
            top_five[
                revenue_column
            ].sum(),
            2,
        ),
    )


    left, right = (
        st.columns(2)
    )


    with left:
        st.plotly_chart(
            opportunity_bar(
                opportunities,
                revenue_column,
                top_n,
                (
                    "Estimated Revenue "
                    f"Opportunity - "
                    f"{scenario}% Gap Closure"
                ),
            ),
            use_container_width=True,
        )


    with right:
        st.plotly_chart(
            benchmark_chart(
                opportunities,
                top_n,
            ),
            use_container_width=True,
        )


    st.plotly_chart(
        category_chart(
            category,
            min_views=int(
                min_category_views
            ),
            top_n=10,
        ),
        use_container_width=True,
    )


    table_columns = [
        "opportunity_rank",
        "item_name",
        "product_view_sessions",
        "view_to_cart_pct",
        "conversion_gap_pct_points",
        purchases_column,
        revenue_column,
    ]


    st.dataframe(
        opportunities[
            table_columns
        ].head(
            top_n
        ),

        use_container_width=True,

        hide_index=True,

        column_config={
            "opportunity_rank":
                "Rank",

            "item_name":
                "Product",

            "product_view_sessions":
                st.column_config.NumberColumn(
                    "Product Views",
                    format="%d",
                ),

            "view_to_cart_pct":
                st.column_config.NumberColumn(
                    "View to Cart",
                    format="%.2f%%",
                ),

            "conversion_gap_pct_points":
                st.column_config.NumberColumn(
                    "Gap vs Benchmark",
                    format="%.2f pp",
                ),

            purchases_column:
                st.column_config.NumberColumn(
                    "Est. Incremental Purchases",
                    format="%.1f",
                ),

            revenue_column:
                st.column_config.NumberColumn(
                    "Est. Incremental Revenue",
                    format="%.2f",
                ),
        },
    )


    st.warning(
        "Opportunity values are directional "
        "planning scenarios based on observed "
        "behavior. They are not causal forecasts."
    )


# ============================================================
# TAB 4 — RETENTION & EXPERIMENT
# ============================================================

with retention_tab:
    st.subheader(
        "Retention & Experiment"
    )


    left, right = (
        st.columns(
            [
                1.3,
                1,
            ]
        )
    )


    with left:
        st.plotly_chart(
            cohort_heatmap(
                cohort
            ),
            use_container_width=True,
        )


    with right:
        month_one = (
            cohort.loc[
                cohort[
                    "month_number"
                ] == 1
            ]
            .copy()
        )

        if not month_one.empty:
            month_one[
                "cohort_month"
            ] = pd.to_datetime(
                month_one[
                    "cohort_month"
                ]
            ).dt.strftime(
                "%b %Y"
            )

            st.plotly_chart(
                segment_bar(
                    month_one,
                    "cohort_month",
                    "retention_pct",
                    "Month-1 Retention",
                ),
                use_container_width=True,
            )


    st.warning(
        "SYNTHETIC EXPERIMENT DEMONSTRATION: "
        "the public GA4 dataset does not "
        "contain real experiment assignment "
        "data. The results below demonstrate "
        "experimentation methodology only."
    )


    (
        e1,
        e2,
        e3,
        e4,
        e5,
    ) = st.columns(5)


    e1.metric(
        "Control",
        (
            f"{float(
                experiment[
                    'control_conversion_rate'
                ]
            ):.2%}"
        ),
    )


    e2.metric(
        "Treatment",
        (
            f"{float(
                experiment[
                    'treatment_conversion_rate'
                ]
            ):.2%}"
        ),
    )


    e3.metric(
        "Absolute Lift",
        (
            f"{float(
                experiment[
                    'absolute_lift'
                ]
            ) * 100:.2f} pp"
        ),
    )


    e4.metric(
        "Relative Lift",
        (
            f"{float(
                experiment[
                    'relative_lift'
                ]
            ):.2%}"
        ),
    )


    e5.metric(
        "p-value",
        (
            f"{float(
                experiment[
                    'p_value'
                ]
            ):.4f}"
        ),
    )


    left, right = (
        st.columns(
            [
                1.1,
                1,
            ]
        )
    )


    with left:
        st.plotly_chart(
            experiment_bar(
                float(
                    experiment[
                        "control_conversion_rate"
                    ]
                ),

                float(
                    experiment[
                        "treatment_conversion_rate"
                    ]
                ),
            ),

            use_container_width=True,
        )


    with right:
        st.markdown(
            "#### Experiment decision framework"
        )

        st.write(
            "Required sample per variant: "
            f"**{_int(
                experiment[
                    'sample_size_per_variant'
                ]
            ):,}**"
        )

        st.write(
            "Total planned sample: "
            f"**{_int(
                experiment[
                    'total_sample_size'
                ]
            ):,}**"
        )

        st.write(
            "95% CI for absolute lift: "
            f"**{float(
                experiment[
                    'confidence_interval_low'
                ]
            ) * 100:.2f} to "
            f"{float(
                experiment[
                    'confidence_interval_high'
                ]
            ) * 100:.2f} pp**"
        )

        st.write(
            "Statistical result: "
            f"**{experiment[
                'statistical_result'
            ]}**"
        )

        st.caption(
            "A real ship decision would also "
            "require satisfactory guardrail "
            "metrics and meaningful business "
            "impact."
        )


st.divider()


st.caption(
    "Portfolio case study. Opportunity estimates "
    "are directional; synthetic experiment results "
    "are explicitly labelled and are not observed "
    "product impact."
)

