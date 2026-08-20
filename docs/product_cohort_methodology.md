# Product and Cohort Methodology

## Objective

Investigate the Product View → Add-to-Cart bottleneck and understand
short-term user return behavior.

## Item-Level Analysis

GA4 stores products inside a repeated `items` array.

`item_events` flattens this structure so each row represents one product
within one relevant GA4 event.

Relevant events include:

- view_item
- add_to_cart
- begin_checkout
- purchase

## Canonical Product Identity

Diagnostics showed that `item_id` is not stable across event types in the
obfuscated public dataset.

Only 4 item IDs matched between the viewed and purchased item-ID universes.

Normalized product names were far more stable:

- 422 viewed product names
- 396 purchased product names
- 388 matching product names

The project therefore uses:

`LOWER(TRIM(item_name))`

as the canonical product key.

Product category is treated as descriptive metadata and is primarily derived
from product-view events.

## Product-Session Grain

`product_session_behavior` contains one row per canonical product per
viewing session.

Repeated views of the same product in one session therefore do not inflate
the product conversion denominator.

A single website session may interact with multiple products, so total
product-session counts can exceed total website-session counts.

## Product Conversion

### View → Cart

Product viewing sessions with a later add-to-cart for the same canonical
product divided by product viewing sessions.

### View → Purchase

Product viewing sessions with a later purchase of the same canonical product
divided by product viewing sessions.

## Product Opportunity Heuristic

Products with at least 100 product-view sessions are compared with the
portfolio View → Cart benchmark.

Estimated incremental cart sessions:

Product View Sessions
×
(Benchmark Cart Rate - Product Cart Rate)

Only positive gaps are retained.

This metric is an opportunity-screening heuristic, not a causal forecast.

## Product Monetary Measure

Item-level monetary analysis uses:

price × quantity

for mapped purchased items.

This is labeled merchandise value and is not assumed to be identical to
overall GA4 purchase revenue.

## Cohort Analysis

Users are grouped by the first calendar month in which they appear within
the available dataset.

Retention is:

Active Users in Month N / Cohort Month 0 Users

## Cohort Limitation

The available period is November 2020 through January 2021.

The cohort analysis therefore measures short-term, dataset-relative retention
rather than long-term customer retention.
