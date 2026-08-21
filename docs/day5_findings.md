# Day 5 Business Impact and Experimentation Findings

## Objective

Translate the conversion opportunities identified in Days 3 and 4 into
directional business-impact estimates and define how a product intervention
could be validated through experimentation.

## Downstream Cart Economics

Observed session behavior shows:

- Add-to-cart sessions: 15,188
- Cart sessions later recording a purchase: 2,837
- Observed post-cart purchase rate: 18.68%
- Average revenue per converted cart session: 71.63

These observed values are used to translate potential incremental carts into
directional purchase and revenue opportunities.

## Opportunity Sizing

Product opportunities are based on the gap between each product's observed
View → Cart conversion and the 24.67% product portfolio benchmark.

Three planning scenarios are evaluated:

- 25% of conversion gap closed
- 50% of conversion gap closed
- 100% of conversion gap closed

These scenarios are opportunity estimates and are not causal forecasts.

## Highest-Value Product Opportunities

### YouTube Icon Tee Grey

Observed:

- Product views: 14,205
- View → Cart: 16.14%
- Benchmark: 24.67%
- Gap: 8.53 percentage points

50% gap-closure scenario:

- Estimated additional carts: 606
- Estimated additional purchases: 113.1
- Estimated additional revenue: 8,101.69

Full benchmark scenario:

- Estimated additional carts: 1,211
- Estimated additional purchases: 226.2
- Estimated additional revenue: 16,203.38

### Google Land & Sea French Terry

50% scenario:

- Estimated additional carts: 451
- Estimated additional purchases: 84.2
- Estimated additional revenue: 6,034.46

Full benchmark scenario:

- Estimated additional carts: 902
- Estimated additional purchases: 168.5
- Estimated additional revenue: 12,068.91

### Google Sherpa Zip Hoodie Navy

50% scenario:

- Estimated additional carts: 381
- Estimated additional purchases: 71.2
- Estimated additional revenue: 5,097.84

Full benchmark scenario:

- Estimated additional carts: 762
- Estimated additional purchases: 142.3
- Estimated additional revenue: 10,195.69

### YouTube Icon Tee Charcoal

50% scenario:

- Estimated additional carts: 372
- Estimated additional purchases: 69.5
- Estimated additional revenue: 4,977.42

Full benchmark scenario:

- Estimated additional carts: 744
- Estimated additional purchases: 139.0
- Estimated additional revenue: 9,954.85

### Google Heather Green Speckled Product

50% scenario:

- Estimated additional carts: 349
- Estimated additional purchases: 65.1
- Estimated additional revenue: 4,662.99

Full benchmark scenario:

- Estimated additional carts: 697
- Estimated additional purchases: 130.2
- Estimated additional revenue: 9,325.98

## Top-Five Portfolio Opportunity

Across the five highest-value product opportunities:

### Conservative Scenario — 25% Gap Closure

- Estimated additional purchases: 201.5
- Estimated additional revenue: 14,437.20

### Target Scenario — 50% Gap Closure

- Estimated additional purchases: 403.1
- Estimated additional revenue: 28,874.40

### Full-Benchmark Scenario — 100% Gap Closure

- Estimated additional purchases: 806.2
- Estimated additional revenue: 57,748.81

The 50% scenario is the more appropriate planning case because it does not
assume that every underperforming product can immediately reach the full
portfolio benchmark.

## Experiment Recommendation

Days 3 and 4 show:

- New-user View → Cart conversion: 17.03%
- Returning-user View → Cart conversion: 24.90%
- Several high-volume products also underperform the portfolio benchmark.

The proposed experiment therefore targets purchase-confidence friction for
new users viewing high-volume, below-benchmark products.

## Experiment Hypothesis

Improving product-detail-page purchase confidence and CTA clarity will
increase new-user View → Add-to-Cart conversion.

Potential treatment elements include:

- More prominent Add to Cart CTA
- Clear delivery expectations
- Visible return information
- Stronger trust signals
- Improved product-information hierarchy

These are hypotheses and are not claimed as proven causes of the observed
conversion gap.

## Experiment Planning

Primary metric:

View → Add-to-Cart conversion

Baseline:

17.03%

Minimum Detectable Effect:

10% relative improvement

Target treatment rate:

approximately 18.73%

Statistical configuration:

- Alpha: 5%
- Confidence level: 95%
- Statistical power: 80%
- Two-sided test
- User-level randomization

Required sample:

- 7,944 users per variant
- 15,888 total users

## Synthetic Experiment Demonstration

The public GA4 dataset does not contain an experiment assignment.

A synthetic experiment was therefore constructed only to demonstrate the
statistical methodology.

Synthetic results:

- Control: 17.03%
- Treatment: 18.73%
- Absolute lift: +1.70 percentage points
- Relative lift: +9.98%
- p-value: 0.0052
- 95% CI: +0.51 to +2.89 percentage points
- Statistical result: Significant positive lift

Because the complete confidence interval is above zero and the p-value is
below 0.05, the synthetic treatment demonstrates a statistically significant
positive effect.

A real ship decision would additionally require satisfactory guardrail
metrics and meaningful business impact.

## Day 5 Conclusion

The project has progressed from identifying a funnel problem to:

1. Locating the highest-volume product opportunities.
2. Quantifying directional business impact.
3. Defining an intervention hypothesis.
4. Calculating required experiment sample size.
5. Demonstrating statistical experiment analysis.

The next stage is to communicate these insights through an executive
Product Analytics dashboard.
