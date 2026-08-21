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
→ Clean Event Layer
→ Session Model
→ Ordered Funnel
→ Segmentation
→ Product Analysis
→ Cohort Analysis
→ Opportunity Sizing
→ Experimentation
→ Power BI
→ Product Recommendations

## Primary Funnel

Product View
→ Add to Cart
→ Begin Checkout
→ Shipping Information
→ Payment Information
→ Purchase

## Key Funnel Findings

### Product View → Add to Cart

Only 19.69% of strict product-view sessions progress to cart.

### New vs Returning

Returning users achieve a 4.23% strict Product View → Purchase conversion
rate compared with 1.36% for new users.

New-user View → Cart is 17.03%, compared with 24.90% for returning users.

### Device

Desktop and mobile performance are relatively similar, so device is not
currently treated as the primary optimization target.

## Product Analytics

The product portfolio View → Cart benchmark is 24.67%.

High-volume below-benchmark products include:

- YouTube Icon Tee Grey
- Google Land & Sea French Terry
- Google Sherpa Zip Hoodie Navy
- YouTube Icon Tee Charcoal
- Google Heather Green Speckled products

## Cohort Retention

November cohort:

- Month 1 retention: 5.84%
- Month 2 retention: 1.52%

December cohort:

- Month 1 retention: 2.52%

Returning users convert strongly, but relatively few users become returning
users within the available observation window.

## Business Opportunity

Observed post-cart purchase rate:

18.68%

Average revenue per converted cart session:

71.63

For the top five product opportunities, estimated impact is:

| Scenario | Incremental Purchases | Incremental Revenue |
|---|---:|---:|
| 25% gap closure | 201.5 | 14,437.20 |
| 50% gap closure | 403.1 | 28,874.40 |
| 100% gap closure | 806.2 | 57,748.81 |

These values are directional planning scenarios rather than causal forecasts.

## Experimentation

Proposed experiment:

Improve product-page purchase confidence for new users viewing high-volume,
below-benchmark products.

Primary metric:

View → Add-to-Cart conversion.

Baseline:

17.03%

Target:

18.73%

Required sample:

7,944 users per variant.

The repository also includes a reproducible synthetic two-proportion
experiment analysis demonstrating:

- Statistical significance testing
- Confidence intervals
- Absolute lift
- Relative lift
- Power-based sample-size planning

Synthetic demonstration result:

- Absolute lift: +1.70 percentage points
- Relative lift: +9.98%
- p-value: 0.0052
- 95% CI: +0.51 to +2.89 percentage points

The synthetic result is not presented as observed product impact.

## Data Quality

The analysis explicitly validates:

- Session identifiers
- Transaction identifiers
- Revenue reconciliation
- Product identifier consistency

Transaction IDs and raw item IDs contain obfuscated/inconsistent values, so
the analytical model uses more reliable metrics and canonical product names.

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
- `business_opportunity_sizing`

## Python Analytics

- Statistical power analysis
- A/B test sample-size calculation
- Two-proportion z-test
- Confidence intervals
- Experiment decision logic
- Automated tests

## Next

Day 6:

- Export dashboard-ready datasets
- Build Power BI model
- Executive overview
- Funnel dashboard
- Product opportunity dashboard
- Retention dashboard
- Experiment dashboard

## Tech Stack

- Google BigQuery
- SQL
- Python
- Pandas
- NumPy
- SciPy
- Statsmodels
- Power BI
- Git / GitHub

## Status

Day 5 complete — business opportunity sizing and experimentation framework.
