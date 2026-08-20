# Dataset Profile

## Dataset

Google Analytics 4 public e-commerce sample dataset:

`bigquery-public-data.ga4_obfuscated_sample_ecommerce`

The analyzed period is:

- Start date: 2020-11-01
- End date: 2021-01-31

## Dataset Scale

- Total events: 4,295,584
- Unique users: 270,154

## Core E-commerce Events

| Event | Event Count | Unique Users |
|---|---:|---:|
| view_item | 386,068 | 61,252 |
| add_to_cart | 58,543 | 12,545 |
| begin_checkout | 38,757 | 9,715 |
| add_shipping_info | 19,722 | 9,714 |
| add_payment_info | 13,899 | 5,751 |
| purchase | 5,692 | 4,419 |

The dataset does not expose a meaningful `view_cart` event in the analyzed
period, so it is excluded from the primary funnel.

## Primary Product Funnel

Product View
→ Add to Cart
→ Begin Checkout
→ Add Shipping Information
→ Add Payment Information
→ Purchase

Final funnel conversion rates will be calculated using ordered,
session-aware event sequences rather than simple event-count ratios.

## Purchase Metrics

- Purchase events: 5,692
- Purchasers: 4,419
- Distinct transactions: 4,452
- Total purchase revenue: 362,165
- Average revenue recorded per purchase event: 69.09

The difference between purchase-event count and distinct transaction count
will be investigated during data-quality analysis.

## Device Distribution

| Device | Unique Users | Event Count |
|---|---:|---:|
| Desktop | 158,917 | 2,498,330 |
| Mobile | 109,195 | 1,704,069 |
| Tablet | 6,250 | 93,185 |

Device will be an important segmentation dimension during funnel analysis,
especially for comparing mobile and desktop conversion behaviour.

## Day 1 Conclusion

The dataset contains sufficient behavioral, commerce, device, acquisition,
and revenue information to support the planned Product Analytics project.
