*** Settings ***
Resource    ../resources/common.resource
Resource    ../variables/env.robot

*** Keywords ***
Le Module De Reservation Doit Etre Visible
    Page Should Contain Element    ${CHAMP_RESERVATION_ARRIVEE}
    Page Should Contain Element    ${CHAMP_RESERVATION_DEPART}
    Page Should Contain Element    ${CHAMP_RESERVATION_VOYAGEURS}
    Page Should Contain Element    ${BTN_DEMANDE_RESERVATION}

Selectionner Une Date D'Arrivee Et Une Date De Depart
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_ARRIVEE}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}
    Click Element    ${CHAMP_RESERVATION_ARRIVEE}

    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Cliquer Sur Une Date De Calendrier De Facon Robuste    ${CALENDRIER_JOUR_DISPONIBLE}
    Sleep    1s
    Cliquer Sur Une Date De Calendrier De Facon Robuste    ${CALENDRIER_JOUR_DISPONIBLE_2}

    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_DEPART}

Cliquer Sur Une Date De Calendrier De Facon Robuste
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Wait Until Page Contains Element    ${locator}    ${TIMEOUT_UI}
    Scroll Element Into View    ${locator}
    ${clicked}=    Run Keyword And Return Status    Click Element    ${locator}
    IF    not ${clicked}
        Cliquer Sur Element Via Javascript    ${locator}
    END

Ouvrir Le Calendrier Depuis Le Champ Arrivee
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_ARRIVEE}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}
    Click Element    ${CHAMP_RESERVATION_ARRIVEE}
    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Wait Until Page Contains Element    ${CALENDRIER_JOUR_DISPONIBLE}    ${TIMEOUT_UI}

Ouvrir Le Selecteur Voyageurs
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_VOYAGEURS}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_VOYAGEURS}
    Click Element    ${CHAMP_RESERVATION_VOYAGEURS}
    Wait Until Page Contains Element    ${VOYAGEURS_PANEL}    ${TIMEOUT_UI}
    Wait Until Page Contains Element    ${BTN_APPLIQUER_VOYAGEURS}    ${TIMEOUT_UI}

Selectionner Des Voyageurs
    [Arguments]    ${adultes}=1    ${enfants}=1
    Ouvrir Le Selecteur Voyageurs

    FOR    ${index}    IN RANGE    ${adultes}
        Cliquer Sur Element De Facon Robuste    ${BTN_ADULTE_PLUS}
    END

    FOR    ${index}    IN RANGE    ${enfants}
        Cliquer Sur Element De Facon Robuste    ${BTN_ENFANT_PLUS}
    END

    Cliquer Sur Element De Facon Robuste    ${BTN_APPLIQUER_VOYAGEURS}

Selectionner L Extra Breakfast
    Wait Until Page Contains Element    ${LBL_EXTRA_BREAKFAST}    ${TIMEOUT_UI}
    Scroll Element Into View    ${LBL_EXTRA_BREAKFAST}
    Cliquer Sur Element De Facon Robuste    ${LBL_EXTRA_BREAKFAST}

Selectionner L Extra Lunch
    Wait Until Page Contains Element    ${LBL_EXTRA_LUNCH}    ${TIMEOUT_UI}
    Scroll Element Into View    ${LBL_EXTRA_LUNCH}
    Cliquer Sur Element De Facon Robuste    ${LBL_EXTRA_LUNCH}

Selectionner L Extra Dinner
    Wait Until Page Contains Element    ${LBL_EXTRA_DINNER}    ${TIMEOUT_UI}
    Scroll Element Into View    ${LBL_EXTRA_DINNER}
    Cliquer Sur Element De Facon Robuste    ${LBL_EXTRA_DINNER}

Cliquer Sur Demande De Reservation
    Scroll Element Into View    ${BTN_DEMANDE_RESERVATION}
    Wait Until Element Is Visible    ${BTN_DEMANDE_RESERVATION}    ${TIMEOUT_UI}
    ${clicked}=    Run Keyword And Return Status    Click Button    ${BTN_DEMANDE_RESERVATION}
    IF    not ${clicked}
        Cliquer Sur Element Via Javascript    ${BTN_DEMANDE_RESERVATION}
    END

Se Connecter En Tant Qu Utilisateur Reservation
    Wait Until Page Contains Element    xpath=//a[contains(text(),'Se connecter')]    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    xpath=//a[contains(text(),'Se connecter')]
    Wait Until Page Contains Element    name=username    ${TIMEOUT_UI}
    Input Text    name=username    ${USER_LOGIN_RESERVATION}
    Input Text    name=password    ${USER_PASSWORD_RESERVATION}
    Cliquer Sur Element De Facon Robuste    ${BTN_LOGIN}

Finaliser Le Parcours Apres Demande De Reservation
    Wait Until Page Contains Element    css=.block-body-sidebar .payment-list-price-detail    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    css=.block-body-sidebar .payment-list-price-detail

Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Wait Until Element Is Visible    name=arrive    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    name=arrive
    Wait Until Page Contains Element    ${CALENDRIER_DATE_1_CONNECTE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${CALENDRIER_DATE_1_CONNECTE}
    Wait Until Page Contains Element    ${CALENDRIER_DATE_2_CONNECTE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${CALENDRIER_DATE_2_CONNECTE}

Selectionner Des Voyageurs Connecte
    Cliquer Sur Element De Facon Robuste    name=guests
    Cliquer Sur Element De Facon Robuste    ${BTN_ADULTE_PLUS_CONNECTE}
    Cliquer Sur Element De Facon Robuste    ${BTN_ADULTE_PLUS_CONNECTE}
    Cliquer Sur Element De Facon Robuste    ${BTN_ENFANT_PLUS_CONNECTE}
    Cliquer Sur Element De Facon Robuste    ${BTN_APPLIQUER_VOYAGEURS_CONNECTE}

Finaliser Le Parcours Apres Demande De Reservation
    Wait Until Page Contains Element    ${BTN_FINALISER_APRES_DEMANDE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${BTN_FINALISER_APRES_DEMANDE}
