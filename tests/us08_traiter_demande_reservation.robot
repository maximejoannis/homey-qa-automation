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
US08-CT01 - Effectuer le parcours connecté complet jusqu après la demande
    [Tags]    smoke    regression    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur La Deuxieme Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Selectionner Des Voyageurs Connecte
    Cliquer Sur Demande De Reservation
    Finaliser Le Parcours Apres Demande De Reservation

    Wait Until Page Contains Element    ${BTN_CHERCHER_HOME}    ${TIMEOUT_UI}
    Element Should Be Visible    ${BTN_CHERCHER_HOME}
