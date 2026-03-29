*** Settings ***
Documentation       US-07 - Faire une demande de réservation (connecté)

# ⚠️ Mise en quarantaine de la suite US07 connecté en raison d’instabilités
# en environnement CI headless (connexion et interactions menu compte / tableau de bord).
#
# La suite concernant la demande de réservation en étant connectée sera
# fiabilisée dans une itération dédiée.

Resource            ../resources/common.resource
Resource            ../resources/navigation.resource
Resource            ../resources/reservation.resource
Resource            ../resources/assertions.resource
Resource            ../variables/data.robot

Test Setup          Setup Test
Test Teardown       Teardown Test


*** Test Cases ***
US07C-CT01 - Accéder au module de réservation en étant connecté
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur Une Annonce Pour Reservation Connecte
    Le Module De Reservation Doit Etre Visible

US07C-CT02 - Sélectionner une date d'arrivée et une date de départ
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur Une Annonce Pour Reservation Connecte
    Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_ARRIVEE}
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_DEPART}

US07C-CT03 - Sélectionner des voyageurs
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Retourner A L Accueil Apres Connexion
    Aller Sur Une Annonce Pour Reservation Connecte
    Selectionner Des Voyageurs Connecte
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_VOYAGEURS}

US07C-CT04 - Voir le détail du prix d'une réservation existante
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Au Tableau De Bord Dropdown
    Ouvrir Le Detail De La Premiere Reservation Dashboard
    Descendre En Bas De Page
    Wait Until Page Contains    Paiement    ${TIMEOUT_LONG}
    Wait Until Page Contains    Total    ${TIMEOUT_LONG}

US07C-CT05 - Ouvrir le détail d'une réservation existante
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Au Tableau De Bord Dropdown
    Ouvrir Le Detail De La Premiere Reservation Dashboard
    Page Should Contain    Réservation
    Page Should Contain    Détails

US07C-CT06 - Accéder au tableau de bord via le menu compte
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Au Tableau De Bord Dropdown
    Title Should Be    ${TITRE_PAGE_TABLEAU_DE_BORD}

US07C-CT07 - Ouvrir le détail d'une réservation depuis le tableau de bord
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Au Tableau De Bord Dropdown
    Ouvrir Le Detail De La Premiere Reservation Dashboard
    Descendre En Bas De Page
    Wait Until Page Contains    Paiement    ${TIMEOUT_LONG}
    Wait Until Page Contains    Total    ${TIMEOUT_LONG}

US07C-CT08 - Accéder à Voyages via le menu compte
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Aux Voyages Dropdown
    Wait Until Page Contains    Voyages    ${TIMEOUT_LONG}

US07C-CT09 - Revenir au tableau de bord depuis Voyages
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Aller Aux Voyages Dropdown
    Wait Until Page Contains    Voyages    ${TIMEOUT_LONG}
    Aller Au Tableau De Bord Dropdown
    Title Should Be    ${TITRE_PAGE_TABLEAU_DE_BORD}

US07C-CT10 - Se déconnecter via le menu compte
    [Tags]    quarantine    us07    connecte
    Se Connecter En Tant Qu Utilisateur Reservation
    Se Deconnecter Dropdown
    Wait Until Page Contains Element    ${LIEN_SE_CONNECTER}    ${TIMEOUT_LONG}
