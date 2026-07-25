# 01 — Cadrage QA

## 1. Objet

Ce document définit le périmètre, les objectifs, les hypothèses, les risques et les responsabilités QA pour la validation du site **Homey** accessible à l’adresse `http://livraison3.testacademy.fr/`.

Le cadrage couvre les fonctionnalités prioritaires suivantes :

- **P1 — Réaliser une recherche simple** ;
- **P1 — Faire une demande de réservation** ;
- **P2 — Se connecter**.

Les livrables traités dans cette première phase sont :

1. `01-cadrage-qa.md` ;
2. `02-strategie-de-test.md` ;
3. `03-user-stories.md` ;
4. `04-criteres-acceptation.md` ;
5. `05-cas-de-tests-istqb.md`.

Les livrables `06-matrice-couverture.md` à `09-readme-qa.md` sont différés.

## 2. Objectifs qualité

La campagne doit permettre de vérifier que :

- un visiteur peut rechercher des annonces avec zéro, un ou plusieurs critères ;
- les règles de validation des dates et des voyageurs sont respectées ;
- un utilisateur disposant d’un compte peut se connecter selon son profil ;
- un Voyageur connecté peut envoyer une demande de réservation valide ;
- un visiteur non connecté ne peut pas finaliser une réservation ;
- une demande valide crée une réservation et un message côté Hôte ;
- une période réservée devient indisponible pour les autres réservations ;
- les menus et rubriques des tableaux de bord correspondent au profil connecté.

## 3. Périmètre fonctionnel

### Inclus

- page d’accueil et barre de recherche ;
- page de résultats et ouverture d’une annonce ;
- formulaire de connexion dans une popup ;
- authentification Voyageur et Hôte ;
- validation des identifiants invalides ;
- formulaire de demande de réservation ;
- contrôles de dates, nombre de voyageurs et message à l’Hôte ;
- contrôle du blocage des périodes réservées ;
- visibilité des réservations et messages dans le tableau de bord Hôte ;
- accès aux rubriques via menu latéral et menu utilisateur ;
- contrôles de régression liés aux anomalies connues.

### Exclus de cette phase

- paiement réel et intégration d’une passerelle bancaire ;
- tests de charge à grande échelle ;
- audit de sécurité complet ;
- compatibilité exhaustive sur tous navigateurs et appareils ;
- création d’annonce détaillée, sauf précondition nécessaire à la réservation ;
- création de compte Hôte, connue comme non fonctionnelle ;
- production des livrables 06 à 09.

## 4. Base de test

La base de test est constituée de :

- trois user stories fournies : recherche, connexion et réservation ;
- leurs critères d’acceptation ;
- les anomalies connues communiquées ;
- le script Playwright enregistré `example.spec.js` ;
- l’application déployée dans l’environnement de test.

## 5. Anomalies connues et contraintes

| ID | Constat | Impact QA | Décision de traitement |
|---|---|---|---|
| AK-01 | Impossible d’aller au-delà de 8 demandes de réservation, côté demande et côté traitement | Bloque les scénarios de répétition, de volume et potentiellement les tests E2E après plusieurs exécutions | Isoler les données, réinitialiser l’environnement si possible, documenter le seuil et créer une anomalie bloquante/majeure |
| AK-02 | Impossible de créer d’autres comptes Hôte | Empêche l’indépendance complète des tests et la création dynamique des préconditions | Utiliser un compte Hôte existant et protéger ses données ; prévoir une remise à zéro |
| AK-03 | Les messages du Voyageur ne sont pas visibles par l’Hôte | Échec direct d’un critère d’acceptation P1 | Considérer le scénario E2E de réservation comme échoué même si la réservation est créée |

## 6. Analyse du script Playwright fourni

Le script constitue une trace de parcours, pas encore un test automatisé industrialisé.

### Points positifs

- il démontre l’accès à la recherche, à une annonce, au calendrier, aux voyageurs et à la réservation ;
- il couvre le comportement d’un visiteur redirigé vers la connexion ;
- il montre un second parcours après authentification.

### Limites

- absence totale d’assertions `expect` ;
- nom de test non descriptif : `test` ;
- plusieurs scénarios et stories dans un seul test ;
- dates choisies par position dans le calendrier, donc dépendantes du mois courant ;
- sélecteurs structurels fragiles : `nth-child`, `nth`, boutons sans nom ;
- identifiants codés en dur ;
- aucune gestion des données ni nettoyage ;
- aucun contrôle explicite de la réservation ou du message côté Hôte ;
- aucune vérification d’erreur de connexion ;
- aucune vérification de filtrage des résultats.

### Orientation recommandée

- découper par story et par scénario ;
- utiliser un modèle Page Object ou des fixtures lisibles ;
- générer les dates relativement à la date du jour ;
- privilégier `getByRole`, `getByLabel`, `getByTestId` et des noms accessibles stables ;
- ajouter des assertions métier à chaque étape clé ;
- rendre les tests indépendants, répétables et nettoyables ;
- taguer les tests par priorité et niveau : `@smoke`, `@p1`, `@e2e`, `@negative`.

## 7. Parties prenantes

| Rôle | Responsabilités |
|---|---|
| Product Owner | Clarifier les règles métier et arbitrer les écarts |
| Développeur | Corriger les anomalies et fournir les éléments techniques nécessaires |
| QA | Concevoir, exécuter, automatiser, documenter et analyser les résultats |
| Administrateur environnement | Réinitialiser les données et maintenir la disponibilité de l’environnement |

## 8. Hypothèses

- au moins un compte Voyageur et un compte Hôte valides sont disponibles ;
- au moins une annonce publiée appartient au compte Hôte utilisé ;
- l’environnement permet d’identifier une réservation créée ;
- les dates disponibles peuvent être déterminées dynamiquement ;
- les données de test peuvent être réinitialisées ou nettoyées ;
- la règle fonctionnelle attendue ne prévoit pas une limite métier de 8 réservations, sauf clarification contraire.

## 9. Risques produit

| Risque | Probabilité | Impact | Niveau |
|---|---:|---:|---:|
| Réservation créée sans message Hôte | Élevée | Critique | Critique |
| Blocage après 8 demandes | Élevée | Élevé | Critique |
| Dates invalides acceptées | Moyenne | Élevé | Élevé |
| Mauvais filtrage des annonces | Moyenne | Élevé | Élevé |
| Visiteur non connecté pouvant finaliser | Faible à moyenne | Critique | Élevé |
| Mauvaise redirection selon le profil | Moyenne | Moyen | Moyen |
| Tests instables à cause du calendrier et des sélecteurs | Élevée | Moyen | Élevé |

## 10. Critères d’entrée

- environnement accessible ;
- comptes de test disponibles ;
- annonce Hôte publiée et réservable ;
- identifiants de test sécurisés dans des variables d’environnement ;
- Playwright installé et exécutable ;
- comportement attendu de la limite de 8 clarifié ou anomalie acceptée.

## 11. Critères de sortie

Pour cette première phase documentaire :

- stories normalisées et testables ;
- critères d’acceptation non ambigus autant que possible ;
- cas de test couvrant les scénarios positifs, négatifs et limites ;
- anomalies connues intégrées à la stratégie ;
- aucune contradiction majeure non signalée.

Pour une future campagne d’exécution :

- 100 % des tests P1 exécutés ;
- aucun défaut critique ou bloquant ouvert ;
- taux de réussite P1 conforme à la décision de release ;
- résultats et preuves disponibles ;
- anomalies connues reliées aux cas échoués.
