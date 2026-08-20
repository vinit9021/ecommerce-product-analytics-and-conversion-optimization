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
→ `events_base`
→ `session_summary`
→ `daily_kpis`
→ ordered funnel
→ segmentation
→ product analysis
→ Python statistics
→ Power BI
→ product recommendations

## Primary Funnel

Product View
→ Add to Cart
→ Begin Checkout
→ Shipping Information
→ Payment Information
→ Purchase

## Current BigQuery Models

- `events_base`
- `session_summary`
- `daily_kpis`
- `ordered_funnel_sessions`
- `funnel_summary`
- `funnel_by_device`
- `funnel_by_channel`
- `funnel_by_user_type`

## Key Funnel Findings

### Product View → Add to Cart

Only 19.69% of product-view sessions progress to cart, making this the
largest post-discovery conversion bottleneck.

### New vs Returning Users

Returning users achieve a 4.23% Product View → Purchase conversion rate,
compared with 1.36% for new users.

### Device Performance

Desktop and mobile funnel performance is relatively similar, so mobile is
not currently treated as the primary conversion problem.

### Funnel Instrumentation

There are 4,848 recorded purchasing sessions, while 1,792 sessions complete
the full strict tracked funnel.

Strict-funnel conversion and overall purchase activity are therefore analyzed
as separate metrics.

## Data Quality

The session model reconciles exactly with the raw source for:

- 5,692 purchase events
- 362,165 recorded purchase revenue

Transaction identifiers contain placeholder and reused values, so purchasing
sessions and purchase events are used as the primary conversion measures.

## Next Analysis

- Product and category performance
- Product View → Cart diagnostics
- New vs returning behavior
- Cohort and retention analysis
- Opportunity sizing
- Experimentation
- Power BI dashboard

## Tech Stack

- Google BigQuery
- SQL
- Python
- Pandas
- SciPy / Statsmodels
- Power BI
- Git / GitHub

## Status

Day 3 complete — ordered conversion funnel and segmentation analysis.
