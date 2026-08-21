# Dashboard Runbook

## Local Setup

Activate the virtual environment:

.\.venv\Scripts\Activate.ps1

Install dependencies:

pip install -r requirements.txt

## Google Authentication

The dashboard uses Google Application Default Credentials.

Authenticate once:

gcloud auth application-default login

Set the project:

gcloud config set project loyal-coyote-484615-e7

Set the quota project:

gcloud auth application-default set-quota-project loyal-coyote-484615-e7

## Start Dashboard

From the project root:

python -m streamlit run dashboard/app.py

The application normally opens at:

http://localhost:8501

## Source Dataset

Google BigQuery:

loyal-coyote-484615-e7.ecommerce_analytics

## Notes

No Google credentials are committed to GitHub.

Dashboard queries use compact analytical views and are cached for 30 minutes.
