# Funnel Methodology

## Objective

Measure where users abandon the e-commerce customer journey and identify
segments with unusually weak conversion.

## Funnel

Session
→ Product View
→ Add to Cart
→ Begin Checkout
→ Shipping Information
→ Payment Information
→ Purchase

## Strict Ordered Funnel

The project uses a strict session-level funnel.

A user reaches a step only when:

1. The event occurs in the same session.
2. The previous funnel step has already occurred.
3. The event timestamp is equal to or later than the previous step.

This prevents unordered event presence from being incorrectly interpreted as
funnel progression.

## Example

A session containing:

view_item
→ add_to_cart
→ begin_checkout
→ purchase

does not reach the final strict funnel step because shipping and payment
events were not recorded between checkout and purchase.

The purchase is still retained as a recorded purchase in the session model.

## Why Both Measures Matter

`recorded_purchase_session` measures whether any purchase was recorded.

`step_6_purchase` measures whether the full instrumented funnel was completed
in sequence.

Differences between the two may indicate:

- Alternative user journeys
- Missing instrumentation
- Event-order issues
- Checkout paths that skip tracked events

## Segmentation

Day 3 analyzes the ordered funnel across:

- Device category
- First-user acquisition source and medium
- New vs returning sessions

## New vs Returning Definition

A session is classified as `new` when it contains the GA4 `first_visit`
event.

Other sessions are classified as `returning`.

## Conversion Metrics

### Step Conversion

Current Funnel Step Sessions / Previous Funnel Step Sessions

### Step Drop-off

Previous Funnel Step Sessions - Current Funnel Step Sessions

### Step Drop-off Rate

Step Drop-off / Previous Funnel Step Sessions

### Product View to Purchase

Strict Purchase Sessions / Product View Sessions

### Session to Purchase

Strict Purchase Sessions / All Sessions

## Analytical Principle

Conversion rates are interpreted alongside sample size.

Very small segments are not used to make major product recommendations
without sufficient supporting volume.
