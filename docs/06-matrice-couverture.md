# Matrice de couverture automatisée — Homey

## Légende

- **Implémenté** : un test automatisé correspondant est présent.
- **Implémenté sous condition** : le test est présent mais nécessite des identifiants ou des données d'environnement.
- **Fixme** : le scénario est déclaré dans la suite mais volontairement non exécuté, avec justification dans le code.
- **Non couvert** : aucun test automatisé correspondant n'est présent.

Les statuts de cette matrice décrivent le code présent. Ils ne constituent pas un résultat d'exécution. Les statuts OK, KO, ignoré ou bloqué doivent provenir d'une campagne datée.

## Couverture présente dans le projet

| Cas | User Story / contrôle | Script | Statut actuel | Observation factuelle |
|---|---|---|---|---|
| TC-US01-AC01-01 | Connexion Voyageur | `tests/us01-authentication/ac01-login.spec.js` | Implémenté sous condition | Nécessite les variables `TRAVELER_USERNAME` et `TRAVELER_PASSWORD`. |
| TC-US01-AC01-02 | Connexion Hôte | `tests/us01-authentication/ac01-login.spec.js` | Implémenté sous condition | Nécessite les variables `HOST_USERNAME` et `HOST_PASSWORD`. |
| TC-US01-AC02-01 | Coordonnées invalides | `tests/us01-authentication/ac01-login.spec.js` | Implémenté | Vérifie le message d'erreur, le maintien de la popup et l'absence de redirection vers le tableau de bord. |
| TC-US01-AC02-02 | Contenu de la popup de connexion | `tests/us01-authentication/ac01-login.spec.js` | Implémenté | Vérifie identifiant, mot de passe, mémorisation, mot de passe oublié et bouton de connexion. |
| TC-US02-AC01-01 | Recherche sans critère | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Implémenté | Vérifie la navigation, la présence du bouton de recherche et d'au moins un résultat. |
| TC-US02-AC02-01 | Ouverture d'une annonce | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Implémenté | Vérifie l'ouverture d'une page contenant le formulaire de réservation. |
| TC-US02-AC03-01 | Champs de dates visibles et éditables | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Implémenté | Vérifie la visibilité et l'éditabilité des champs de dates de la page d'accueil. |
| TC-US02-AC03-02 | Destination de plus de 20 caractères | `tests/us02-recherche/ac01-recherche-simple.spec.js` | Implémenté | Vérifie que la destination longue est effectivement sélectionnée. |
| TC-US03-AC01-01 | Visiteur non connecté bloqué | `tests/us03-reservation/ac01-demande-reservation.spec.js` | Implémenté | Vérifie qu'aucun succès de réservation n'est affiché et que l'authentification est demandée ou que la navigation reste bloquée. |
| TC-US03-AC02-01 | Dates passées non sélectionnables | `tests/us03-reservation/ac01-demande-reservation.spec.js` | Implémenté | Contrôle les dates passées présentées par le calendrier. |
| TC-US03-AC01-02 | Demande de réservation Voyageur connecté | `tests/us03-reservation/ac02-demande-reservation-connecte.auth.spec.js` | Fixme | Le code documente l'anomalie applicative et l'absence d'environnement réinitialisable. |
| TC-US03-AC02-02 | Zéro voyageur refusé | `tests/us03-reservation/ac02-demande-reservation-connecte.auth.spec.js` | Implémenté sous condition | Utilise le `storageState` Voyageur et nécessite ses identifiants. |

## Cas limités ou non automatisables sur l'environnement

| Fonctionnalité | Statut | Justification |
|---|---|---|
| Traitement d'une nouvelle demande côté Hôte après huit demandes déjà traitées | Non automatisable durablement | Au-delà de huit demandes traitées, l'Hôte ne reçoit plus de nouvelle demande. |
| Création d'un autre compte Hôte pour réinitialiser le parcours | Non automatisable | Le site ne permet pas de créer un autre compte Hôte dans le contexte du projet. |
| Nettoyage ou remise à zéro des demandes traitées | Non disponible | Aucun mécanisme de suppression, de réinitialisation ou d'accès au stockage n'est fourni au projet. |

Ces limitations sont des contraintes de testabilité de l'environnement. Elles ne doivent pas être remplacées par des données, comptes, API ou comportements inventés.
