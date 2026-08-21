from __future__ import annotations

import pandas as pd
import plotly.graph_objects as go


def _finish(
    fig: go.Figure,
    title: str,
    height: int = 360,
) -> go.Figure:
    fig.update_layout(
        title=title,
        template="plotly_white",
        height=height,
        margin={
            "l": 20,
            "r": 20,
            "t": 60,
            "b": 20,
        },
        legend_title_text="",
    )

    return fig


def line_chart(
    df: pd.DataFrame,
    x: str,
    y: str,
    title: str,
    y_title: str,
) -> go.Figure:
    fig = go.Figure(
        go.Scatter(
            x=df[x],
            y=df[y],
            mode="lines+markers",
            hovertemplate=(
                "%{x}<br>"
                "%{y:,.2f}"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text=""
    )

    fig.update_yaxes(
        title_text=y_title
    )

    return _finish(
        fig,
        title,
    )


def funnel_chart(
    df: pd.DataFrame,
) -> go.Figure:
    ordered = df.sort_values(
        "stage_order"
    )

    fig = go.Figure(
        go.Funnel(
            y=ordered["stage"],
            x=ordered["sessions"],
            textinfo="value+percent initial",
        )
    )

    return _finish(
        fig,
        "Strict Ordered Funnel",
        height=430,
    )


def step_conversion_chart(
    df: pd.DataFrame,
) -> go.Figure:
    filtered = (
        df.loc[
            df["stage_order"] > 0
        ]
        .sort_values(
            "step_conversion_pct",
            ascending=True,
        )
    )

    fig = go.Figure(
        go.Bar(
            x=filtered[
                "step_conversion_pct"
            ],
            y=filtered["stage"],
            orientation="h",
            text=filtered[
                "step_conversion_pct"
            ],
            texttemplate="%{text:.2f}%",
            hovertemplate=(
                "%{y}: %{x:.2f}%"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text="Conversion (%)"
    )

    fig.update_yaxes(
        title_text=""
    )

    return _finish(
        fig,
        "Step-to-Step Conversion",
        height=430,
    )


def segment_bar(
    df: pd.DataFrame,
    category: str,
    metric: str,
    title: str,
) -> go.Figure:
    ordered = df.sort_values(
        metric,
        ascending=False,
    )

    fig = go.Figure(
        go.Bar(
            x=ordered[category],
            y=ordered[metric],
            text=ordered[metric],
            texttemplate="%{text:.2f}%",
            hovertemplate=(
                "%{x}: %{y:.2f}%"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text=""
    )

    fig.update_yaxes(
        title_text="Conversion (%)"
    )

    return _finish(
        fig,
        title,
    )


def opportunity_bar(
    df: pd.DataFrame,
    revenue_column: str,
    top_n: int,
    title: str,
) -> go.Figure:
    top = (
        df.nlargest(
            top_n,
            revenue_column,
        )
        .sort_values(
            revenue_column,
            ascending=True,
        )
    )

    fig = go.Figure(
        go.Bar(
            x=top[
                revenue_column
            ],
            y=top[
                "item_name"
            ],
            orientation="h",
            text=top[
                revenue_column
            ],
            texttemplate="%{text:,.0f}",
            hovertemplate=(
                "%{y}"
                "<br>%{x:,.2f}"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text=(
            "Estimated incremental revenue"
        )
    )

    fig.update_yaxes(
        title_text=""
    )

    return _finish(
        fig,
        title,
        height=max(
            380,
            42 * top_n,
        ),
    )


def benchmark_chart(
    df: pd.DataFrame,
    top_n: int,
) -> go.Figure:
    top = (
        df.nsmallest(
            top_n,
            "view_to_cart_pct",
        )
        .copy()
    )

    top = top.sort_values(
        "view_to_cart_pct",
        ascending=True,
    )

    fig = go.Figure()

    fig.add_trace(
        go.Bar(
            name="Observed",
            x=top[
                "view_to_cart_pct"
            ],
            y=top[
                "item_name"
            ],
            orientation="h",
            hovertemplate=(
                "%{y}"
                "<br>Observed: %{x:.2f}%"
                "<extra></extra>"
            ),
        )
    )

    fig.add_trace(
        go.Bar(
            name="Portfolio benchmark",
            x=top[
                "benchmark_view_to_cart_pct"
            ],
            y=top[
                "item_name"
            ],
            orientation="h",
            hovertemplate=(
                "%{y}"
                "<br>Benchmark: %{x:.2f}%"
                "<extra></extra>"
            ),
        )
    )

    fig.update_layout(
        barmode="group"
    )

    fig.update_xaxes(
        title_text="View to cart (%)"
    )

    fig.update_yaxes(
        title_text=""
    )

    return _finish(
        fig,
        "Observed Conversion vs Portfolio Benchmark",
        height=max(
            380,
            42 * top_n,
        ),
    )


def category_chart(
    df: pd.DataFrame,
    min_views: int,
    top_n: int,
) -> go.Figure:
    filtered = df.loc[
        df["product_view_sessions"]
        >= min_views
    ].copy()

    top = filtered.nlargest(
        top_n,
        "product_view_sessions",
    )

    top = top.sort_values(
        "view_to_cart_pct",
        ascending=True,
    )

    fig = go.Figure(
        go.Bar(
            x=top[
                "view_to_cart_pct"
            ],
            y=top[
                "item_category"
            ],
            orientation="h",
            text=top[
                "view_to_cart_pct"
            ],
            texttemplate="%{text:.2f}%",
            customdata=top[
                ["product_view_sessions"]
            ],
            hovertemplate=(
                "%{y}"
                "<br>View to cart: %{x:.2f}%"
                "<br>Product-view sessions: "
                "%{customdata[0]:,.0f}"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text="View to cart (%)"
    )

    fig.update_yaxes(
        title_text=""
    )

    return _finish(
        fig,
        "Category View-to-Cart Performance",
        height=430,
    )


def cohort_heatmap(
    df: pd.DataFrame,
) -> go.Figure:
    work = df.copy()

    work["cohort_month"] = pd.to_datetime(
        work["cohort_month"]
    )

    pivot = (
        work.pivot(
            index="cohort_month",
            columns="month_number",
            values="retention_pct",
        )
        .sort_index()
    )

    text = pivot.map(
        lambda value: (
            ""
            if pd.isna(value)
            else f"{value:.2f}%"
        )
    )

    fig = go.Figure(
        go.Heatmap(
            z=pivot.values,

            x=[
                f"M{int(column)}"
                for column
                in pivot.columns
            ],

            y=[
                value.strftime(
                    "%b %Y"
                )
                for value
                in pivot.index
            ],

            text=text.values,

            texttemplate="%{text}",

            hovertemplate=(
                "Cohort: %{y}"
                "<br>Month: %{x}"
                "<br>Retention: %{z:.2f}%"
                "<extra></extra>"
            ),

            colorbar={
                "title": "Retention %",
            },
        )
    )

    fig.update_xaxes(
        title_text=(
            "Months since cohort start"
        )
    )

    fig.update_yaxes(
        title_text=""
    )

    return _finish(
        fig,
        "Monthly Cohort Retention",
        height=360,
    )


def experiment_bar(
    control_rate: float,
    treatment_rate: float,
) -> go.Figure:
    labels = [
        "Control",
        "Treatment",
    ]

    rates = [
        control_rate * 100,
        treatment_rate * 100,
    ]

    fig = go.Figure(
        go.Bar(
            x=labels,
            y=rates,
            text=rates,
            texttemplate="%{text:.2f}%",
            hovertemplate=(
                "%{x}: %{y:.2f}%"
                "<extra></extra>"
            ),
        )
    )

    fig.update_xaxes(
        title_text=""
    )

    fig.update_yaxes(
        title_text="Conversion (%)"
    )

    return _finish(
        fig,
        "Synthetic Experiment Conversion",
        height=340,
    )

