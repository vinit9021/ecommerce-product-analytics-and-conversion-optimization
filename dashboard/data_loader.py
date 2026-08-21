from __future__ import annotations

import os

import pandas as pd
import streamlit as st
from google.cloud import bigquery

PROJECT_ID = os.getenv(
    "GOOGLE_CLOUD_PROJECT",
    "loyal-coyote-484615-e7",
)

DATASET_ID = os.getenv(
    "ECOMMERCE_ANALYTICS_DATASET",
    "ecommerce_analytics",
)


TABLES = {
    "overview": "dashboard_overview",
    "daily": "daily_kpis",
    "funnel": "funnel_summary",
    "device": "funnel_by_device",
    "user_type": "funnel_by_user_type",
    "channel": "funnel_by_channel",
    "opportunities": "dashboard_product_opportunities",
    "category": "category_performance",
    "cohort": "cohort_retention",
    "experiment": "dashboard_experiment_summary",
}


@st.cache_resource
def get_bigquery_client() -> bigquery.Client:
    """Create and cache an authenticated BigQuery client."""

    return bigquery.Client(
        project=PROJECT_ID
    )


@st.cache_data(
    ttl=1800,
    show_spinner=False,
)
def load_table(
    table_name: str,
) -> pd.DataFrame:
    """Load one approved dashboard view."""

    if table_name not in TABLES.values():
        raise ValueError(
            f"Unsupported dashboard table: {table_name}"
        )

    sql = (
        "SELECT * FROM "
        f"`{PROJECT_ID}.{DATASET_ID}.{table_name}`"
    )

    return (
        get_bigquery_client()
        .query(sql)
        .to_dataframe(
            create_bqstorage_client=False
        )
    )


def load_dashboard_data() -> dict[str, pd.DataFrame]:
    """Load every compact view used by the dashboard."""

    return {
        key: load_table(table_name)
        for key, table_name in TABLES.items()
    }


def clear_dashboard_cache() -> None:
    """Clear Streamlit data and BigQuery-client caches."""

    load_table.clear()
    get_bigquery_client.clear()
