import xml.etree.ElementTree as ET
from pathlib import Path

OUTPUT_XML = Path("results/output.xml")
SUMMARY_MD = Path("results/summary.md")


def main() -> None:
    if not OUTPUT_XML.exists():
        SUMMARY_MD.write_text(
            "# Résumé des tests\n\nAucun fichier output.xml trouvé.\n",
            encoding="utf-8",
        )
        return

    tree = ET.parse(OUTPUT_XML)
    root = tree.getroot()

    tests = root.findall(".//test")
    total = len(tests)
    passed = 0
    failed = 0
    failed_tests = []

    for test in tests:
        status = test.find("status")
        name = test.attrib.get("name", "Unknown")

        if status is None:
            continue

        result = status.attrib.get("status")
        if result == "PASS":
            passed += 1
        elif result == "FAIL":
            failed += 1
            failed_tests.append(name)

    success_rate = (passed / total * 100) if total else 0.0

    lines = [
        "# Résumé des tests",
        "",
        f"- Total : **{total}**",
        f"- Passés : **{passed}**",
        f"- Échecs : **{failed}**",
        f"- Taux de réussite : **{success_rate:.2f}%**",
        "",
    ]

    if failed_tests:
        lines.extend(
            [
                "## Tests en échec",
                "",
            ]
        )
        for test_name in failed_tests:
            lines.append(f"- {test_name}")
    else:
        lines.extend(
            [
                "## Résultat",
                "",
                "Aucun test en échec.",
            ]
        )

    SUMMARY_MD.write_text("\n".join(lines), encoding="utf-8")


if __name__ == "__main__":
    main()
