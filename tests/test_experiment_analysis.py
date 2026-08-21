from src.experiment_analysis import (
    ExperimentConfig,
    analyze_experiment,
    required_sample_size,
)


def test_required_sample_size_is_positive():
    config = ExperimentConfig()

    n = required_sample_size(config)

    assert n > 0


def test_positive_synthetic_lift_is_detected():
    results = analyze_experiment(
        control_visitors=7944,
        control_conversions=1353,
        treatment_visitors=7944,
        treatment_conversions=1488,
    )

    assert results["treatment_rate"] > results["control_rate"]
    assert results["p_value"] < 0.05
    assert results["ci_low"] > 0
    assert results["decision"] == "SIGNIFICANT POSITIVE LIFT"


def test_identical_conversion_has_no_positive_lift():
    results = analyze_experiment(
        control_visitors=5000,
        control_conversions=1000,
        treatment_visitors=5000,
        treatment_conversions=1000,
    )

    assert results["absolute_lift"] == 0
    assert results["p_value"] >= 0.05
    assert results["decision"] == "NO SIGNIFICANT POSITIVE LIFT"
