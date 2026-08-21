from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_portfolio_artifacts_exist():
    required = [
        "README.md",
        "dashboard/app.py",
        "dashboard/charts.py",
        "dashboard/data_loader.py",
        "docs/project_case_study.md",
        "docs/interview_guide.md",
        "docs/resume_bullets.md",
        "images/01_executive_overview.png",
        "images/02_funnel_segments.png",
        "images/03_product_opportunities.png",
        "images/04_retention_experiment.png",
        "sql/22_dashboard_views.sql",
    ]

    missing = [
        item
        for item in required
        if not (ROOT / item).exists()
    ]

    assert not missing, f"Missing portfolio artifacts: {missing}"

