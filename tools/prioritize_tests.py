import json
from pathlib import Path

TEST_METADATA = Path("config/test_metadata.json")
FAILURE_ANALYSIS = Path("results/failure_analysis.json")
PRIORITIES = Path("results/test_priorities.json")


def main() -> None:
    metadata = {}
    failure_data = {"failed_tests": []}

    if TEST_METADATA.exists():
        metadata = json.loads(TEST_METADATA.read_text(encoding="utf-8"))

    if FAILURE_ANALYSIS.exists():
        failure_data = json.loads(FAILURE_ANALYSIS.read_text(encoding="utf-8"))

    failed_lookup = {
        item["test_name"]: item.get("failure_type", "unknown")
        for item in failure_data.get("failed_tests", [])
    }

    priorities = []

    for test_name, info in metadata.items():
        business_criticality = int(info.get("business_criticality", 1))
        test_type = info.get("type", "regression")
        stability = int(info.get("stability", 3))
        recent_failure_bonus = 25 if test_name in failed_lookup else 0
        smoke_bonus = 15 if test_type == "smoke" else 0
        regression_bonus = 8 if test_type == "regression" else 0
        instability_bonus = max(0, 6 - stability) * 5

        score = (
            business_criticality * 10
            + recent_failure_bonus
            + smoke_bonus
            + regression_bonus
            + instability_bonus
        )

        priorities.append(
            {
                "test_name": test_name,
                "suite": info.get("suite", "unknown"),
                "type": test_type,
                "business_criticality": business_criticality,
                "stability": stability,
                "recent_failure": test_name in failed_lookup,
                "recent_failure_type": failed_lookup.get(test_name),
                "priority_score": score,
            }
        )

    priorities.sort(key=lambda item: item["priority_score"], reverse=True)

    PRIORITIES.write_text(
        json.dumps({"priorities": priorities}, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
