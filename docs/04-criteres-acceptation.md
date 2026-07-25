# 04 — Critères d’acceptation détaillés

Les critères ci-dessous reformulent les stories en conditions vérifiables. Les formulations ambiguës sont signalées.

## 1. Recherche simple — US-SEARCH-01

### CA-SEARCH-01 — Recherche sans critère

**Étant donné** un utilisateur sur la page d’accueil  
**Quand** aucun critère n’est renseigné et qu’il clique sur « Chercher »  
**Alors** une page de résultats s’affiche  
**Et** toutes les annonces publiées sont proposées, sans filtre fonctionnel.

### CA-SEARCH-02 — Filtre par destination

**Étant donné** des annonces publiées dans plusieurs communes  
**Quand** l’utilisateur saisit une destination valide et lance la recherche  
**Alors** seules les annonces de cette destination sont affichées.

### CA-SEARCH-03 — Destination longue

**Étant donné** un utilisateur sur la page d’accueil  
**Quand** il saisit un nom de commune de plus de 20 caractères  
**Alors** le champ accepte la valeur sans troncature bloquante  
**Et** la recherche peut être soumise.

### CA-SEARCH-04 — Filtre par dates disponibles

**Étant donné** des annonces avec des calendriers de disponibilité différents  
**Quand** l’utilisateur saisit une période future valide  
**Alors** seules les annonces disponibles pendant toute la période sont affichées.

### CA-SEARCH-05 — Date passée interdite

**Étant donné** la page d’accueil  
**Quand** l’utilisateur tente de renseigner une date antérieure à la date du jour  
**Alors** la valeur n’est pas acceptée ou la recherche est bloquée  
**Et** un message de validation est affiché.

### CA-SEARCH-06 — Date de fin antérieure interdite

**Étant donné** une date de début valide  
**Quand** l’utilisateur renseigne une date de fin antérieure  
**Alors** la recherche n’est pas lancée  
**Et** un message de validation est affiché.

### CA-SEARCH-07 — Filtre par capacité

**Étant donné** des annonces de capacités différentes  
**Quand** l’utilisateur recherche pour N voyageurs  
**Alors** chaque annonce affichée a une capacité supérieure ou égale à N.

### CA-SEARCH-08 — Filtre animaux

**Étant donné** des annonces autorisant ou refusant les animaux  
**Quand** l’utilisateur indique la présence d’un animal  
**Alors** seules les annonces autorisant les animaux sont affichées.

### CA-SEARCH-09 — Combinaison de critères

**Étant donné** plusieurs annonces  
**Quand** l’utilisateur renseigne destination, dates et voyageurs  
**Alors** chaque résultat respecte simultanément tous les critères.

### CA-SEARCH-10 — Aucun résultat

**Étant donné** des critères valides ne correspondant à aucune annonce  
**Quand** la recherche est soumise  
**Alors** la page de résultats s’affiche  
**Et** la liste est vide  
**Et** aucun résultat hors critères n’est affiché.

### CA-SEARCH-11 — Critère invalide

**Étant donné** un critère invalide  
**Quand** l’utilisateur tente de rechercher  
**Alors** la page de résultats ne s’affiche pas  
**Et** un message d’erreur explicite est présenté.

### CA-SEARCH-12 — Structure des résultats

**Étant donné** une recherche soumise  
**Quand** la page de résultats s’affiche  
**Alors** la carte est à gauche  
**Et** la liste des annonces est à droite  
**Et** la barre de recherche rappelle les critères.

### CA-SEARCH-13 — Interaction carte et annonce

**Étant donné** une page de résultats avec au moins une annonce  
**Quand** l’utilisateur survole une annonce  
**Alors** le logement correspondant est mis en évidence sur la carte  
**Et quand** il clique sur l’annonce  
**Alors** la page de cette annonce s’ouvre.

## 2. Connexion — US-AUTH-01

### CA-AUTH-01 — Ouverture de la popup

**Étant donné** un visiteur sur le site  
**Quand** il clique sur « Se connecter »  
**Alors** une popup de connexion s’affiche  
**Et** elle contient les champs identifiant/email, mot de passe et « Se souvenir de moi »  
**Et** un accès à la récupération de mot de passe.

### CA-AUTH-02 — Connexion Voyageur réussie

**Étant donné** la popup ouverte  
**Quand** un compte Voyageur valide est saisi  
**Alors** un message de confirmation s’affiche  
**Et** l’utilisateur est redirigé vers son compte Voyageur.

### CA-AUTH-03 — Menu Voyageur

**Étant donné** un Voyageur connecté  
**Alors** son tableau de bord présente : Tableau de bord, Profil, Voyages, Portefeuille, Favoris, Factures, Messages et Se déconnecter.

### CA-AUTH-04 — Connexion Hôte réussie

**Étant donné** la popup ouverte  
**Quand** un compte Hôte valide est saisi  
**Alors** un message de confirmation s’affiche  
**Et** l’utilisateur est redirigé vers son compte Hôte.

### CA-AUTH-05 — Menu Hôte

**Étant donné** un Hôte connecté  
**Alors** son tableau de bord présente : Tableau de bord, Profil, Mes annonces, Créer une annonce, Réservations, Portefeuille, Favoris, Factures, Messages et Se déconnecter.

### CA-AUTH-06 — Identifiants invalides

**Étant donné** la popup ouverte  
**Quand** des identifiants invalides sont soumis  
**Alors** la connexion est refusée  
**Et** un message d’erreur s’affiche  
**Et** l’utilisateur reste non connecté.

## 3. Demande de réservation — US-BOOK-01

### CA-BOOK-01 — Réservation par Voyageur connecté

**Étant donné** un Voyageur connecté et une annonce disponible appartenant à un Hôte  
**Quand** il sélectionne une période future disponible, un nombre de voyageurs valide, saisit un message et envoie la demande  
**Alors** la demande est confirmée  
**Et** une nouvelle réservation apparaît dans le tableau de bord de l’Hôte  
**Et** un nouveau message apparaît dans la messagerie de l’Hôte.

### CA-BOOK-02 — Visiteur non connecté

**Étant donné** un visiteur non connecté sur une annonce  
**Quand** il renseigne les informations de réservation et tente d’envoyer la demande  
**Alors** il est invité à se connecter ou la demande est refusée  
**Et** aucune réservation n’est créée  
**Et** aucun message n’est créé côté Hôte.

### CA-BOOK-03 — Dates futures uniquement

**Étant donné** le calendrier de réservation  
**Alors** les dates passées ne sont pas sélectionnables  
**Et** seules les dates futures disponibles peuvent être choisies.

### CA-BOOK-04 — Ordre des dates

**Étant donné** une date de début sélectionnée  
**Quand** l’utilisateur choisit ou saisit une date de fin égale ou antérieure  
**Alors** la demande ne peut pas être envoyée  
**Et** une validation est affichée.

### CA-BOOK-05 — Voyageurs non nuls

**Étant donné** le formulaire de réservation  
**Quand** le nombre total de voyageurs vaut 0  
**Alors** la demande ne peut pas être envoyée  
**Et** un message de validation est affiché.

### CA-BOOK-06 — Message obligatoire

**Étant donné** les autres données valides  
**Quand** le message à l’Hôte est vide  
**Alors** la demande ne peut pas être envoyée  
**Et** un message de validation est affiché.

### CA-BOOK-07 — Période bloquée

**Étant donné** une demande de réservation considérée comme bloquante selon la règle métier  
**Quand** un autre utilisateur consulte la même annonce  
**Alors** la période concernée n’est plus réservable.

> Point à clarifier : le blocage intervient-il dès la demande ou après acceptation de l’Hôte ?

### CA-BOOK-08 — Accès aux réservations et messages

**Étant donné** un Hôte connecté  
**Alors** « Réservations » et « Messages » sont accessibles par le menu latéral  
**Et** par le menu affiché au survol du nom d’utilisateur.

### CA-BOOK-09 — Au-delà de 8 demandes

**Étant donné** un compte et une annonce permettant déjà 8 demandes de réservation  
**Quand** une 9e demande valide est envoyée  
**Alors** elle doit être traitée normalement en l’absence de règle métier limitative  
**Et** une réservation et un message doivent être créés côté Hôte.

> Ce critère formalise la non-régression associée à l’anomalie connue AK-01. Il doit être confirmé par le Product Owner si une limite métier était intentionnelle.

### CA-BOOK-10 — Message visible côté Hôte

**Étant donné** une demande envoyée avec un message identifiable  
**Quand** l’Hôte ouvre sa messagerie  
**Alors** le message du Voyageur est visible avec un contenu permettant de le rattacher à la demande.

> Ce critère est actuellement en anomalie connue AK-03.
