# Catalogue des cas de tests

## Objectif

Ce document recense l'ensemble des cas de tests fonctionnels identifiés pour l'application **Homey**.

Il constitue le référentiel des scénarios de validation indépendamment de leur niveau d'automatisation.

Le statut d'automatisation de chaque scénario est détaillé dans :

- `docs/06-matrice-couverture.md`

Les cas présentés ici sont classés selon trois catégories :

- **Cas passants** : le comportement attendu est conforme au fonctionnement normal de l'application.
- **Cas non passants** : l'application doit refuser l'action ou empêcher la poursuite du processus.
- **Cas d'erreur** : l'application doit gérer une erreur de saisie, une donnée invalide ou une situation exceptionnelle.

---

# 1. Authentification

## Cas passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| AUTH-P-01 | Connexion avec un compte Voyageur valide | L'utilisateur est authentifié et accède à son espace Voyageur. |
| AUTH-P-02 | Connexion avec un compte Hôte valide | L'utilisateur est authentifié et accède à son espace Hôte. |
| AUTH-P-03 | Ouverture de la fenêtre de connexion | Le formulaire de connexion s'affiche avec les champs et actions attendus. |
| AUTH-P-04 | Déconnexion d'un utilisateur authentifié | La session est fermée et l'utilisateur revient à un état non authentifié. |

## Cas non passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| AUTH-NP-01 | Connexion avec un identifiant inexistant | La connexion est refusée. |
| AUTH-NP-02 | Connexion avec un identifiant valide et un mot de passe incorrect | La connexion est refusée. |
| AUTH-NP-03 | Accès à une fonctionnalité protégée sans authentification | L'utilisateur est invité à se connecter ou reste non authentifié. |

## Cas d'erreur

| ID | Scénario | Résultat attendu |
|---|---|---|
| AUTH-E-01 | Soumission du formulaire avec tous les champs vides | Le formulaire n'est pas validé. |
| AUTH-E-02 | Soumission avec l'identifiant vide | Le formulaire n'est pas validé. |
| AUTH-E-03 | Soumission avec le mot de passe vide | Le formulaire n'est pas validé. |
| AUTH-E-04 | Saisie d'un identifiant au format incorrect | Une validation est affichée ou la connexion est refusée (comportement à confirmer). |

---

# 2. Recherche

## Cas passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| SEARCH-P-01 | Recherche sans critère | La liste des annonces disponibles s'affiche. |
| SEARCH-P-02 | Ouverture d'un résultat de recherche | La fiche de l'annonce sélectionnée est affichée. |
| SEARCH-P-03 | Affichage des champs de dates | Les champs de date d'arrivée et de départ sont visibles et éditables. |
| SEARCH-P-04 | Sélection d'une destination disponible | La recherche utilise la destination sélectionnée. |
| SEARCH-P-05 | Saisie d'une destination de plus de vingt caractères prévue par les données existantes | La destination est correctement prise en compte conformément au comportement observé. |

## Cas non passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| SEARCH-NP-01 | Recherche avec une destination ne renvoyant aucun résultat | Aucun résultat pertinent n'est affiché (à confirmer). |
| SEARCH-NP-02 | Recherche avec une date de départ antérieure à la date d'arrivée | La recherche n'est pas validée (comportement à confirmer). |
| SEARCH-NP-03 | Recherche avec des critères incompatibles | Aucun résultat ou blocage fonctionnel. |

## Cas d'erreur

| ID | Scénario | Résultat attendu |
|---|---|---|
| SEARCH-E-01 | Recherche avec une destination vide | Le comportement reste celui d'une recherche sans critère. |
| SEARCH-E-02 | Saisie de caractères spéciaux dans la destination | L'application ne provoque pas d'erreur technique. |
| SEARCH-E-03 | Saisie de valeurs de dates invalides | La recherche ne doit pas être exécutée. |
| SEARCH-E-04 | Indisponibilité du service de recherche | Un message d'erreur devrait être présenté (non automatisable sans simulation). |

---

# 3. Réservation

## Cas passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| BOOK-P-01 | Ouverture d'une annonce disposant d'un formulaire de réservation | Le formulaire est affiché. |
| BOOK-P-02 | Présence des champs nécessaires à la réservation | Les champs de dates et de voyageurs sont disponibles. |
| BOOK-P-03 | Réservation avec des données valides | La réservation est créée (sous réserve d'un environnement réinitialisable). |
| BOOK-P-04 | Réservation par un Voyageur authentifié sur une annonce disponible | La demande de réservation est enregistrée. |

## Cas non passants

| ID | Scénario | Résultat attendu |
|---|---|---|
| BOOK-NP-01 | Tentative de réservation sans authentification | L'utilisateur est invité à se connecter. |
| BOOK-NP-02 | Réservation avec zéro voyageur | La réservation est refusée. |
| BOOK-NP-03 | Réservation avec une date passée | La réservation est refusée. |
| BOOK-NP-04 | Date de départ antérieure à la date d'arrivée | La réservation n'est pas acceptée (comportement à confirmer). |
| BOOK-NP-05 | Réservation d'une annonce indisponible | La réservation est refusée. |

## Cas d'erreur

| ID | Scénario | Résultat attendu |
|---|---|---|
| BOOK-E-01 | Soumission sans dates | La réservation n'est pas créée. |
| BOOK-E-02 | Soumission sans nombre de voyageurs | La réservation n'est pas créée. |
| BOOK-E-03 | Dates d'arrivée et de départ identiques | La réservation est refusée ou bloquée (à confirmer). |
| BOOK-E-04 | Valeur de voyageurs invalide | Le formulaire empêche ou refuse la saisie. |
| BOOK-E-05 | Erreur serveur pendant la réservation | Un message d'erreur devrait être présenté (non testable sans environnement contrôlé). |

---

# Statut des scénarios

Le niveau d'automatisation de chaque cas est documenté dans la matrice de couverture (`docs/06-matrice-couverture.md`).

Les statuts utilisés sont les suivants :

| Statut | Signification |
|---|---|
| Automatisé | Un scénario Playwright correspondant est implémenté et exécutable. |
| Automatisé sous condition | Le scénario est automatisé mais dépend de secrets, d'un état de l'environnement ou de données maîtrisées. |
| Fixme | Le scénario est identifié dans la suite de tests mais volontairement désactivé. |
| Automatisable après observation | Le comportement doit être observé avant d'être automatisé. |
| Automatisable avec données maîtrisées | Une automatisation est possible avec un jeu de données stable ou réinitialisable. |
| À clarifier | Une règle métier ou un résultat attendu reste à définir. |
| Non automatisable durablement actuellement | Les contraintes techniques ou fonctionnelles empêchent une automatisation fiable et répétable. |
