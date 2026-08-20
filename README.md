# E-commerce Product Analytics & Conversion Optimization

End-to-end Product Analytics case study using event-level behavior from the
Google Analytics 4 public Google Merchandise Store dataset.

## Business Goal

Identify friction across the e-commerce customer journey, quantify major
conversion opportunities, and recommend measurable product improvements.

## Dataset

Google Analytics 4 public e-commerce dataset:

`bigquery-public-data.ga4_obfuscated_sample_ecommerce`

Period:

`2020-11-01 to 2021-01-31`

Scale:

- 4.29M+ behavioral events
- 270K+ users
- 360K+ sessions
- 5,692 purchase events
- 362K+ recorded purchase revenue

## Analytics Architecture

GA4 Public Events
→ BigQuery `events_base`
→ `session_summary`
→ `daily_kpis`
→ Funnel and product analysis
→ Python statistics
→ Power BI
→ Product recommendations

## Primary Funnel

Product View
→ Add to Cart
→ Begin Checkout
→ Shipping Information
→ Payment Information
→ Purchase

## BigQuery Models

### `events_base`

Clean event-level analytical layer.

### `session_summary`

One row per user session containing behavioral funnel indicators,
engagement metrics, and purchase outcomes.

### `daily_kpis`

Daily product-health metrics for trend analysis and dashboarding.

## Data Quality

The session model reconciles exactly with the raw source for:

- 5,692 purchase events
- 362,165 recorded purchase revenue

Transaction IDs contain placeholder and reused values, so purchasing sessions
and purchase events are used as the main conversion measures.

## Planned Analysis

- Conversion funnel
- Funnel segmentation
- Product performance
- Cohort and retention analysis
- Opportunity sizing
- A/B experimentation
- Statistical analysis
- Power BI dashboard
- Product recommendations

## Tech Stack

- Google BigQuery
- SQL
- Python
- Pandas
- SciPy / Statsmodels
- Power BI
- Git / GitHub

## Status

Day 2 complete — analytics foundation, KPI framework, session model,
daily KPI layer, and source-to-model validation.
