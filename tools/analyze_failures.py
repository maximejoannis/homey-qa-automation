import json
import re
import xml.etree.ElementTree as ET
from pathlib import Path

OUTPUT_XML = Path("results/output.xml")
ANALYSIS_JSON = Path("results/failure_analysis.json")


def normalize_volatile_data(message: str) -> str:
    text = message
    text = re.sub(r"\b\d{3,}\b", "<ID>", text)
    text = re.sub(
        r"\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b",
        "<UUID>",
        text,
    )
    text = re.sub(r"\b\d{8}_\d{6}\b", "<TIMESTAMP>", text)
    return text


def classify_failure(message: str) -> str:
    text = normalize_volatile_data(message).lower()

    if "variable" in text and "not found" in text:
        return "test_script_error"
    if "element" in text and "not found" in text:
        return "locator_not_found"
    if "timeout" in text or "wait until" in text:
        return "timeout"
    if "stale element" in text:
        return "flaky_ui"
    if "click intercepted" in text or "not clickable" in text:
        return "interaction_issue"
    if "500" in text or "internal server error" in text:
        return "application_error"
    if "connection refused" in text or ("selenium" in text and "not ready" in text):
        return "environment_error"

    return "unknown"


def recommendation_for_failure(failure_type: str) -> str:
    mapping = {
        "test_script_error": "Corriger le code Robot Framework ou les variables utilisées.",
        "locator_not_found": "Vérifier et stabiliser le locator ciblé.",
        "timeout": "Analyser le chargement de la page et renforcer les attentes explicites.",
        "flaky_ui": "Rendre l'interaction plus robuste et revoir le synchronisme.",
        "interaction_issue": "Ajouter scroll, attente de visibilité ou fallback JavaScript.",
        "application_error": "Vérifier le comportement applicatif et les logs techniques.",
        "environment_error": "Contrôler l'environnement CI, Selenium et la disponibilité de l'application.",
        "unknown": "Analyser le log détaillé et la capture d'écran associée.",
    }
    return mapping.get(failure_type, mapping["unknown"])


def main() -> None:
    if not OUTPUT_XML.exists():
        ANALYSIS_JSON.write_text(
            json.dumps({"error": "output.xml not found"}, indent=2, ensure_ascii=False),
            encoding="utf-8",
        )
        return

    tree = ET.parse(OUTPUT_XML)
    root = tree.getroot()

    failed_tests = []

    for test in root.findall(".//test"):
        name = test.attrib.get("name", "Unknown")
        status = test.find("status")

        if status is None:
            continue

        if status.attrib.get("status") == "FAIL":
            message = (status.text or "").strip()
            normalized_message = normalize_volatile_data(message)
            failure_type = classify_failure(message)

            failed_tests.append(
                {
                    "test_name": name,
                    "failure_type": failure_type,
                    "message": message,
                    "normalized_message": normalized_message,
                    "recommendation": recommendation_for_failure(failure_type),
                }
            )

    output = {
        "failed_tests_count": len(failed_tests),
        "failed_tests": failed_tests,
    }

    ANALYSIS_JSON.write_text(
        json.dumps(output, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
