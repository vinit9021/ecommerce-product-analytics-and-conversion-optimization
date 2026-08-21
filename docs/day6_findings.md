# Day 6 - Interactive Product Analytics Dashboard

## Objective

Convert the analytical outputs from BigQuery, SQL, and Python into an
interactive decision-oriented product analytics dashboard.

## Dashboard Architecture

Google GA4 public e-commerce data
→ BigQuery analytical views
→ Python / Pandas
→ Plotly
→ Streamlit

## Dashboard Sections

### Executive Overview

Surfaces the core business health metrics:

- 270,154 users
- 360,129 sessions
- 4,848 purchasing sessions
- 1.35% recorded session purchase rate
- 362,165 recorded revenue
- 1.01 revenue per session

Daily trends show traffic, revenue, and purchase-rate movement across the
analysis window.

### Funnel & Segments

The strict ordered funnel identifies Product View → Add to Cart as the
largest major post-discovery bottleneck.

Key segmentation insight:

- New-user strict View-to-Purchase: 1.36%
- Returning-user strict View-to-Purchase: 4.23%

Returning users convert at roughly 3.1x the new-user rate.

Device performance is comparatively similar, suggesting the main conversion
problem is not isolated to mobile.

### Product Opportunities

The portfolio View-to-Cart benchmark is 24.67%.

The dashboard ranks high-volume underperforming products and supports
25%, 50%, and 100% benchmark-gap closure scenarios.

For the top five opportunities, the 50% planning scenario estimates:

- approximately 403 incremental purchases
- approximately $28.9K incremental revenue

These estimates are directional planning scenarios rather than causal
forecasts.

### Retention & Experiment

Short-term cohort analysis shows:

- Nov 2020 M1 retention: 5.84%
- Nov 2020 M2 retention: 1.52%
- Dec 2020 M1 retention: 2.52%

The dashboard also includes a clearly labelled synthetic A/B experiment
demonstration because the public GA4 data contains no true experiment
assignment.

Synthetic experiment result:

- Control: 17.03%
- Treatment: 18.73%
- Absolute lift: +1.70 pp
- Relative lift: +9.98%
- p-value: 0.0052
- Required sample: 7,944 users per variant

## Product Decision

Prioritize purchase-confidence and CTA improvements for high-volume
underperforming product detail pages, particularly for new users, and validate
the intervention through a properly randomized experiment before rollout.
