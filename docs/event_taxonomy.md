# Event Taxonomy

## Purpose

The event taxonomy defines the behavioral events used to understand the
e-commerce customer journey.

## Core Events

| Event | Product Meaning | Funnel Role |
|---|---|---|
| session_start | User begins a session | Session entry |
| page_view | User views a webpage | Engagement |
| view_item_list | User views a product collection | Discovery |
| select_item | User selects a product | Discovery |
| view_item | User views a product detail page | Product interest |
| add_to_cart | User adds a product to cart | Purchase intent |
| begin_checkout | User starts checkout | Checkout intent |
| add_shipping_info | User provides shipping details | Checkout progression |
| add_payment_info | User provides payment information | High purchase intent |
| purchase | User completes a purchase | Conversion |

## Primary Funnel

view_item
→ add_to_cart
→ begin_checkout
→ add_shipping_info
→ add_payment_info
→ purchase

## Main Dimensions

Behavior will later be segmented by:

- Device category
- Acquisition source
- Acquisition medium
- Country and region
- Product
- Product category
- User
- Session
- Date

## User Identifier

`user_pseudo_id`

Anonymous GA4 identifier representing a browser/device user.

## Session Identifier

`ga_session_id`

The analytical session key combines:

`user_pseudo_id + ga_session_id`

This prevents us from assuming that a GA4 session ID is globally unique.

## Analytical Principle

Raw event counts are not equivalent to sessions.

One user can generate several instances of the same event in one session.
Final funnel conversion therefore uses session-aware analysis rather than
simple ratios between raw event counts.
