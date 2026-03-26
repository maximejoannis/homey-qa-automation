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
    ${current_url}=    Recuperer L Url Courante
    Log    [INFO] URL après parcours connecté: ${current_url}    console=yes
    Should Not Be Equal    ${current_url}    ${BASE_URL}

US08-CT02 - Capturer l identifiant de réservation si disponible
    [Tags]    regression    us08    quarantine
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur La Deuxieme Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Selectionner Des Voyageurs Connecte
    Cliquer Sur Demande De Reservation
    Finaliser Le Parcours Apres Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    Should Not Be Empty    ${RESERVATION_ID}

US08-CT03 - Vérifier que l identifiant de réservation est valide
    [Tags]    regression    us08    quarantine
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur La Deuxieme Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Selectionner Des Voyageurs Connecte
    Cliquer Sur Demande De Reservation
    Finaliser Le Parcours Apres Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    Verifier Que L Id Reservation Est Valide    ${RESERVATION_ID}

US08-CT04 - Sauvegarder le contexte runtime de réservation
    [Tags]    regression    us08    quarantine
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur La Deuxieme Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Selectionner Des Voyageurs Connecte
    Cliquer Sur Demande De Reservation
    Finaliser Le Parcours Apres Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    File Should Exist    results/runtime_context.json
