# KPI Framework

## Business Objective

Identify friction in the e-commerce journey and prioritize product
opportunities that can improve conversion and revenue.

## Primary Product Outcome

**Purchasing Sessions**

A purchasing session contains at least one `purchase` event.

## KPI Hierarchy

Revenue
├── Purchasing Sessions
│   └── Purchase Conversion
│       ├── Payment Progression
│       ├── Checkout Progression
│       ├── Add-to-Cart Behavior
│       └── Product Engagement
└── Revenue per Purchase Event

## Core Metrics

### Users

Distinct `user_pseudo_id` values.

### Sessions

Distinct combinations of:

`user_pseudo_id + ga_session_id`

### Product View Sessions

Sessions containing at least one `view_item`.

### Add-to-Cart Sessions

Sessions containing at least one `add_to_cart`.

### Checkout Sessions

Sessions containing at least one `begin_checkout`.

### Shipping Sessions

Sessions containing at least one `add_shipping_info`.

### Payment Sessions

Sessions containing at least one `add_payment_info`.

### Purchasing Sessions

Sessions containing at least one `purchase`.

### Purchase Events

Total number of recorded `purchase` events.

### Revenue

Sum of `purchase_revenue` from purchase events.

### Session Purchase Rate

Purchasing Sessions / Total Sessions

### Revenue per Session

Revenue / Total Sessions

### Average Revenue per Purchase Event

Revenue / Purchase Events

This metric is used instead of true Average Order Value because transaction
identifiers in the public obfuscated dataset contain unreliable values.

## Funnel Metrics

Day 3 will calculate:

- Product View → Add to Cart
- Add to Cart → Begin Checkout
- Begin Checkout → Shipping
- Shipping → Payment
- Payment → Purchase
- Product View → Purchase

## Segmentation Dimensions

Metrics will later be compared across:

- Device
- Acquisition source
- Acquisition medium
- Geography
- Product and category
- User behavior

## Experiment Guardrails

Future experiments will monitor:

- Revenue per session
- Purchase conversion
- Purchase activity
- Average revenue per purchase event
- Refund behavior where available
