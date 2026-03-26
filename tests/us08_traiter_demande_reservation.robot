*** Settings ***
Documentation       US-08 - Traiter une demande de réservation
Resource            ../resources/common.resource
Resource            ../resources/navigation.resource
Resource            ../resources/reservation.resource
Resource            ../resources/assertions.resource
Resource            ../variables/env.robot
Resource            ../variables/data.robot
Test Setup          Setup Test
Test Teardown       Teardown Test

*** Test Cases ***
US08-CT01 - Parcours connecté sans oracle fiable
    [Tags]    quarantine    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur La Deuxieme Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Selectionner Des Voyageurs Connecte
    Cliquer Sur Demande De Reservation
    Finaliser Le Parcours Apres Demande De Reservation
    Log    [INFO] US08 exécuté mais non validé automatiquement faute d oracle fiable.    console=yes
