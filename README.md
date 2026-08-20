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
→ clean event layer
→ session model
→ ordered funnel
→ segmentation
→ product analysis
→ cohort analysis
→ opportunity sizing
→ experimentation
→ Power BI
→ product recommendations

## Primary Funnel

Product View
→ Add to Cart
→ Begin Checkout
→ Shipping Information
→ Payment Information
→ Purchase

## Key Funnel Findings

### Product View → Add to Cart

Only 19.69% of strict product-view sessions progress to cart, making
product-intent formation a major funnel bottleneck.

### New vs Returning

Returning users achieve a 4.23% strict Product View → Purchase conversion
rate compared with 1.36% for new users.

### Device

Desktop and mobile conversion performance is relatively similar, so device
is not currently the primary optimization target.

## Product Analysis

The corrected product model uses normalized product names as canonical keys
because item IDs are inconsistent across GA4 event types.

The portfolio-level product-session View → Cart benchmark is 24.67%.

High-volume products below this benchmark include:

- YouTube Icon Tee Grey
- Google Land & Sea French Terry
- Google Sherpa Zip Hoodie Navy
- YouTube Icon Tee Charcoal

These products represent candidates for deeper opportunity sizing and
experimentation.

## Cohort Analysis

November cohort retention:

- Month 1: 5.84%
- Month 2: 1.52%

December Month-1 retention:

- 2.52%

Returning users convert strongly, but relatively few users become returning
users within the observed period.

## Data Quality

The analytical model includes explicit validation for:

- Session identifiers
- Transaction identifiers
- Revenue reconciliation
- Product identifier consistency

The session model reconciles to:

- 5,692 purchase events
- 362,165 purchase revenue

## Current BigQuery Models

- `events_base`
- `session_summary`
- `daily_kpis`
- `ordered_funnel_sessions`
- `funnel_summary`
- `funnel_by_device`
- `funnel_by_channel`
- `funnel_by_user_type`
- `item_events`
- `product_session_behavior`
- `product_performance`
- `category_performance`
- `product_opportunities`
- `user_month_activity`
- `cohort_retention`

## Next

Day 5 will focus on:

- Business opportunity sizing
- Revenue scenarios
- Python statistical analysis
- A/B experiment design
- Sample-size and significance analysis

## Tech Stack

- Google BigQuery
- SQL
- Python
- Pandas
- SciPy / Statsmodels
- Power BI
- Git / GitHub

## Status

Day 4 complete — product performance, product opportunity ranking, and cohort
retention analysis.
