# Homey QA Automation

Projet d’automatisation des tests fonctionnels de l’application **Homey** avec **Robot Framework**, **SeleniumLibrary** et **GitHub Actions**.

Ce projet démontre une approche professionnelle de la QA Automation basée sur trois piliers :

- **Learn** → Comprendre, tester, analyser
- **Build** → Structurer, factoriser, maintenir
- **Deploy** → Industrialiser, reporter, analyser intelligemment

---

## 1. Contexte du projet

Ce projet couvre l’automatisation de parcours métier clés :

- **US-07 : Faire une demande de réservation**
- **US-08 : Traiter une demande de réservation**
- Parcours complémentaire : **Contacter l’hôte**

Objectifs :
- automatiser les parcours critiques
- stabiliser les tests
- industrialiser l’exécution
- produire un reporting exploitable
- intégrer une analyse intelligente des résultats

---

## 2. Stack technique

- Robot Framework
- SeleniumLibrary
- Python 3.11
- GitHub Actions
- Selenium Standalone Chrome
- VS Code

---

## 3. Structure du projet

```text
homey-qa-automation/
├── .github/
│   └── workflows/
│       └── robot.yml
├── tests/
│   ├── us07_faire_demande_reservation.robot
│   └── contact_hote.robot
├── resources/
│   ├── common.resource
│   ├── navigation.resource
│   ├── reservation.resource
│   ├── contact_hote.resource
│   └── assertions.resource
├── variables/
│   ├── env.robot
│   └── data.robot
├── tools/
│   ├── generate_test_summary.py
│   ├── analyze_failures.py
│   ├── prioritize_tests.py
│   └── notify_targets.py
├── config/
│   ├── test_metadata.json
│   └── notification_rules.json
├── results/
├── requirements.txt
└── README.md
````

---

## 4. Philosophie : Learn / Build / Deploy

### Learn

* Comprendre les parcours métier
* Identifier les scénarios critiques
* Analyser les erreurs
* Stabiliser les tests

### Build

* Structurer le projet
* Factoriser les keywords
* Centraliser les locators
* Maintenir un code propre

### Deploy

* Exécuter automatiquement les tests
* Générer des rapports
* Analyser les échecs
* Prioriser les tests
* Notifier les bonnes équipes

---

## 5. Périmètre fonctionnel

### US-07 — Faire une demande de réservation

* affichage du module de réservation
* sélection des dates
* sélection des voyageurs
* sélection des extras
* validation du comportement utilisateur non connecté

### Contact Hôte

* ouverture de la modal
* présence des champs
* saisie des données
* fermeture de la modal
* soumission du formulaire

---

## 6. Typologie des tests

| Type       | Description                       |
| ---------- | --------------------------------- |
| Smoke      | Tests critiques rapides           |
| Regression | Couverture fonctionnelle complète |
| UI         | Vérifications techniques          |
| Quarantine | Tests instables                   |

---

## 7. Installation

```bash
git clone https://github.com/TON-USERNAME/homey-qa-automation.git
cd homey-qa-automation

python -m venv .venv
```

### Activation

#### Windows

```bash
.venv\Scripts\activate
```

#### Mac/Linux

```bash
source .venv/bin/activate
```

### Installation des dépendances

```bash
pip install -r requirements.txt
```

---

## 8. Exécution des tests

### Tous les tests

```bash
robot tests
```

### Par suite

```bash
robot tests/us07_faire_demande_reservation.robot
robot tests/contact_hote.robot
```

### Smoke

```bash
robot --include smoke tests
```

### Regression

```bash
robot --include regression tests
```

### Sans les tests instables

```bash
robot --exclude quarantine tests
```

---

## 9. Reporting Robot Framework

### Fichiers générés

* `report.html` → synthèse
* `log.html` → détail
* `output.xml` → brut

### En cas d’échec

* screenshots
* HTML de la page
* logs détaillés

---

## 10. CI / GitHub Actions

Pipeline situé dans :

```text
.github/workflows/robot.yml
```

### Déclencheurs

* push sur `main` / `develop`
* pull request
* lancement manuel

### Fonctionnement

* démarrage Selenium
* exécution Robot
* génération du report
* upload des artefacts

---

## 11. Reporting avancé

Le projet produit plusieurs niveaux d’analyse :

### 1. Reporting standard

* report.html
* log.html
* output.xml

### 2. Reporting synthétique

* summary.md

### 3. Analyse intelligente

* failure_analysis.json
* test_priorities.json
* notifications.json

---

## 12. Analyse intelligente des tests (IA-ready)

### Analyse automatique des échecs

Classification des erreurs :

* locator cassé
* timeout
* erreur applicative
* erreur de test
* problème d’environnement

### Priorisation intelligente

Score basé sur :

* criticité métier
* historique des échecs
* type de test
* fréquence d’exécution

### Notification ciblée

* QA → erreur de test
* Dev Front → locator cassé
* Dev Back → erreur applicative
* DevOps → problème environnement

---

## 13. Bonnes pratiques appliquées

* séparation des responsabilités
* centralisation des locators
* keywords réutilisables
* gestion robuste des clics
* screenshots en cas d’échec
* CI/CD automatisée
* analyse post-exécution

---

## 14. Limites actuelles

* dépendance à l’environnement
* sélecteurs parfois fragiles
* tests UI sensibles aux changements DOM
* composants dynamiques (calendrier)

---

## 15. Roadmap

### Court terme

* stabilisation complète
* enrichissement des tests
* amélioration des locators

### Moyen terme

* ajout US-08 complet
* amélioration du reporting

### Long terme

* migration Cypress
* IA avancée
* notifications Slack / Teams

---

## 16. Objectif portfolio

Ce projet démontre :

* automatisation de tests fonctionnels
* structuration d’un projet QA
* utilisation du CI/CD
* analyse avancée des résultats
* approche industrielle de la qualité

---

## 17. Auteur

**Maxime Joannis**

QA Automation Engineer en progression
