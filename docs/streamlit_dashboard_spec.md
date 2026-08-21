# Streamlit Product Analytics Dashboard

## Purpose

Provide an interactive executive view of the complete e-commerce Product
Analytics case study.

## Architecture

BigQuery analytical views
→ Python data loader
→ Pandas
→ Plotly
→ Streamlit

## Dashboard Tabs

### Executive Overview

- Users
- Sessions
- Purchasing sessions
- Purchase rate
- Revenue
- Revenue per session
- Daily sessions
- Daily revenue
- Daily purchase-rate trend

### Funnel & Segments

- Strict ordered funnel
- Step conversion
- Device conversion
- New vs returning conversion
- First-user acquisition performance

### Product Opportunities

- Product revenue-opportunity ranking
- Product conversion vs portfolio benchmark
- Category performance
- 25%, 50%, and 100% gap-closure scenarios

### Retention & Experiment

- Cohort retention heatmap
- Month-1 retention
- Synthetic A/B experiment readout
- Statistical decision framework

## Analytical Guardrails

- Recorded purchases and strict-funnel purchases remain separate.
- Product opportunities are directional planning scenarios.
- Synthetic experiment results are explicitly labelled.
- Transaction IDs are not treated as exact order identifiers.
