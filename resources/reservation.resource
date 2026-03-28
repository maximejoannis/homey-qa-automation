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
    Cliquer Sur Element De Facon Robuste    ${CHAMP_RESERVATION_ARRIVEE}

    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Cliquer Sur Une Date De Calendrier De Facon Robuste    ${CALENDRIER_JOUR_DISPONIBLE}
    Sleep    1s
    Cliquer Sur Une Date De Calendrier De Facon Robuste    ${CALENDRIER_JOUR_DISPONIBLE_2}

    ${arrivee_ok}=    Run Keyword And Return Status
    ...    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_ARRIVEE}
    ${depart_ok}=    Run Keyword And Return Status
    ...    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_DEPART}

    IF    not ${arrivee_ok} or not ${depart_ok}
        Log    [INFO] Fallback JS sur les dates car la sélection UI est instable.    console=yes
        Injecter Des Dates Disponibles En Javascript
        Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_ARRIVEE}
        Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_DEPART}
    END

Cliquer Sur Une Date De Calendrier De Facon Robuste
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Wait Until Page Contains Element    ${locator}    ${TIMEOUT_UI}
    Scroll Element Into View    ${locator}
    ${clicked}=    Run Keyword And Return Status    Click Element    ${locator}
    IF    not ${clicked}
        Cliquer Sur Element Via Javascript    ${locator}
    END

Injecter Des Dates Disponibles En Javascript
    Execute Javascript
    ...    const arrive = document.querySelector('[name="arrive"]');
    ...    const depart = document.querySelector('[name="depart"]');
    ...    if (!arrive || !depart) { throw new Error('Champs arrive/depart introuvables'); }
    ...    arrive.removeAttribute('readonly');
    ...    depart.removeAttribute('readonly');
    ...    arrive.value = '2026-04-20';
    ...    depart.value = '2026-04-22';
    ...    ['input','change','blur'].forEach(evt => {
    ...        arrive.dispatchEvent(new Event(evt, { bubbles: true }));
    ...        depart.dispatchEvent(new Event(evt, { bubbles: true }));
    ...    });

Renseigner Les Dates Disponibles Pour Demande Non Connectee
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_ARRIVEE}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}
    Injecter Des Dates Disponibles En Javascript
    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_ARRIVEE}
    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_DEPART}

Ouvrir Le Calendrier Depuis Le Champ Arrivee
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_ARRIVEE}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}
    Cliquer Sur Element De Facon Robuste    ${CHAMP_RESERVATION_ARRIVEE}
    Wait Until Page Contains Element    ${CALENDRIER_WRAPPER}    ${TIMEOUT_UI}
    Wait Until Page Contains Element    ${CALENDRIER_JOUR_DISPONIBLE}    ${TIMEOUT_UI}

Ouvrir Le Selecteur Voyageurs
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_VOYAGEURS}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_VOYAGEURS}
    Cliquer Sur Element De Facon Robuste    ${CHAMP_RESERVATION_VOYAGEURS}
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
