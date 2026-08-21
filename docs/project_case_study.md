# E-commerce Product Analytics Case Study

## Business Problem

Analyze customer behavior across the Google Merchandise Store funnel, identify the largest conversion bottlenecks, prioritize product-level opportunities, quantify potential business impact, and define an experimentation strategy.

## Dataset

- Google GA4 public e-commerce dataset
- Analysis window: Nov 2020 to Jan 2021
- 4.29M+ events
- 270,154 users
- 360,129 sessions

## Analytical Workflow

GA4 events → BigQuery → SQL transformation layer → funnel and segmentation analysis → product and cohort analysis → Python statistics → Streamlit + Plotly dashboard.

## Key Findings

### Funnel

The strict ordered funnel identified Product View → Add to Cart as the largest major post-discovery bottleneck.

- Product views: 77,020 sessions
- Add-to-cart: 15,167 sessions
- View-to-Cart conversion: 19.69%
- Drop-off: 80.31%

### User Segments

Returning users significantly outperformed new users.

- New-user View-to-Purchase: 1.36%
- Returning-user View-to-Purchase: 4.23%
- Returning users converted at approximately 3.1x the new-user rate.

Desktop and mobile conversion were comparatively similar, suggesting that device type was not the primary issue.

### Product Opportunities

The portfolio Product View-to-Cart benchmark was 24.67%. High-volume products performing below this benchmark were ranked by estimated conversion and revenue opportunity.

Under the 50% benchmark-gap closure planning scenario, the top five products represented approximately:

- 403 incremental purchases
- $28.9K incremental revenue

These values are directional business-planning scenarios rather than causal forecasts.

### Retention

Short-term dataset-relative cohort retention remained low.

- Nov 2020 M1 retention: 5.84%
- Nov 2020 M2 retention: 1.52%
- Dec 2020 M1 retention: 2.52%

This supports the broader finding that returning users are valuable but relatively few users return within the available observation window.

### Experimentation

A synthetic experiment was created because the public GA4 dataset contains no real experiment assignment.

- Control conversion: 17.03%
- Treatment conversion: 18.73%
- Absolute lift: +1.70 pp
- Relative lift: +9.98%
- p-value: 0.0052
- Required sample: 7,944 users per variant

The proposed intervention focuses on improving product-page purchase confidence, CTA clarity, delivery expectations, and trust information for high-volume underperforming products.

## Product Recommendation

Prioritize improvements to high-volume product-detail pages, especially for new users, and validate the intervention with a properly randomized experiment before rollout.

## Important Analytical Caveats

- Transaction IDs are unreliable in the obfuscated GA4 sample, so exact order counts are not inferred from them.
- Recorded purchasing sessions and strict ordered-funnel purchases are treated separately.
- Product identity uses normalized item names because item IDs are inconsistent across event types.
- Product opportunity estimates are directional scenarios.
- Experiment results are synthetic and explicitly labelled.
- Cohort conclusions are limited by the three-month dataset window.
