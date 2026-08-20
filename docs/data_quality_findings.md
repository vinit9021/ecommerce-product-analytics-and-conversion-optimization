# Data Quality Findings

## Session Identifier Quality

All analyzed events contain a valid `ga_session_id`.

- Total events: 4,295,584
- Missing session IDs: 0
- Missing session rate: 0.0%

This allows the complete analyzed event population to be used for
session-level analysis.

## Transaction Identifier Quality

Transaction identifiers were found to be unreliable for exact order counting.

Observed issues include:

- 5,692 purchase events
- 23 purchase events with NULL transaction IDs
- 4,452 distinct transaction identifier values
- `(not set)` appears across hundreds of purchase sessions
- Some transaction IDs appear across multiple sessions and users

The `(not set)` placeholder alone appears across 792 sessions.

## Analytical Decision

`transaction_id` is therefore not used as the primary conversion-volume
metric.

The project instead uses:

- Purchasing sessions for conversion analysis
- Purchase events for purchase activity
- Purchase revenue for revenue analysis

Transaction identifiers are retained for data-quality diagnostics.

## Source-to-Model Reconciliation

The corrected session model preserves:

- Source purchase events: 5,692
- Session-model purchase events: 5,692
- Source revenue: 362,165
- Session-model revenue: 362,165

This validates the session aggregation layer.

## Product Identifier Quality

Item-level validation found that `item_id` is not stable across event types
in the obfuscated dataset.

- Viewed item IDs: 426
- Purchased item IDs: 809
- Matching item IDs: 4

Normalized product names are substantially more consistent:

- Viewed product names: 422
- Purchased product names: 396
- Matching product names: 388

The product model therefore uses normalized `item_name` as the canonical
cross-event product identifier.

Product category is treated as descriptive metadata rather than part of the
product key.
