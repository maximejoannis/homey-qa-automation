# 10 — Couverture par cas passant, non passant et cas d’erreur

## 1. Objet

Ce document complète le référentiel de tests sans inventer de comportement applicatif. Il distingue :

- **cas passant** : le parcours nominal aboutit au résultat métier attendu ;
- **cas non passant** : l’application refuse correctement une action non autorisée ou une donnée fonctionnellement invalide ;
- **cas d’erreur** : une erreur de validation, de session, de données ou d’environnement doit être gérée sans état incohérent.

Un cas n’est déclaré automatisé que lorsqu’un script Playwright correspondant existe dans le dépôt.

## 2. Statuts utilisés

- **Automatisé** : test Playwright présent et exécuté par la suite.
- **Automatisé sous condition** : test présent mais dépendant de secrets ou d’un état d’environnement.
- **Déclaré en `fixme`** : scénario présent dans le code mais volontairement désactivé.
- **Automatisable après observation** : comportement attendu spécifié, mais sélecteurs, messages ou données doivent être observés avant écriture du test.
- **Automatisable avec données maîtrisées** : nécessite des annonces, périodes, capacités ou états connus et réinitialisables.
- **À clarifier** : la règle ou le résultat attendu n’est pas assez précis.
- **Non automatisable durablement actuellement** : l’environnement ne permet pas une exécution répétable.

## 3. Authentification

| ID | Catégorie | Scénario | Résultat attendu factuel | Statut |
|---|---|---|---|---|
| AUTH-P-01 | Passant | Connexion Voyageur avec identifiants valides | Ouverture de session et tableau de bord Voyageur | Automatisé sous condition |
| AUTH-P-02 | Passant | Connexion Hôte avec identifiants valides | Ouverture de session et tableau de bord Hôte | Automatisé sous condition |
| AUTH-P-03 | Passant | Ouverture de la popup | Les fonctions attendues sont visibles | Automatisé |
| AUTH-NP-01 | Non passant | Identifiants invalides | Message d’erreur, popup maintenue, aucune redirection vers le tableau de bord | Automatisé |
| AUTH-NP-02 | Non passant | Mot de passe erroné pour un compte valide | Aucune connexion ; le message ne doit pas divulguer l’existence du compte | Automatisable après observation |
| AUTH-E-01 | Erreur | Soumission avec champs vides | Validation et aucune authentification | Automatisable après observation |
| AUTH-E-02 | Erreur | Identifiant renseigné et mot de passe vide | Validation et aucune authentification | Automatisable après observation |
| AUTH-E-03 | Erreur | Session expirée ou invalide | Retour contrôlé vers l’authentification, sans accès aux zones protégées | À clarifier |
| AUTH-P-04 | Passant | Option « Se souvenir de moi » | Persistance conforme à la durée de session définie | À clarifier |

## 4. Recherche

| ID | Catégorie | Scénario | Résultat attendu factuel | Statut |
|---|---|---|---|---|
| SEARCH-P-01 | Passant | Recherche sans critère | Navigation vers les résultats et présence d’au moins une annonce | Automatisé |
| SEARCH-P-02 | Passant | Ouverture d’une annonce depuis les résultats | La page annonce et son formulaire de réservation s’ouvrent | Automatisé |
| SEARCH-P-03 | Passant | Destination de plus de 20 caractères | La valeur disponible est sélectionnable sans troncature bloquante | Automatisé |
| SEARCH-P-04 | Passant | Recherche par destination connue | Les résultats correspondent à la destination | Automatisable avec données maîtrisées |
| SEARCH-P-05 | Passant | Recherche par période future disponible | Les annonces sont disponibles pendant toute la période | Automatisable avec données maîtrisées |
| SEARCH-P-06 | Passant | Recherche par capacité | Chaque résultat accepte le nombre de voyageurs demandé | Automatisable avec données maîtrisées |
| SEARCH-P-07 | Passant | Recherche avec animal | Chaque résultat autorise les animaux | Automatisable avec données maîtrisées |
| SEARCH-P-08 | Passant | Recherche multicritère | Tous les critères sont appliqués avec une logique ET | Automatisable avec données maîtrisées |
| SEARCH-NP-01 | Non passant | Critères valides sans correspondance | Page de résultats avec état vide, sans annonce hors critères | Automatisable avec données maîtrisées |
| SEARCH-NP-02 | Non passant | Date passée | Date indisponible ou recherche bloquée avec validation | Automatisable après observation |
| SEARCH-NP-03 | Non passant | Date de fin antérieure au début | Recherche bloquée avec validation | Automatisable après observation |
| SEARCH-E-01 | Erreur | Valeur de date malformée ou incohérente | Aucune navigation vers les résultats et erreur explicite | Automatisable après observation |
| SEARCH-E-02 | Erreur | Erreur de chargement des résultats | L’application doit rester dans un état contrôlé | À clarifier |
| SEARCH-P-09 | Passant | Champs de dates disponibles | Les deux champs sont visibles et éditables | Automatisé |

## 5. Réservation

| ID | Catégorie | Scénario | Résultat attendu factuel | Statut |
|---|---|---|---|---|
| BOOK-P-01 | Passant | Voyageur connecté envoie une demande valide | Confirmation côté Voyageur, réservation et message visibles côté Hôte | Déclaré en `fixme` |
| BOOK-P-02 | Passant | Un voyageur avec dates valides et message | Demande autorisée si l’annonce est disponible | Automatisable avec données maîtrisées |
| BOOK-NP-01 | Non passant | Visiteur non connecté tente de finaliser | Authentification demandée ou finalisation bloquée | Automatisé |
| BOOK-NP-02 | Non passant | Zéro voyageur | Demande bloquée avec message de validation | Automatisé sous condition |
| BOOK-NP-03 | Non passant | Date passée | Date non sélectionnable ou rejetée | Automatisé pour la non-sélection dans le calendrier |
| BOOK-NP-04 | Non passant | Date de fin égale au début | Demande bloquée | Automatisable après observation |
| BOOK-NP-05 | Non passant | Date de fin antérieure | Demande bloquée avec validation | Automatisable après observation |
| BOOK-NP-06 | Non passant | Nombre de voyageurs supérieur à la capacité | Demande impossible ou annonce exclue | Automatisable avec données maîtrisées |
| BOOK-NP-07 | Non passant | Message vide | Demande bloquée si le caractère obligatoire est confirmé par l’interface | Automatisable après observation |
| BOOK-NP-08 | Non passant | Période déjà réservée | Aucune seconde réservation concurrente | Automatisable avec environnement réinitialisable |
| BOOK-E-01 | Erreur | Transmission de la demande absente côté Hôte | L’écart doit être remonté comme anomalie ; le test E2E ne peut pas être fiable | Non automatisable durablement actuellement |
| BOOK-E-02 | Erreur | Plus de huit demandes | Aucune limite métier n’étant spécifiée, le blocage constitue une anomalie à confirmer | Non automatisable durablement actuellement |
| BOOK-E-03 | Erreur | Perte de session pendant le parcours | Aucune réservation partielle ou dupliquée | À clarifier |

## 6. Règles d’automatisation

Avant d’ajouter un scénario Playwright :

1. observer le comportement réel sur l’environnement cible ;
2. relever le message, l’URL et l’état de l’interface réellement produits ;
3. confirmer les données nécessaires et leur stabilité ;
4. vérifier que le test est rejouable sans nettoyage manuel ;
5. ajouter le cas dans la matrice avec le chemin du script ;
6. ne pas transformer une question ouverte en assertion.

## 7. Ordre de complétion recommandé

Les prochains cas à automatiser, uniquement après observation, sont :

1. mot de passe erroné pour un compte valide ;
2. champs d’authentification vides ;
3. date de fin antérieure au début dans la recherche ;
4. date de fin égale ou antérieure dans la réservation ;
5. message de réservation vide, si son caractère obligatoire est confirmé.

Les recherches filtrées et les réservations E2E doivent attendre des données de test maîtrisées.
