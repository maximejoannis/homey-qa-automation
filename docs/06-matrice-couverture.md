# Matrice de couverture automatisée — Homey

## Légende

- **Automatisé** : un test Playwright correspondant est présent.
- **Automatisé sous condition** : le test est présent mais dépend de secrets ou d’un état d’environnement.
- **Fixme** : scénario déclaré dans la suite mais volontairement non exécuté.
- **Automatisable après observation** : résultat attendu défini, mais comportement réel et sélecteurs à relever avant implémentation.
- **Automatisable avec données maîtrisées** : nécessite un jeu de données stable ou réinitialisable.
- **À clarifier** : règle ou résultat attendu insuffisamment défini.
- **Non automatisable durablement actuellement** : l’environnement empêche une exécution répétable.

Les statuts décrivent le code et la testabilité. Ils ne constituent pas un résultat d’exécution.

## 1. Authentification

| Référence | Catégorie | Script | Statut | Observation |
|---|---|---|---|---|
| TC-AUTH-001 | Passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé | Vérifie la présence des fonctions attendues dans la popup de connexion. |
| TC-AUTH-002 / TC-AUTH-003 | Passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé sous condition | Connexion et vérification des rubriques Voyageur ; secrets `TRAVELER_USERNAME` et `TRAVELER_PASSWORD` requis. |
| TC-AUTH-004 / TC-AUTH-005 | Passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé sous condition | Connexion et vérification des rubriques Hôte ; secrets `HOST_USERNAME` et `HOST_PASSWORD` requis. |
| TC-AUTH-006 | Non passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé | Vérifie le refus de connexion pour un identifiant inexistant, le message `Invalid username or email` et l’absence de redirection vers le tableau de bord. |
| TC-AUTH-007 | Non passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé sous condition | Vérifie le refus de connexion avec un identifiant Voyageur valide et un mot de passe erroné, ainsi que le message d’erreur correspondant ; `TRAVELER_USERNAME` requis. |
| TC-AUTH-008 | Erreur | `tests/us01-authentication/ac01-login.spec.js` | Fixme | Scénario déclaré mais non exécuté ; le comportement exact des champs vides doit être observé avant activation. |
| TC-AUTH-009 | Passant | `tests/us01-authentication/ac01-login.spec.js` | Fixme | Scénario déclaré mais non exécuté ; la règle de persistance de l’option « Se souvenir de moi » reste à clarifier. |
| TC-AUTH-010 | Passant | `tests/us01-authentication/ac01-login.spec.js` | Automatisé sous condition | Vérifie la déconnexion d’un Voyageur authentifié ; secrets `TRAVELER_USERNAME` et `TRAVELER_PASSWORD` requis. |

## 2. Recherche

| Référence | Catégorie | Script | Statut | Observation |
|---|---|---|---|---|
| TC-SEARCH-001 | Passant | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Automatisé | Vérifie navigation et présence d’au moins un résultat. |
| TC-SEARCH-002 | Passant | — | Automatisable avec données maîtrisées | Il faut connaître une destination et les annonces attendues. |
| TC-SEARCH-003 | Passant / limite | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Automatisé | Vérifie la sélection d’une destination de plus de 20 caractères. |
| TC-SEARCH-004 | Non passant | — | Automatisable après observation | Message et comportement exacts non relevés dans le code. |
| TC-SEARCH-005 | Non passant | — | Automatisable après observation | Validation de dates incohérentes à observer. |
| TC-SEARCH-006 | Passant | — | Automatisable avec données maîtrisées | Disponibilités connues nécessaires. |
| TC-SEARCH-007 / 008 | Passant / non passant | — | Automatisable avec données maîtrisées | Capacités des annonces nécessaires. |
| TC-SEARCH-009 | Passant | — | Automatisable avec données maîtrisées | Règle animaux et annonces correspondantes nécessaires. |
| TC-SEARCH-010 | Passant | — | Automatisable avec données maîtrisées | Jeu de données permettant de vérifier la logique ET nécessaire. |
| TC-SEARCH-011 | Non passant | — | Automatisable avec données maîtrisées | Combinaison valide sans résultat nécessaire. |
| TC-SEARCH-012 | Erreur | — | Automatisable après observation | Valeur invalide et message exacts à relever. |
| TC-SEARCH-013 | Passant | — | Automatisable après observation | Valeurs rappelées et sélecteurs à relever. |
| TC-SEARCH-014 | Interface | — | Automatisation partielle | Contrôle visuel ou comparaison de disposition recommandé. |
| TC-SEARCH-015 | Passant | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Partiellement automatisé | L’ouverture est couverte ; la mise en évidence cartographique ne l’est pas. |
| Contrôle des champs de dates | Passant | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Automatisé | Visibilité et éditabilité des deux champs. |

## 3. Réservation

| Référence | Catégorie | Script | Statut | Observation |
|---|---|---|---|---|
| TC-BOOK-001 | Passant | `tests/us03-reservation/ac02-demande-reservation-connecte.auth.spec.js` | Fixme | Transmission côté Hôte et réinitialisation de l’environnement indisponibles. |
| TC-BOOK-002 | Non passant | `tests/us03-reservation/ac01-demande-reservation.spec.js` | Automatisé | Un visiteur ne peut pas finaliser. |
| TC-BOOK-003 | Passant / transition | — | À clarifier | Reprise des données après connexion non définie. |
| TC-BOOK-004 | Non passant | `tests/us03-reservation/ac01-demande-reservation.spec.js` | Automatisé | Vérifie que les dates passées ne sont pas proposées. |
| TC-BOOK-005 | Non passant | — | Automatisable après observation | Comportement date égale à confirmer sur l’interface. |
| TC-BOOK-006 | Non passant | — | Automatisable après observation | Message et blocage exacts à observer. |
| TC-BOOK-007 | Non passant | `tests/us03-reservation/ac02-demande-reservation-connecte.auth.spec.js` | Automatisé sous condition | Storage state Voyageur et secrets requis. |
| TC-BOOK-008 | Passant | — | Automatisable avec données maîtrisées | Période disponible et annonce stable nécessaires. |
| TC-BOOK-009 | Non passant | — | Automatisable avec données maîtrisées | Capacité connue nécessaire. |
| TC-BOOK-010 | Non passant | — | Automatisable après observation | Caractère obligatoire du message à confirmer par l’interface. |
| TC-BOOK-011 | Non passant / état | — | Automatisable avec environnement réinitialisable | Nécessite deux comptes et une période maîtrisée. |
| TC-BOOK-012 à 014 | Passant / navigation | — | Automatisable après observation | Menus et sélecteurs Hôte à relever. |
| TC-BOOK-015 à 018 | Erreur / régression | — | Non automatisable durablement actuellement | État persistant et limite observée au-delà de huit demandes. |
| TC-BOOK-019 | Erreur / E2E | — | Non automatisable durablement actuellement | Anomalie connue de visibilité du message côté Hôte. |

## 4. Synthèse quantitative du dépôt

| Module | Tests Playwright exécutables déclarés | Tests conditionnels | Tests `fixme` |
|---|---:|---:|---:|
| Authentification | 2 | 4 | 2 |
| Recherche | 4 | 0 | 0 |
| Réservation | 2 | 1 | 1 |
| Setup d’authentification | 0 | 1 | 0 |

La commande Playwright peut compter les projets navigateurs séparément. Cette synthèse compte les scénarios sources, pas leurs déclinaisons par projet.

## 5. Contraintes de testabilité

| Contrainte | Effet |
|---|---|
| Pas de remise à zéro des réservations | Les scénarios de création ne sont pas répétables durablement. |
| Pas de création d’un nouvel Hôte | Impossible d’isoler les campagnes avec un compte neuf. |
| Blocage observé au-delà de huit demandes | Les tests de limite consomment l’état et ne peuvent pas être rejoués proprement. |
| Message Voyageur absent côté Hôte | Le parcours E2E attendu ne peut pas être validé de manière fiable. |
| Données de recherche non contractualisées | Les filtres ne peuvent pas être vérifiés précisément sans annonces connues. |
