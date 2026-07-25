# 05 — Cas de tests ISTQB

## 1. Conventions

- **P1** : priorité critique ; **P2** : priorité importante.
- Type : positif, négatif, limite, E2E, régression, interface.
- Les résultats attendus sont formulés indépendamment de l’implémentation.
- Les dates `J+n` sont calculées à partir du jour d’exécution.

## 2. Cas de test — Recherche

### TC-SEARCH-001 — Recherche sans critère

- **Priorité** : P1
- **Type** : positif, smoke
- **Préconditions** : au moins une annonce publiée.
- **Étapes** :
  1. Ouvrir la page d’accueil.
  2. Ne renseigner aucun critère.
  3. Cliquer sur « Chercher ».
- **Résultat attendu** : la page de résultats s’affiche et contient toutes les annonces publiées.
- **Automatisation** : Oui.

### TC-SEARCH-002 — Recherche par destination valide

- **Priorité** : P1
- **Type** : partition d’équivalence positive
- **Données** : commune contenant des annonces.
- **Étapes** : saisir la commune puis rechercher.
- **Résultat attendu** : toutes les annonces affichées appartiennent à la commune recherchée.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-003 — Destination supérieure à 20 caractères

- **Priorité** : P2
- **Type** : limite
- **Données** : nom de commune ou texte valide de 21 caractères ou plus.
- **Résultat attendu** : la saisie est acceptée sans troncature bloquante et la recherche peut être lancée.
- **Automatisation** : Oui.

### TC-SEARCH-004 — Date de début passée

- **Priorité** : P1
- **Type** : négatif, limite
- **Données** : `J-1`.
- **Étapes** : tenter de sélectionner ou saisir `J-1` comme date de début.
- **Résultat attendu** : la date est indisponible ou rejetée ; la recherche n’est pas lancée ; un message de validation est visible.
- **Automatisation** : Automatisable après observation du contrôle et du message.

### TC-SEARCH-005 — Date de fin antérieure à la date de début

- **Priorité** : P1
- **Type** : négatif
- **Données** : début `J+10`, fin `J+5`.
- **Résultat attendu** : la recherche est bloquée avec un message explicite.
- **Automatisation** : Automatisable après observation du contrôle et du message.

### TC-SEARCH-006 — Recherche par période disponible

- **Priorité** : P1
- **Type** : positif
- **Données** : période future connue comme disponible pour certaines annonces.
- **Résultat attendu** : seules les annonces disponibles pendant toute la période sont affichées.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-007 — Capacité égale au besoin

- **Priorité** : P1
- **Type** : valeur limite
- **Données** : 4 voyageurs, annonce de capacité 4.
- **Résultat attendu** : l’annonce est incluse.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-008 — Capacité inférieure au besoin

- **Priorité** : P1
- **Type** : négatif
- **Données** : 5 voyageurs, annonce de capacité 4.
- **Résultat attendu** : l’annonce est exclue.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-009 — Recherche avec animal

- **Priorité** : P1
- **Type** : table de décision
- **Données** : animal = oui.
- **Résultat attendu** : seules les annonces autorisant les animaux sont affichées.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-010 — Recherche multicritère

- **Priorité** : P1
- **Type** : table de décision, E2E
- **Données** : destination, période, adultes, enfants, animal.
- **Résultat attendu** : chaque annonce respecte l’ensemble des critères ; aucun critère n’est traité en logique OU.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-011 — Aucun résultat

- **Priorité** : P1
- **Type** : négatif fonctionnel
- **Données** : combinaison valide sans annonce correspondante.
- **Résultat attendu** : la page de résultats s’affiche avec une liste vide et un état « aucun résultat » cohérent.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-SEARCH-012 — Critère invalide

- **Priorité** : P1
- **Type** : négatif
- **Données** : valeur de date invalide ou incohérente.
- **Résultat attendu** : aucune navigation vers les résultats ; message d’erreur visible.
- **Automatisation** : Automatisable après observation du comportement réel.

### TC-SEARCH-013 — Rappel des critères

- **Priorité** : P2
- **Type** : interface
- **Résultat attendu** : la barre de recherche des résultats reprend exactement les critères soumis.
- **Automatisation** : Automatisable après observation des sélecteurs et valeurs rappelées.

### TC-SEARCH-014 — Carte et liste

- **Priorité** : P2
- **Type** : interface, exploratoire
- **Résultat attendu** : carte à gauche, liste à droite.
- **Automatisation** : Partielle ; contrôle visuel recommandé.

### TC-SEARCH-015 — Survol et ouverture d’annonce

- **Priorité** : P2
- **Type** : interaction
- **Étapes** : survoler une annonce, observer la carte, cliquer sur l’annonce.
- **Résultat attendu** : marqueur correspondant mis en évidence puis annonce ouverte.
- **Automatisation** : Oui pour l’ouverture ; la carte peut nécessiter une vérification spécifique.

## 3. Cas de test — Connexion

### TC-AUTH-001 — Ouverture de la popup

- **Priorité** : P2
- **Type** : positif, interface
- **Résultat attendu** : popup avec identifiant/email, mot de passe, souvenir de session et mot de passe oublié.
- **Automatisation** : Oui.

### TC-AUTH-002 — Connexion Voyageur réussie

- **Priorité** : P2
- **Type** : positif
- **Préconditions** : compte Voyageur valide.
- **Étapes** : ouvrir la popup, saisir les identifiants, valider.
- **Résultat attendu** : confirmation affichée, session ouverte, redirection Voyageur.
- **Automatisation** : Oui.

### TC-AUTH-003 — Rubriques Voyageur

- **Priorité** : P2
- **Type** : contrôle d’autorisation/interface
- **Résultat attendu** : présence des huit rubriques attendues et absence des rubriques réservées à l’Hôte.
- **Automatisation** : Oui.

### TC-AUTH-004 — Connexion Hôte réussie

- **Priorité** : P2
- **Type** : positif
- **Préconditions** : compte Hôte existant.
- **Résultat attendu** : confirmation et redirection Hôte.
- **Automatisation** : Oui.

### TC-AUTH-005 — Rubriques Hôte

- **Priorité** : P2
- **Type** : contrôle d’autorisation/interface
- **Résultat attendu** : présence des dix rubriques attendues, dont Mes annonces, Créer une annonce et Réservations.
- **Automatisation** : Oui.

### TC-AUTH-006 — Identifiant invalide

- **Priorité** : P2
- **Type** : partition négative
- **Données** : utilisateur inexistant + mot de passe quelconque.
- **Résultat attendu** : erreur affichée, aucune session, aucune redirection de compte.
- **Automatisation** : Oui.

### TC-AUTH-007 — Mot de passe invalide

- **Priorité** : P2
- **Type** : partition négative
- **Données** : utilisateur valide + mot de passe erroné.
- **Résultat attendu** : même résultat que TC-AUTH-006, sans divulguer si le compte existe.
- **Automatisation** : Automatisable après observation avec un compte valide.

### TC-AUTH-008 — Champs vides

- **Priorité** : P2
- **Type** : négatif, validation
- **Résultat attendu** : validation locale ou serveur ; aucune authentification.
- **Automatisation** : Automatisable après observation des validations exactes.

### TC-AUTH-009 — Se souvenir de moi

- **Priorité** : P2
- **Type** : session
- **Étapes** : se connecter avec l’option activée, fermer puis rouvrir un nouveau contexte persistant.
- **Résultat attendu** : comportement conforme à la durée de session définie.
- **Automatisation** : Oui après clarification de la règle.

## 4. Cas de test — Réservation

### TC-BOOK-001 — Voyageur connecté, demande valide

- **Priorité** : P1
- **Type** : E2E positif
- **Préconditions** : Voyageur connecté ; annonce Hôte publiée ; période future disponible.
- **Données** : début `J+20`, fin `J+25`, 2 voyageurs, message unique.
- **Étapes** :
  1. Ouvrir l’annonce.
  2. Choisir la période.
  3. Saisir les voyageurs.
  4. Saisir un message identifiable.
  5. Envoyer la demande.
  6. Se connecter comme Hôte.
  7. Ouvrir Réservations puis Messages.
- **Résultat attendu** : confirmation Voyageur ; nouvelle réservation Hôte ; nouveau message Hôte avec contenu identifiable.
- **Automatisation** : Déclaré en `fixme` ; non exécutable durablement sur l’environnement actuel.
- **Risque connu** : AK-03 provoque actuellement l’échec de la vérification message.

### TC-BOOK-002 — Visiteur non connecté

- **Priorité** : P1
- **Type** : transition d’état, négatif
- **Étapes** : renseigner une demande sans session et cliquer sur le bouton de réservation.
- **Résultat attendu** : invitation à se connecter ou refus ; aucune réservation et aucun message côté Hôte.
- **Automatisation** : Oui.

### TC-BOOK-003 — Reprise après connexion

- **Priorité** : P1
- **Type** : transition d’état
- **Étapes** : commencer sans session, être invité à se connecter, se connecter comme Voyageur.
- **Résultat attendu** : comportement clarifié : reprise des données ou retour contrôlé ; aucune création en double.
- **Automatisation** : À clarifier avant automatisation.

### TC-BOOK-004 — Date de début passée

- **Priorité** : P1
- **Type** : limite négative
- **Données** : `J-1`.
- **Résultat attendu** : date non sélectionnable ou rejetée ; aucune demande.
- **Automatisation** : Oui.

### TC-BOOK-005 — Date de fin égale au début

- **Priorité** : P1
- **Type** : valeur limite
- **Données** : début = fin = `J+20`.
- **Résultat attendu** : demande bloquée car la fin doit être postérieure.
- **Automatisation** : Automatisable après observation du comportement réel.

### TC-BOOK-006 — Date de fin antérieure

- **Priorité** : P1
- **Type** : négatif
- **Données** : début `J+20`, fin `J+19`.
- **Résultat attendu** : demande bloquée et message de validation.
- **Automatisation** : Automatisable après observation du comportement réel.

### TC-BOOK-007 — Zéro voyageur

- **Priorité** : P1
- **Type** : valeur limite
- **Données** : total = 0.
- **Résultat attendu** : demande bloquée.
- **Automatisation** : Oui.

### TC-BOOK-008 — Un voyageur

- **Priorité** : P1
- **Type** : valeur limite positive
- **Données** : total = 1.
- **Résultat attendu** : demande autorisée si les autres données sont valides.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-BOOK-009 — Voyageurs au-dessus de la capacité

- **Priorité** : P1
- **Type** : négatif
- **Données** : capacité annonce + 1.
- **Résultat attendu** : demande impossible ou annonce non proposée ; aucun enregistrement créé.
- **Automatisation** : Automatisable avec données maîtrisées.

### TC-BOOK-010 — Message vide

- **Priorité** : P1
- **Type** : négatif
- **Résultat attendu** : demande bloquée et message obligatoire indiqué.
- **Automatisation** : Automatisable après confirmation du caractère obligatoire.

### TC-BOOK-011 — Période déjà réservée

- **Priorité** : P1
- **Type** : E2E, état
- **Préconditions** : une première réservation bloque une période.
- **Étapes** : avec un autre Voyageur, tenter de réserver la même période.
- **Résultat attendu** : période indisponible et aucune seconde réservation concurrente.
- **Automatisation** : Automatisable avec environnement réinitialisable.

### TC-BOOK-012 — Accès Réservations via menu latéral

- **Priorité** : P2
- **Type** : navigation
- **Résultat attendu** : page Réservations accessible depuis le menu latéral Hôte.
- **Automatisation** : Automatisable après observation des menus Hôte.

### TC-BOOK-013 — Accès Messages via menu latéral

- **Priorité** : P2
- **Type** : navigation
- **Résultat attendu** : page Messages accessible depuis le menu latéral Hôte.
- **Automatisation** : Automatisable après observation des menus Hôte.

### TC-BOOK-014 — Accès via menu utilisateur

- **Priorité** : P2
- **Type** : navigation, survol
- **Étapes** : survoler le nom d’utilisateur puis ouvrir Réservations et Messages.
- **Résultat attendu** : les deux pages sont accessibles.
- **Automatisation** : Automatisable après observation des menus Hôte.

### TC-BOOK-015 — 7e demande

- **Priorité** : P1
- **Type** : limite, régression
- **Préconditions** : six demandes existantes dans le périmètre qui déclenche l’anomalie.
- **Résultat attendu** : la 7e demande valide est créée avec message et réservation.
- **Automatisation** : Non automatisable durablement sur l’environnement actuel.

### TC-BOOK-016 — 8e demande

- **Priorité** : P1
- **Type** : limite, régression
- **Préconditions** : sept demandes existantes.
- **Résultat attendu** : la 8e demande valide est créée et traitable.
- **Automatisation** : Non automatisable durablement sur l’environnement actuel.

### TC-BOOK-017 — 9e demande

- **Priorité** : P1
- **Type** : au-delà de la limite, régression
- **Préconditions** : huit demandes existantes.
- **Résultat attendu** : en l’absence de limite métier explicite, la 9e demande est créée et traitable, avec réservation et message visibles.
- **Résultat actuellement probable** : échec lié à AK-01.
- **Automatisation** : Non automatisable durablement sur l’environnement actuel.

### TC-BOOK-018 — Traitement Hôte au-delà de 8

- **Priorité** : P1
- **Type** : régression
- **Préconditions** : plus de huit demandes reçues.
- **Étapes** : ouvrir et traiter la 9e demande côté Hôte.
- **Résultat attendu** : la demande est accessible et son traitement aboutit conformément au workflow.
- **Résultat actuellement probable** : échec lié à AK-01.
- **Automatisation** : Non automatisable durablement sur l’environnement actuel.

### TC-BOOK-019 — Visibilité du message Hôte

- **Priorité** : P1
- **Type** : régression, E2E
- **Données** : message unique contenant un identifiant de test.
- **Résultat attendu** : le message apparaît dans la boîte Messages de l’Hôte et est rattachable à la réservation.
- **Résultat actuellement probable** : échec lié à AK-03.
- **Automatisation** : Non automatisable durablement tant que l’anomalie persiste.

## 5. Recommandations d’implémentation Playwright

Le script enregistré doit être refactoré avant intégration dans une suite CI :

- remplacer `test('test')` par des noms orientés comportement ;
- scinder le parcours en plusieurs fichiers ;
- supprimer les `nth-child` dépendants de la mise en page ;
- générer les dates avec une fonction `futureDate(days)` ;
- créer des helpers `loginAsTraveler()` et `loginAsHost()` ;
- vérifier l’URL, les messages de confirmation, les erreurs, les cartes de résultat et les lignes de réservation ;
- injecter les identifiants via variables d’environnement ;
- utiliser un message unique tel que `E2E-${testInfo.workerIndex}-${Date.now()}` ;
- enregistrer la trace sur premier retry ou à l’échec ;
- désactiver le parallélisme pour les tests qui modifient la même annonce.

### Exemple de niveau d’assertion attendu

```ts
await expect(page).toHaveURL(/dashboard|account/);
await expect(page.getByText(/connexion réussie|bienvenue/i)).toBeVisible();
await expect(page.getByRole('link', { name: 'Voyages' })).toBeVisible();
```

Une automatisation sans assertion ne démontre pas que le système respecte les critères d’acceptation.
