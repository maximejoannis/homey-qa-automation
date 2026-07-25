# Homey QA Automation

[![Playwright Tests](https://github.com/maximejoannis/homey-qa-automation/actions/workflows/playwright.yml/badge.svg)](https://github.com/maximejoannis/homey-qa-automation/actions/workflows/playwright.yml)

Suite de tests End-to-End réalisée avec **Playwright** selon une approche **Page Object Model (POM)** et conforme aux bonnes pratiques **ISTQB**.

Le projet automatise les principaux parcours utilisateurs de Homey, met en œuvre une intégration continue avec **GitHub Actions** et publie automatiquement les rapports **Allure** sur **GitHub Pages**.

---

# Rapport Allure

Le rapport est publié automatiquement après chaque exécution du pipeline sur la branche `main`.

**URL :**

https://maximejoannis.github.io/homey-qa-automation/

---

# Fonctionnalités couvertes

## US01 — Authentification

Couverture actuelle :

* connexion Voyageur ;
* connexion Hôte ;
* identifiants invalides ;
* vérification du contenu de la fenêtre de connexion.

## US02 — Recherche

Couverture actuelle :

* recherche sans critère ;
* ouverture d'une annonce ;
* contrôle des champs de dates ;
* validation d'une destination longue.

## US03 — Réservation

Couverture actuelle :

* visiteur non authentifié ;
* contrôle des dates passées ;
* refus d'une réservation avec zéro voyageur.

Le scénario de réservation valide avec un Voyageur authentifié est volontairement déclaré `test.fixme()` car il dépend d'un environnement partagé dont les données ne sont pas réinitialisées automatiquement.

---

# Stratégie de test

Les cas de tests sont organisés selon une approche ISTQB :

* cas passants ;
* cas non passants ;
* cas d'erreur.

La documentation distingue également :

* les scénarios automatisés ;
* les scénarios automatisables ;
* les scénarios nécessitant une validation fonctionnelle ;
* les scénarios dépendant de données non maîtrisées.

---

# Architecture du projet

```text
.
├── .github/
│   └── workflows/
│       └── playwright.yml
├── docs/
├── src/
│   ├── data/
│   ├── fixtures/
│   └── pages/
├── tests/
│   ├── auth.setup.js
│   ├── us01-authentication/
│   ├── us02-recherche/
│   └── us03-reservation/
├── playwright.config.js
├── package.json
├── .env.example
└── README.md
```

---

# Technologies

* Playwright
* JavaScript
* Node.js
* GitHub Actions
* Allure Report
* GitHub Pages

---

# Installation

```bash
npm ci
npx playwright install
```

---

# Configuration

Créer un fichier `.env` à partir de `.env.example` pour une exécution locale.

En intégration continue, les variables sont fournies par les **GitHub Secrets**.

Secrets utilisés :

* `BASE_URL`
* `TRAVELER_USERNAME`
* `TRAVELER_PASSWORD`
* `HOST_USERNAME`
* `HOST_PASSWORD`

Variable GitHub :

* `TEST_LISTING_INDEX`

Aucun identifiant n'est stocké dans le dépôt.

---

# Exécution des tests

Suite complète :

```bash
npm test
```

Chromium :

```bash
npm run test:chromium
```

Mode UI :

```bash
npm run test:ui
```

Mode Headed :

```bash
npm run test:headed
```

Tests Smoke :

```bash
npm run test:smoke
```

Tests Critical :

```bash
npm run test:critical
```

---

# Rapports

Rapport Playwright :

```bash
npm run report
```

Rapport Allure :

```bash
npm run allure:generate
npm run allure:open
```

---

# Intégration Continue

À chaque Push ou Pull Request sur `main`, GitHub Actions :

1. installe les dépendances ;
2. installe Playwright ;
3. exécute les tests ;
4. génère les rapports Playwright et Allure ;
5. publie le rapport Allure sur GitHub Pages ;
6. archive les rapports en artefacts GitHub.

---

# Documentation

Le dossier `docs/` contient notamment :

* stratégie de test ;
* User Stories ;
* critères d'acceptation ;
* cas de tests ISTQB ;
* matrice de couverture ;
* rapport d'exécution ;
* classification des cas passants, non passants et d'erreur.

---

## Données et limites connues

- les identifiants Voyageur et Hôte doivent être fournis par variables d’environnement ;
- le site ne permet pas actuellement de créer librement de nouveaux comptes Hôte, ce qui limite l’isolation des données ;
- la suite s’exécute avec un seul worker pour éviter les collisions de réservations sur un environnement partagé ;
- un `storageState` Voyageur est généré par `tests/auth.setup.js` et réutilisé uniquement par le scénario authentifié ;
- aucun nettoyage des demandes n'est annoncé : le site ne fournit pas de mécanisme de suppression ou de remise à zéro accessible au projet ;
- après huit demandes traitées, l'Hôte ne reçoit plus de nouvelle demande et aucun autre compte Hôte ne peut être créé.

---

# Auteur

Projet réalisé dans le cadre d'une démarche QA Automation avec Playwright, en appliquant les bonnes pratiques de structuration, d'automatisation et de documentation inspirées de l'ISTQB.
