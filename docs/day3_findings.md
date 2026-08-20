# Day 3 Funnel Findings

## Objective

Identify the largest conversion bottlenecks in the e-commerce journey and
determine which user segments represent the strongest optimization
opportunities.

## Overall Ordered Funnel

| Funnel Stage | Sessions | Step Conversion | Step Drop-off |
|---|---:|---:|---:|
| Session | 360,129 | - | - |
| Product View | 77,020 | 21.39% | 78.61% |
| Add to Cart | 15,167 | 19.69% | 80.31% |
| Begin Checkout | 5,416 | 35.71% | 64.29% |
| Shipping Information | 3,119 | 57.59% | 42.41% |
| Payment Information | 2,438 | 78.17% | 21.83% |
| Purchase | 1,792 | 73.50% | 26.50% |

Overall strict Product View → Purchase conversion is 2.33%.

## Finding 1 — Product View to Cart Is the Largest Post-Discovery Bottleneck

Only 19.69% of product-view sessions progress to add-to-cart.

This represents an 80.31% drop-off after users have already demonstrated
product interest.

Potential product areas to investigate include:

- Product-page clarity
- Product value proposition
- Pricing visibility
- Product imagery and descriptions
- CTA prominence
- Shipping and delivery expectations
- Trust signals
- Product availability

This will become a major focus of the deeper product analysis.

## Finding 2 — Returning Users Convert Much More Strongly

| Metric | New | Returning |
|---|---:|---:|
| Sessions | 257,400 | 102,729 |
| Product-view sessions | 50,963 | 26,057 |
| Add-to-cart sessions | 8,679 | 6,488 |
| Checkout sessions | 2,615 | 2,801 |
| Purchase sessions | 691 | 1,101 |
| View → Cart | 17.03% | 24.90% |
| Cart → Checkout | 30.13% | 43.17% |
| Payment → Purchase | 71.31% | 74.95% |
| View → Purchase | 1.36% | 4.23% |
| Session → Purchase | 0.27% | 1.07% |
| Strict funnel revenue | 44,312 | 87,274 |

Returning users have approximately 3.1x the Product View → Purchase
conversion rate of new users.

Despite accounting for substantially fewer sessions, returning-user sessions
generate almost twice the strict-funnel revenue observed from new-user
sessions.

This suggests a major opportunity around first-time-user trust, product
discovery, purchase confidence, or acquisition quality.

## Finding 3 — Device Is Not the Primary Conversion Problem

| Device | View → Cart | View → Purchase | Session → Purchase |
|---|---:|---:|---:|
| Desktop | 19.58% | 2.27% | 0.49% |
| Mobile | 19.90% | 2.42% | 0.52% |
| Tablet | 18.88% | 2.12% | 0.45% |

Desktop and mobile performance is relatively similar.

Mobile therefore does not currently appear to be the dominant conversion
bottleneck.

Tablet performance is slightly weaker, but its much smaller volume means it
is a lower-priority opportunity.

## Finding 4 — Acquisition Quality Differs by Source

Selected first-user acquisition results:

| Source / Medium | Product Views | View → Cart | View → Purchase |
|---|---:|---:|---:|
| google / organic | 23,663 | 18.34% | 1.93% |
| direct / none | 17,678 | 19.83% | 2.29% |
| Other / Other | 10,589 | 18.71% | 1.79% |
| Other / referral | 7,455 | 19.53% | 2.27% |
| shop.googlemerchandisestore... / referral | 6,634 | 21.98% | 3.42% |
| google / cpc | 3,167 | 17.81% | 1.93% |

The Google CPC segment does not materially outperform Google organic traffic
on Product View → Purchase conversion in this dataset.

Referral traffic from the Merchandise Store domain shows stronger downstream
conversion than several larger acquisition sources.

These results use first-user source/medium rather than session-level
attribution and should therefore be interpreted as acquisition-quality
signals rather than exact campaign-performance attribution.

## Finding 5 — Strict Funnel Coverage Is Incomplete

The session model contains 4,848 recorded purchasing sessions, while only
1,792 sessions complete every tracked funnel stage in strict sequence.

This means only about 37% of recorded purchase sessions follow the complete
instrumented path:

Product View
→ Add to Cart
→ Begin Checkout
→ Shipping
→ Payment
→ Purchase

The gap may reflect:

- Alternative valid checkout journeys
- Missing intermediate events
- Event instrumentation limitations
- Users entering the funnel at later stages
- Event ordering behavior

Therefore:

- `recorded_purchase_session` is used for overall purchase activity.
- `step_6_purchase` is used specifically for strict-funnel analysis.

The two metrics should not be treated as interchangeable.

## Day 3 Priority

The strongest analytical priorities moving forward are:

1. Understand the Product View → Add-to-Cart drop-off.
2. Investigate why new users underperform returning users.
3. Analyze which products and categories contribute most to lost conversion.
4. Quantify the business opportunity associated with improving these areas.

Device optimization remains a secondary priority based on the current data.
