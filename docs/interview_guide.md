# Interview Guide

## 60-90 Second Project Explanation

I built an end-to-end e-commerce Product Analytics project using Google's public GA4 Merchandise Store dataset containing more than 4.29 million events.

I first modeled the raw event data in BigQuery into session-level analytical views and built a strict ordered funnel from product view through purchase. The biggest post-discovery bottleneck was Product View to Add to Cart, where approximately 80% of sessions dropped off.

I then segmented conversion by device, acquisition source, and new versus returning users. Returning users had a 4.23% strict View-to-Purchase conversion rate compared with 1.36% for new users, while mobile and desktop behaved relatively similarly.

Next, I built product-level performance models. Because item IDs were inconsistent in the obfuscated dataset, I validated the data and used normalized product names as the canonical key. I benchmarked product View-to-Cart conversion and ranked high-volume underperforming products by potential business impact.

Under a 50% benchmark-gap closure planning scenario, the top five opportunities represented roughly 403 incremental purchases and .9K in estimated revenue.

Finally, I created cohort-retention analysis, a synthetic A/B experiment framework with significance testing and confidence intervals, and an interactive Streamlit dashboard backed directly by BigQuery.

The main product recommendation is to improve purchase-confidence and CTA clarity on high-volume underperforming product pages, especially for new users, and validate the change through a randomized experiment before rollout.

## Questions To Prepare

### Why did you use a strict ordered funnel?

To make sure a session only reached a later stage if the expected earlier event occurred first. This prevents unordered event logging from inflating funnel progression.

### Why are strict purchases lower than recorded purchasing sessions?

Some purchasing sessions do not contain the complete expected ordered event path. They can represent alternative journeys, instrumentation gaps, or event-order differences, so I kept recorded purchase behavior separate from the strict funnel.

### Why didn't you use transaction ID as the order count?

The public obfuscated dataset contains missing, repeated, and placeholder transaction IDs such as '(not set)'. Using them directly would create misleading order counts.

### Why did you use item name instead of item ID?

Item IDs were inconsistent across event types, while normalized product names showed much stronger matching between product-view and purchase events.

### Is the estimated .9K guaranteed revenue?

No. It is a directional planning scenario based on observed funnel behavior and a 50% benchmark-gap closure assumption. It is not a causal forecast.

### Was the A/B experiment real?

No. The public dataset has no experiment-assignment variable, so the experiment result is explicitly synthetic. It demonstrates experimental design, sample-size planning, significance testing, and decision methodology.
