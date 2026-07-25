# 02 — Stratégie de test

## 1. Finalité

La stratégie applique une approche **basée sur les risques**, alignée sur les principes ISTQB, avec priorité aux parcours métier P1 : recherche et réservation.

## 2. Niveaux de test

| Niveau | Objectif | Responsabilité principale |
|---|---|---|
| Composant | Vérifier les règles unitaires de validation et de filtrage | Développement |
| Intégration | Vérifier les échanges entre recherche, annonces, comptes, réservations et messages | Développement + QA |
| Système | Vérifier les stories sur l’application déployée | QA |
| Acceptation | Confirmer l’adéquation aux critères métier | PO + QA |

Les cas du présent dossier ciblent principalement le **test système fonctionnel**, complété par des scénarios E2E.

## 3. Types de test

- tests fonctionnels positifs ;
- tests négatifs ;
- tests de limites ;
- tests de transitions d’état ;
- tests de tables de décision ;
- tests E2E inter-profils ;
- tests de régression ;
- contrôles exploratoires ;
- contrôles élémentaires d’utilisabilité et d’accessibilité des formulaires ;
- contrôles de compatibilité ciblés Chromium, Firefox et WebKit après stabilisation.

## 4. Priorisation

### P1 — Critique pour la valeur métier

- recherche sans critère ;
- recherche par destination, dates et voyageurs ;
- rejet des dates invalides ;
- réservation par Voyageur connecté ;
- refus de finalisation par visiteur ;
- création de la réservation chez l’Hôte ;
- création et visibilité du message chez l’Hôte ;
- blocage de la période réservée ;
- comportement autour et au-delà de la 8e demande.

### P2 — Important

- connexion Voyageur ;
- connexion Hôte ;
- identifiants invalides ;
- présence des rubriques de tableau de bord ;
- accès via les deux menus.

## 5. Techniques de conception ISTQB

| Technique | Utilisation |
|---|---|
| Partition d’équivalence | identifiants valides/invalides, destination connue/inconnue, voyageurs valides/invalides |
| Analyse des valeurs limites | 0, 1 et nombres élevés de voyageurs ; dates aujourd’hui, hier et demain ; 7e, 8e et 9e demandes |
| Table de décision | combinaison destination, dates, capacité et animaux |
| Transition d’état | visiteur → popup de connexion → Voyageur connecté → demande envoyée |
| Cas d’utilisation | parcours complets de recherche, connexion et réservation |
| Tests basés sur l’expérience | sélecteurs instables, calendrier, messages non visibles, données saturées |

## 6. Approche manuelle et automatisée

### Automatisation prioritaire

À automatiser en premier :

- smoke test de recherche sans critère ;
- connexion réussie Voyageur et Hôte ;
- connexion refusée ;
- contrôles de dates ;
- réservation Voyageur connectée avec vérification Hôte ;
- visiteur empêché de finaliser ;
- test de non-régression sur la limite de 8 ;
- non-disponibilité d’une période déjà réservée.

### Maintien manuel ou exploratoire initial

- survol d’annonce et synchronisation de la carte ;
- rendu visuel de la page de résultats ;
- menus apparaissant au survol du nom ;
- qualité des messages de confirmation et d’erreur ;
- récupération de mot de passe si aucun environnement email contrôlable n’est disponible.

## 7. Architecture Playwright recommandée

```text
playwright/
├── tests/
│   ├── auth/
│   │   ├── login-traveler.spec.ts
│   │   ├── login-host.spec.ts
│   │   └── login-invalid.spec.ts
│   ├── search/
│   │   ├── search-empty.spec.ts
│   │   ├── search-filters.spec.ts
│   │   └── search-validation.spec.ts
│   └── booking/
│       ├── booking-authenticated.spec.ts
│       ├── booking-visitor.spec.ts
│       ├── booking-availability.spec.ts
│       └── booking-limit.spec.ts
├── pages/
│   ├── home.page.ts
│   ├── login.modal.ts
│   ├── results.page.ts
│   ├── listing.page.ts
│   └── dashboard.page.ts
├── fixtures/
│   ├── users.ts
│   └── dates.ts
└── utils/
    └── test-data.ts
```

## 8. Règles d’automatisation

- un test valide un objectif principal ;
- les préconditions sont explicites ;
- les dates sont calculées dynamiquement ;
- aucun mot de passe n’est stocké dans le dépôt ;
- les sélecteurs fondés sur la position sont interdits sauf absence d’alternative documentée ;
- chaque action critique est suivie d’une assertion ;
- les tests doivent être indépendants et réexécutables ;
- le nettoyage ou la génération de données doit être automatisé autant que possible ;
- les traces, captures et vidéos sont conservées uniquement en cas d’échec ;
- les tests instables ne sont pas simplement relancés pour masquer un défaut.

## 9. Données de test

### Comptes

- `TRAVELER_VALID` : Voyageur actif ;
- `HOST_VALID` : Hôte actif propriétaire d’au moins une annonce ;
- `USER_INVALID` : identifiants inexistants ;
- aucun nouveau compte Hôte ne doit être requis tant que AK-02 n’est pas corrigée.

### Annonces

Prévoir idéalement :

- une annonce disponible, capacité ≥ 4, animaux autorisés ;
- une annonce capacité faible ;
- une annonce animaux interdits ;
- une annonce avec période indisponible ;
- une destination de plus de 20 caractères ;
- une destination sans résultat.

### Réservations

- utiliser des dates futures uniques ;
- suivre le compteur de demandes existantes ;
- disposer d’un mécanisme de purge ou d’un environnement réinitialisable ;
- réserver des jeux spécifiques pour les tests 7, 8 et 9 demandes.

## 10. Gestion des environnements

- URL paramétrée via `BASE_URL` ;
- comptes via variables d’environnement ;
- horloge et fuseau connus ;
- données initiales versionnées ou documentées ;
- remise à zéro avant une campagne complète ;
- interdiction d’exécuter en parallèle les tests consommant la même annonce si le nettoyage n’est pas fiable.

## 11. Navigateurs et plateformes

Phase initiale :

- Chromium desktop, résolution standard ;
- extension à Firefox et WebKit après stabilisation des scénarios P1.

## 12. Gestion des résultats

Chaque test doit produire :

- statut : réussi, échoué, bloqué ou non exécuté ;
- environnement et version ;
- données utilisées ;
- trace Playwright en cas d’échec ;
- capture d’écran pertinente ;
- lien vers l’anomalie lorsqu’un écart produit est identifié.

## 13. Stratégie face aux anomalies connues

### Limite de 8 demandes

Concevoir trois tests distincts :

- demande n°7 : doit réussir ;
- demande n°8 : doit réussir si aucune limite n’est prévue ;
- demande n°9 : doit également réussir si aucune limite métier n’est prévue.

Tout blocage non spécifié est un défaut. La campagne doit toutefois éviter de rendre tous les tests suivants inexploitables : exécution séquentielle, nettoyage, ou environnement dédié.

### Création de compte Hôte impossible

Ne pas bloquer tout le projet QA. Utiliser un Hôte existant, tout en enregistrant l’anomalie et le risque de dépendance aux données partagées.

### Messages Voyageur invisibles par l’Hôte

Le scénario de réservation n’est pas considéré réussi si seule la réservation apparaît. Les deux effets métier sont obligatoires : réservation et message.

## 14. Critères de suspension et reprise

### Suspension

- environnement indisponible ;
- données corrompues ;
- aucun compte Hôte ou Voyageur exploitable ;
- aucune annonce disponible ;
- saturation à 8 réservations sans possibilité de remise à zéro ;
- défaut bloquant empêchant l’accès à une fonctionnalité P1.

### Reprise

- environnement rétabli ;
- données réinitialisées ;
- correctif déployé et version communiqué ;
- préconditions de test à nouveau disponibles.
