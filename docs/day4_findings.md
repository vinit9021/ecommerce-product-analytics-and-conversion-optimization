# Day 4 Product and Cohort Findings

## Objective

Investigate the large Product View → Add-to-Cart drop-off identified on
Day 3 and determine which products, categories, and customer cohorts deserve
further optimization.

## Product Identity Validation

The obfuscated GA4 dataset does not provide a stable item ID across event
types.

Diagnostics showed:

- Viewed item IDs: 426
- Purchased item IDs: 809
- Matching item IDs: only 4

Product names were substantially more stable:

- Viewed product names: 422
- Purchased product names: 396
- Matching product names: 388

The model therefore uses normalized `item_name` as the canonical product key.

Category is treated as descriptive metadata derived primarily from product
view events rather than as part of product identity.

## Corrected Product Model

The corrected model contains:

- 421 canonical products
- 1,108,699 product-view product-sessions
- 273,501 add-to-cart product-sessions
- 11,967 mapped purchase product-sessions
- 313,456 mapped purchase merchandise value

Product-session counts can exceed total website sessions because a single
session may interact with several products.

## Product View → Cart Benchmark

The portfolio-level product-session View → Cart benchmark is:

**24.67%**

Products materially below this benchmark and with high traffic are treated
as potential optimization opportunities.

## Major Product Opportunities

### YouTube Icon Tee Grey

- Product-view sessions: 14,205
- Add-to-cart sessions: 2,293
- Purchase sessions: 54
- View → Cart: 16.14%
- View → Purchase: 0.38%
- Gap vs benchmark: 8.53 percentage points
- Estimated incremental carts at benchmark: ~1,211

This is the largest current product-level cart opportunity.

### Google Land & Sea French Terry

- Product-view sessions: 12,123
- Add-to-cart sessions: 2,089
- Purchase sessions: 26
- View → Cart: 17.23%
- View → Purchase: 0.21%
- Estimated incremental carts at benchmark: ~902

### Google Sherpa Zip Hoodie Navy

- Product-view sessions: 6,962
- Add-to-cart sessions: 955
- Purchase sessions: 70
- View → Cart: 13.72%
- View → Purchase: 1.01%
- Estimated incremental carts at benchmark: ~762

### YouTube Icon Tee Charcoal

- Product-view sessions: 11,815
- Add-to-cart sessions: 2,171
- Purchase sessions: 79
- View → Cart: 18.37%
- View → Purchase: 0.67%
- Estimated incremental carts at benchmark: ~744

## Category Findings

Selected high-volume categories show meaningful differences.

| Category | Product Views | View → Cart | View → Purchase |
|---|---:|---:|---:|
| Men's / Unisex Apparel | 240,433 | 23.54% | 0.90% |
| Sale | 128,662 | 27.69% | 0.56% |
| Hats | 94,438 | 34.45% | 0.75% |
| New | 90,070 | 20.19% | 0.43% |
| Bags | 65,981 | 18.75% | 0.62% |

Hats show particularly strong cart intent, while Bags and New products show
weaker View → Cart behavior.

Category results should be interpreted alongside product-level composition,
pricing, and traffic mix.

## Cohort Retention

### November 2020 Cohort

- Cohort size: 79,421
- Month 1 active users: 4,638
- Month 1 retention: 5.84%
- Month 2 active users: 1,204
- Month 2 retention: 1.52%

### December 2020 Cohort

- Cohort size: 99,664
- Month 1 active users: 2,515
- Month 1 retention: 2.52%

The dataset ends in January 2021, so later retention cannot be observed.

## Combined Product Interpretation

Day 3 showed that returning users have substantially stronger conversion than
new users.

Day 4 shows that only a small percentage of users return in subsequent months.

Together, these findings suggest two major opportunity areas:

1. Improve purchase intent on high-volume, low-cart products.
2. Improve first-time-user experience and re-engagement so more users become
   returning users.

## Day 5 Priority

Day 5 will quantify the business value of these opportunities and design an
experiment around the most promising intervention.
