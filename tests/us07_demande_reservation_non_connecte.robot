*** Settings ***
Documentation       US-07 - Faire une demande de réservation
Resource            ../resources/common.resource
Resource            ../resources/navigation.resource
Resource            ../resources/reservation.resource
Resource            ../resources/assertions.resource
Resource            ../variables/data.robot
Test Setup          Setup Test
Test Teardown       Teardown Test

*** Test Cases ***
US07-CT01 - Vérifier la présence du module de réservation sur une annonce
    [Tags]    smoke    regression    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Le Module De Reservation Doit Etre Visible

US07-CT02 - Sélectionner une date d'arrivée et une date de départ
    [Tags]    regression    us07    quarantine
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D'Arrivee Et Une Date De Depart
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_ARRIVEE}
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_DEPART}

US07-CT03 - Sélectionner des voyageurs
    [Tags]    smoke    regression    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Des Voyageurs    ${NB_ADULTES_STANDARD}    ${NB_ENFANTS_STANDARD}
    Le Champ Ne Doit Pas Etre Vide    ${CHAMP_RESERVATION_VOYAGEURS}

US07-CT04 - Sélectionner l'extra Breakfast
    [Tags]    regression    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner L Extra Breakfast
    Checkbox Should Be Selected    ${CHK_EXTRA_BREAKFAST}

US07-CT05 - Vérifier le message de connexion lors d'une demande non connectée
    [Tags]    regression    us07    quarantine
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner Une Date D'Arrivee Et Une Date De Depart
    Selectionner Des Voyageurs    ${NB_ADULTES_STANDARD}    ${NB_ENFANTS_STANDARD}
    Cliquer Sur Demande De Reservation
    Wait Until Page Contains    ${MSG_CONNEXION_POUR_RESERVATION}    ${TIMEOUT_UI}
    Page Should Contain    ${MSG_CONNEXION_POUR_RESERVATION}

US07-CT06 - Vérifier les attributs des champs de réservation
    [Tags]    regression    ui    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_RESERVATION_ARRIVEE}    readonly
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_RESERVATION_DEPART}    readonly
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_RESERVATION_VOYAGEURS}    readonly
    Le Champ Doit Avoir La Valeur D Attribut    ${CHAMP_RESERVATION_ARRIVEE}    placeholder    Début
    Le Champ Doit Avoir La Valeur D Attribut    ${CHAMP_RESERVATION_DEPART}    placeholder    Fin
    Le Champ Doit Avoir La Valeur D Attribut    ${CHAMP_RESERVATION_VOYAGEURS}    placeholder    Voyageurs

US07-CT07 - Ouvrir le calendrier depuis le champ arrivée
    [Tags]    regression    ui    us07    quarantine
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir Le Calendrier Depuis Le Champ Arrivee
    Page Should Contain Element    ${CALENDRIER_JOUR_DISPONIBLE}

US07-CT08 - Ouvrir le sélecteur de voyageurs
    [Tags]    smoke    regression    ui    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir Le Selecteur Voyageurs
    Page Should Contain Element    ${BTN_APPLIQUER_VOYAGEURS}

US07-CT09 - Sélectionner l'extra Lunch
    [Tags]    regression    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner L Extra Lunch
    Checkbox Should Be Selected    ${CHK_EXTRA_LUNCH}

US07-CT10 - Sélectionner plusieurs extras
    [Tags]    regression    us07
    Aller Sur La Premiere Annonce Depuis La Home
    Selectionner L Extra Breakfast
    Selectionner L Extra Lunch
    Selectionner L Extra Dinner
    Checkbox Should Be Selected    ${CHK_EXTRA_BREAKFAST}
    Checkbox Should Be Selected    ${CHK_EXTRA_LUNCH}
    Checkbox Should Be Selected    ${CHK_EXTRA_DINNER}
