# Experiment Design

## Experiment

Product Detail Page Purchase-Confidence Test

## Business Problem

New users show substantially weaker product-intent formation than returning
users.

Observed strict View → Cart rates:

- New users: 17.03%
- Returning users: 24.90%

Several high-volume products also perform below the portfolio-level
product-session View → Cart benchmark.

## Hypothesis

Improving purchase-confidence information and CTA clarity on selected
high-volume product detail pages will increase Add-to-Cart conversion for
new users.

## Eligibility

- New users
- Product-detail-page exposure
- Selected high-volume products with below-benchmark View → Cart conversion

## Control

Current product detail page.

## Treatment

Enhanced product detail page containing clearer purchase-confidence elements,
such as:

- More prominent Add to Cart CTA
- Clear delivery expectations
- Clear return information
- Product trust/value information
- Improved product-detail hierarchy

The exact design is hypothetical and would normally be finalized with Product
and Design teams.

## Randomization Unit

User-level randomization.

Using a user rather than session randomization reduces the chance that the
same user sees both Control and Treatment.

## Primary Metric

View → Add-to-Cart conversion.

## Secondary Metrics

- Product View → Purchase conversion
- Revenue per session
- Checkout progression
- Purchase sessions

## Guardrail Metrics

- Revenue per purchasing session
- Checkout abandonment
- Purchase conversion
- Refund behavior where measurable
- Page-performance metrics in a production implementation

## Baseline

New-user View → Cart:

17.03%

## Minimum Detectable Effect

10% relative improvement.

Target rate:

approximately 18.73%.

This corresponds to approximately:

+1.70 percentage points absolute lift.

## Statistical Settings

- Significance level: 5%
- Confidence level: 95%
- Power: 80%
- Two-sided test

## Statistical Method

Two-proportion z-test.

## Decision Rule

A positive experiment would require:

1. Statistically significant improvement in the primary metric.
2. Positive confidence interval for the treatment effect.
3. No material deterioration in guardrail metrics.
4. Business impact large enough to justify implementation.

## Important Limitation

The GA4 public dataset does not contain a real experiment assignment.

The project therefore uses a clearly labelled synthetic experiment only to
demonstrate experiment-design and statistical-analysis methodology.

Synthetic results are not presented as actual product impact.
