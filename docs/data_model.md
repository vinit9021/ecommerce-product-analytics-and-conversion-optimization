# Data Model

## Architecture

Google GA4 Public E-commerce Dataset
        |
        v
events_base
        |
        v
session_summary
        |
        v
daily_kpis

## events_base

### Grain

One row per GA4 event.

### Purpose

Flatten important nested GA4 fields into a reusable analytical structure.

### Important Fields

- event_date
- event_timestamp
- user_pseudo_id
- ga_session_id
- session_key
- event_name
- device_category
- country
- region
- first_user_source
- first_user_medium
- first_user_campaign
- transaction_id
- purchase_revenue
- total_item_quantity
- engagement_time_msec

## session_summary

### Grain

One row per user-session combination.

### Purpose

Represent every browsing session using behavioral and commerce indicators.

### Important Fields

- event_count
- page_views
- session_duration_seconds
- engagement_time_msec
- viewed_product
- added_to_cart
- began_checkout
- added_shipping
- added_payment
- purchased
- purchase_events
- revenue

## daily_kpis

### Grain

One row per calendar date.

### Purpose

Provide daily product-health metrics for trend analysis and future dashboarding.

### Metrics

- Users
- Sessions
- Product-view sessions
- Add-to-cart sessions
- Checkout sessions
- Shipping sessions
- Payment sessions
- Purchasing sessions
- Purchase events
- Revenue
- Session purchase rate
- Revenue per session
- Average revenue per purchase event

## Design Principle

The 4.29M raw GA4 events remain in Google's public BigQuery dataset.

The project creates reusable analytical views instead of duplicating the
entire raw dataset locally.
