# Remplacement du dépôt cible

Le contenu de cette archive est prêt à remplacer entièrement le dépôt `maximejoannis/homey-qa-automation`.

## 1. Configurer les secrets avant le premier pipeline

Dans GitHub : **Settings → Secrets and variables → Actions → New repository secret**.

Créer : `BASE_URL`, `TRAVELER_USERNAME`, `TRAVELER_PASSWORD`, `HOST_USERNAME`, `HOST_PASSWORD`, `TEST_DESTINATION`.

Créer dans l’onglet **Variables** : `TEST_LISTING_INDEX=0`.

## 2. Activer GitHub Pages

Dans **Settings → Pages → Build and deployment → Source**, choisir **GitHub Actions**.

## 3. Remplacer tout le contenu distant

Depuis ce dossier :

```bash
git init
git branch -M main
git add .
git commit -m "feat: replace project with Homey Playwright QA automation"
git remote add origin https://github.com/maximejoannis/homey-qa-automation.git
git push --force origin main
```

Le `--force` remplace l’historique visible de la branche `main`. Il ne supprime pas automatiquement d’autres branches ou tags distants.

## 4. Vérifier

- Onglet **Actions** : workflow `Playwright Tests` réussi ;
- Onglet **Actions** : artefacts `playwright-report`, `allure-results`, `allure-report` ;
- Pages : `https://maximejoannis.github.io/homey-qa-automation`.

## Sécurité

Le `.env`, les rapports, les résultats, les vidéos, captures et états d’authentification ne sont pas inclus. Si le `.env` ou un état de session a déjà été poussé dans un dépôt public, changer les mots de passe concernés ; les retirer du dernier commit ne suffit pas à annuler leur exposition passée.
