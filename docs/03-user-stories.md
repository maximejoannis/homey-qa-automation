# 03 — User stories normalisées

## US-SEARCH-01 — Réaliser une recherche simple

**Priorité : P1**

### Story

En tant que **visiteur ou utilisateur connecté**,  
je souhaite rechercher des logements à partir de critères facultatifs,  
afin de trouver les annonces adaptées à mon séjour.

### Valeur métier

Permettre à tout utilisateur de découvrir les annonces publiées, avec ou sans filtre, avant de consulter une annonce et éventuellement demander une réservation.

### Règles métier

1. La recherche est disponible sans authentification.
2. Les quatre familles de critères sont : destination, date de début, date de fin, voyageurs.
3. Chaque critère est facultatif.
4. Un critère renseigné doit filtrer les annonces.
5. Plusieurs critères sont combinés avec une logique **ET**.
6. La destination accepte plus de 20 caractères.
7. Les dates sont au format `AAAA-MM-JJ`.
8. Les dates antérieures au jour courant sont interdites.
9. La date de fin doit être postérieure ou égale à la date de début selon clarification métier ; la story indique qu’elle ne doit pas être antérieure, tandis que la réservation exige une date strictement postérieure.
10. Le nombre d’adultes et d’enfants est un entier positif ou nul au niveau du sous-champ ; le total attendu pour une réservation doit être non nul.
11. La présence d’animaux est un booléen.
12. La capacité de l’annonce doit être supérieure ou égale au nombre de voyageurs.
13. Une annonce doit autoriser les animaux lorsqu’ils sont demandés.
14. La page de résultats affiche une carte à gauche et la liste à droite.
15. La barre de recherche rappelle les critères saisis.
16. Le survol d’une annonce localise le logement sur la carte.
17. Le clic ouvre l’annonce.
18. Un critère invalide doit empêcher l’ouverture de la page de résultats et afficher un message.

### Dépendances

- annonces publiées et géolocalisées ;
- capacité et règle animaux renseignées ;
- calendrier de disponibilité exploitable.

### Questions ouvertes

- Une recherche avec date de début égale à la date de fin est-elle autorisée ?
- Le nombre 0 est-il accepté séparément pour adultes et enfants tant que le total est positif ?
- La destination est-elle une saisie libre, une autocomplétion ou une valeur normalisée ?
- Quel message exact doit apparaître pour un critère invalide ?

---

## US-AUTH-01 — Se connecter

**Priorité : P2**

### Story

En tant qu’**utilisateur disposant d’un compte**,  
je souhaite me connecter à mon compte,  
afin d’accéder à mes outils personnalisés selon mon profil.

### Valeur métier

Protéger les fonctionnalités de création d’annonce et de réservation tout en donnant accès aux tableaux de bord Voyageur et Hôte.

### Règles métier

1. Le lien « Se connecter » est présent dans le menu principal.
2. Le même lien est utilisé pour les profils Hôte et Voyageur.
3. Le clic ouvre une popup.
4. La popup contient : identifiant ou email, mot de passe, « Se souvenir de moi » et récupération de mot de passe.
5. Des identifiants valides affichent un message de confirmation.
6. L’utilisateur est redirigé vers le tableau de bord correspondant à son profil.
7. Des identifiants invalides affichent un message d’erreur.
8. Le tableau de bord Voyageur contient : Tableau de bord, Profil, Voyages, Portefeuille, Favoris, Factures, Messages, Se déconnecter.
9. Le tableau de bord Hôte contient : Tableau de bord, Profil, Mes annonces, Créer une annonce, Réservations, Portefeuille, Favoris, Factures, Messages, Se déconnecter.

### Dépendances

- comptes Voyageur et Hôte actifs ;
- système de session ;
- routage selon le rôle.

### Contrainte connue

La création de nouveaux comptes Hôte est impossible. Les tests utilisent donc un compte Hôte existant.

### Questions ouvertes

- Le message de confirmation est-il un toast, une alerte ou un texte dans la popup ?
- Quelle est la durée de session avec « Se souvenir de moi » ?
- Les comptes verrouillés ou inactifs doivent-ils recevoir un message spécifique ?

---

## US-BOOK-01 — Faire une demande de réservation

**Priorité : P1**

### Story

En tant que **Voyageur**,  
je souhaite envoyer une demande de réservation,  
afin de bénéficier d’un séjour dans un logement saisonnier.

### Valeur métier

Créer une interaction transactionnelle entre le Voyageur et l’Hôte à partir d’une annonce disponible.

### Règles métier

1. L’annonce doit avoir été créée et publiée par un Hôte.
2. Un Voyageur connecté peut finaliser une demande.
3. Un visiteur peut commencer le parcours mais ne peut pas le finaliser.
4. La date de début doit être disponible et future.
5. La date de fin doit être disponible, future et strictement postérieure à la date de début.
6. Le nombre de voyageurs doit être un entier non nul.
7. Un message à l’Hôte doit être renseigné.
8. Une période réservée est bloquée pour les autres réservations.
9. Après envoi, l’Hôte reçoit une nouvelle réservation.
10. Après envoi, l’Hôte reçoit un nouveau message.
11. Messages et Réservations sont accessibles via le menu latéral et via le menu du nom d’utilisateur.
12. Aucune limite de 8 demandes n’est spécifiée dans la story ; tout blocage à ce seuil est donc considéré comme une anomalie jusqu’à clarification.

### Dépendances

- annonce disponible appartenant à l’Hôte de test ;
- compte Voyageur ;
- compte Hôte ;
- messagerie interne ;
- module de réservations ;
- calendrier de disponibilité.

### Anomalies connues liées

- impossibilité de dépasser 8 demandes ou traitements de réservation ;
- messages Voyageur non visibles par l’Hôte.

### Questions ouvertes

- Une demande bloque-t-elle la période immédiatement ou seulement après acceptation par l’Hôte ?
- Quels sont les états d’une demande : en attente, acceptée, refusée, annulée ?
- Le message est-il obligatoire côté interface ou uniquement attendu fonctionnellement ?
- Le nombre maximum de voyageurs est-il limité par la capacité de l’annonce ?
- Une réservation existante en attente doit-elle bloquer les dates ?
