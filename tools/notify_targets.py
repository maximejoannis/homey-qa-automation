import json
from pathlib import Path

FAILURE_ANALYSIS = Path("results/failure_analysis.json")
RULES = Path("config/notification_rules.json")
NOTIFICATIONS = Path("results/notifications.json")


def main() -> None:
    analysis = {"failed_tests": []}
    rules = {}

    if FAILURE_ANALYSIS.exists():
        analysis = json.loads(FAILURE_ANALYSIS.read_text(encoding="utf-8"))

    if RULES.exists():
        rules = json.loads(RULES.read_text(encoding="utf-8"))

    notifications = []

    for item in analysis.get("failed_tests", []):
        failure_type = item.get("failure_type", "unknown")
        rule = rules.get(failure_type, rules.get("unknown", {}))

        notifications.append(
            {
                "test_name": item.get("test_name"),
                "failure_type": failure_type,
                "target": rule.get("target", "qa"),
                "priority": rule.get("priority", "medium"),
                "message": rule.get(
                    "message",
                    "Analyser l'échec et orienter vers l'équipe QA.",
                ),
            }
        )

    NOTIFICATIONS.write_text(
        json.dumps({"notifications": notifications}, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
