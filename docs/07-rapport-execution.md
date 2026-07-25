# Rapport d'exécution

## Objet du document

Ce document ne présente pas les résultats historiques cumulés comme l'état courant de la suite. Un résultat doit être associé à une campagne datée, à l'environnement exécuté et au rapport généré par cette campagne.

Avant une nouvelle campagne :

```bash
npm run results:clean
npx playwright test --workers=2 --retries=1
```

## Scénario déclaré `fixme`

Le scénario `TC-US03-AC01-02` de demande valide par un Voyageur connecté est présent dans la suite avec `test.fixme()`. Il n'est donc pas présenté comme un test exécuté avec succès ou en échec. Les raisons et conditions de réactivation sont documentées directement dans le fichier de test.

## Limites connues de l'environnement

- le traitement côté Hôte n'est plus rejouable après huit demandes déjà traitées ;
- aucun autre compte Hôte ne peut être créé ;
- aucun mécanisme de nettoyage ou de remise à zéro des demandes n'est disponible pour le projet.

Ces contraintes doivent être déclarées comme limitations de testabilité. Le projet ne simule pas de compte, de base de données, d'API de nettoyage ou de fonctionnalité qui n'existe pas sur le site.

## Améliorations appliquées

- alignement des noms de tests avec les assertions réellement exécutées ;
- renforcement des oracles de connexion et de recherche ;
- création d'un état d'authentification Voyageur avec `storageState` ;
- utilisation de cet état uniquement pour le scénario nécessitant un Voyageur déjà connecté ;
- matrice distinguant l'implémentation du résultat d'exécution ;
- suppression des identifiants réels utilisés comme valeurs par défaut ;
- nettoyage explicite des résultats avant une nouvelle campagne.
