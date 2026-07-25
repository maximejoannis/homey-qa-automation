# Homey QA Automation

[![Playwright Tests](https://github.com/maximejoannis/homey-qa-automation/actions/workflows/playwright.yml/badge.svg)](https://github.com/maximejoannis/homey-qa-automation/actions/workflows/playwright.yml)

Rapport Allure publié : https://maximejoannis.github.io/homey-qa-automation
Suite de tests end-to-end du site **Homey** réalisée avec **Playwright**, structurée selon une approche ISTQB et calquée sur l’architecture du projet SauceDemo de référence.

## Couverture

- US01 — Se connecter : Voyageur, Hôte, identifiants invalides et contenu de la popup ;
- US02 — Réaliser une recherche simple : recherche sans critère, ouverture d’une annonce, contrôles de dates et destination longue ;
- US03 — Faire une demande de réservation : visiteur bloqué, contrôle des dates passées et refus de zéro voyageur. Le scénario de demande valide avec un Voyageur connecté est déclaré `fixme` jusqu'à ce que ses préconditions soient rejouables.

## Prérequis

- Node.js 18+ ;
- npm ;
- accès au site `http://livraison3.testacademy.fr/` ;
- identifiants Hôte pour les scénarios associés.

## Installation

```bash
npm ci
npx playwright install chromium firefox
```

Copier `.env.example` vers `.env` ou définir les variables dans le terminal.
Les scénarios nécessitant un compte sont ignorés lorsque les variables correspondantes ne sont pas définies. Aucun identifiant réel n'est fourni par défaut dans le code.

## Exécution

```bash
npm test
npm run test:chromium
npm run test:headed
npm run test:ui
npm run test:smoke
npm run test:critical
npm run results:clean
npx playwright test --workers=2 --retries=1
```

## Rapports

```bash
npm run report
npm run allure:generate
npm run allure:open
```

## Architecture

```text
.
├── .github/workflows/playwright.yml
├── docs/
├── src/
│   ├── data/
│   ├── fixtures/
│   └── pages/
├── playwright/.auth/        # généré, non versionné
├── tests/
│   ├── auth.setup.js
│   ├── us01-authentication/
│   ├── us02-recherche/
│   └── us03-reservation/  # tests visiteur et authentifié séparés
├── .env.example
├── package.json
└── playwright.config.js
```

## Convention d’identification

```text
TC-USxx-ACxx-nn
```

## Données et limites connues

- les identifiants Voyageur et Hôte doivent être fournis par variables d’environnement ;
- le site ne permet pas actuellement de créer librement de nouveaux comptes Hôte, ce qui limite l’isolation des données ;
- la suite s’exécute avec un seul worker pour éviter les collisions de réservations sur un environnement partagé ;
- un `storageState` Voyageur est généré par `tests/auth.setup.js` et réutilisé uniquement par le scénario authentifié ;
- aucun nettoyage des demandes n'est annoncé : le site ne fournit pas de mécanisme de suppression ou de remise à zéro accessible au projet ;
- après huit demandes traitées, l'Hôte ne reçoit plus de nouvelle demande et aucun autre compte Hôte ne peut être créé.

## Résultats de campagne

Les résultats présents dans un rapport doivent être rattachés à une exécution datée. La commande `npm run results:clean` supprime les résultats générés précédemment avant une nouvelle campagne.

Le dépôt ne présente pas les résultats historiques cumulés comme le statut courant de la suite.
## Configuration GitHub

Dans **Settings → Secrets and variables → Actions**, créer les secrets de dépôt suivants :

- `BASE_URL`
- `TRAVELER_USERNAME`
- `TRAVELER_PASSWORD`
- `HOST_USERNAME`
- `HOST_PASSWORD`
- `TEST_DESTINATION`

Créer également la variable de dépôt `TEST_LISTING_INDEX` (valeur recommandée : `0`).

Dans **Settings → Pages**, sélectionner **GitHub Actions** comme source de publication. Le workflow exécute Chromium, génère les rapports Playwright et Allure, conserve les artefacts 30 jours et publie Allure sur GitHub Pages pour les push sur `main` et les lancements manuels.

> Le fichier `.env` est strictement local et ignoré par Git. Ne jamais le committer. Si des identifiants ont déjà été publiés, les révoquer ou les changer immédiatement.
