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
US08-CT01 - Effectuer une demande de réservation connectée
    [Tags]    smoke    regression    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart
    Selectionner Des Voyageurs    2    1
    Cliquer Sur Demande De Reservation

US08-CT02 - Capturer l identifiant dynamique de réservation
    [Tags]    regression    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart
    Selectionner Des Voyageurs    2    1
    Cliquer Sur Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    Should Not Be Empty    ${RESERVATION_ID}

US08-CT03 - Vérifier que l identifiant de réservation est valide
    [Tags]    regression    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart
    Selectionner Des Voyageurs    2    1
    Cliquer Sur Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    Verifier Que L Id Reservation Est Valide    ${RESERVATION_ID}

US08-CT04 - Sauvegarder le contexte runtime de réservation
    [Tags]    regression    us08
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D Arrivee Et Une Date De Depart
    Selectionner Des Voyageurs    2    1
    Cliquer Sur Demande De Reservation
    Wait Until Keyword Succeeds    5x    2s    Capturer Et Sauvegarder L Id Reservation
    File Should Exist    results/runtime_context.json
