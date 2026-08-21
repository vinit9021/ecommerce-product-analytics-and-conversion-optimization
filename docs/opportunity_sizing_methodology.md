# Business Opportunity Sizing Methodology

## Objective

Translate product conversion gaps into directional business-impact scenarios.

## Starting Point

Day 4 identifies high-volume products performing below the portfolio-level
View → Cart benchmark.

For each product, the model estimates the number of additional cart sessions
that could occur if the product improved toward the benchmark.

## Downstream Conversion

The project calculates the observed probability that a session containing an
Add-to-Cart event later records a Purchase event in the same session.

This produces the:

`post_cart_purchase_rate`

## Revenue Assumption

For sessions that purchase after adding to cart, the model calculates:

Average Revenue per Converted Cart Session

This observed average is used as a directional revenue assumption.

## Opportunity Scenarios

Three gap-closure scenarios are evaluated.

### Conservative

25% of the product's View → Cart benchmark gap is closed.

### Target

50% of the benchmark gap is closed.

### Full Benchmark

100% of the benchmark gap is closed.

## Estimated Purchases

Estimated Incremental Carts
×
Observed Post-Cart Purchase Rate

## Estimated Revenue

Estimated Incremental Purchases
×
Average Revenue per Converted Cart Session

## Important Limitation

These values are opportunity-sizing scenarios.

They are not causal forecasts and do not prove that a product intervention
will produce the estimated impact.

The actual causal effect must be measured through experimentation.
