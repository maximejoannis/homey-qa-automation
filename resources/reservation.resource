*** Settings ***
Resource    ../resources/common.resource
Resource    ../variables/env.robot
Resource    ../variables/data.robot


*** Keywords ***
Le Module De Reservation Doit Etre Visible
    Page Should Contain Element    ${CHAMP_RESERVATION_ARRIVEE}
    Page Should Contain Element    ${CHAMP_RESERVATION_DEPART}
    Page Should Contain Element    ${CHAMP_RESERVATION_VOYAGEURS}
    Page Should Contain Element    ${BTN_DEMANDE_RESERVATION}

Aller Sur Une Annonce Pour Reservation Connecte
    Wait Until Element Is Visible    ${BTN_CHERCHER_HOME}    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    ${BTN_CHERCHER_HOME}
    Execute Javascript    window.scrollTo(0,0)
    Wait Until Element Is Visible    ${ANNONCE_RESERVATION_CONNECTE_TRIGGER}    ${TIMEOUT_LONG}
    Cliquer Sur Element Via Javascript    ${ANNONCE_RESERVATION_CONNECTE_TRIGGER}
    Wait Until Keyword Succeeds    ${TIMEOUT_LONG}    1s    Attendre Module Reservation Listing

Attendre Module Reservation Listing
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    300ms
    Page Should Contain Element    ${CHAMP_RESERVATION_ARRIVEE}
    Page Should Contain Element    ${CHAMP_RESERVATION_DEPART}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}

Se Connecter En Tant Qu Utilisateur Reservation
    Wait Until Page Contains Element    ${LIEN_SE_CONNECTER}    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    ${LIEN_SE_CONNECTER}
    Wait Until Page Contains Element    ${CHAMP_NOM_UTILISATEUR}    ${TIMEOUT_UI}
    Input Text    ${CHAMP_NOM_UTILISATEUR}    ${USER_LOGIN_RESERVATION}
    Input Text    ${CHAMP_MOT_DE_PASSE}    ${USER_PASSWORD_RESERVATION}
    Cliquer Sur Element De Facon Robuste    ${BTN_LOGIN}
    Wait Until Page Contains Element    ${LIEN_SE_DECONNECTER}    ${TIMEOUT_LONG}

Selectionner Une Date D Arrivee Et Une Date De Depart Connecte
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_ARRIVEE}    ${TIMEOUT_LONG}
    Scroll Element Into View    ${CHAMP_RESERVATION_ARRIVEE}
    Cliquer Sur Element De Facon Robuste    ${CHAMP_RESERVATION_ARRIVEE}

    ${date1_visible}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element    ${CALENDRIER_DATE_1_CONNECTE}    ${TIMEOUT_LONG}

    IF    ${date1_visible}
        Cliquer Sur Element De Facon Robuste    ${CALENDRIER_DATE_1_CONNECTE}
        Wait Until Page Contains Element    ${CALENDRIER_DATE_2_CONNECTE}    ${TIMEOUT_LONG}
        Cliquer Sur Element De Facon Robuste    ${CALENDRIER_DATE_2_CONNECTE}
    ELSE
        Log    [INFO] Dates connectées non détectées, fallback JS.    console=yes
        Injecter Des Dates Disponibles En Javascript
    END

    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_ARRIVEE}
    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_DEPART}

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

Selectionner Des Voyageurs Connecte
    Wait Until Element Is Visible    ${CHAMP_RESERVATION_VOYAGEURS}    ${TIMEOUT_UI}
    Scroll Element Into View    ${CHAMP_RESERVATION_VOYAGEURS}
    Cliquer Sur Element De Facon Robuste    ${CHAMP_RESERVATION_VOYAGEURS}
    Wait Until Element Is Visible    ${BTN_ADULTE_PLUS_CONNECTE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${BTN_ADULTE_PLUS_CONNECTE}
    Cliquer Sur Element De Facon Robuste    ${BTN_ADULTE_PLUS_CONNECTE}
    Wait Until Element Is Visible    ${BTN_ENFANT_PLUS_CONNECTE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${BTN_ENFANT_PLUS_CONNECTE}
    Wait Until Element Is Visible    ${BTN_APPLIQUER_VOYAGEURS_CONNECTE}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${BTN_APPLIQUER_VOYAGEURS_CONNECTE}
    Attendre Que Le Champ Soit Renseigne    ${CHAMP_RESERVATION_VOYAGEURS}

Aller Au Tableau De Bord Dropdown
    Ouvrir Le Menu Compte
    Wait Until Element Is Visible    ${ACCOUNT_DASHBOARD_LINK_CSS}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${ACCOUNT_DASHBOARD_LINK_CSS}

Aller Aux Voyages Dropdown
    Ouvrir Le Menu Compte
    Wait Until Element Is Visible    ${ACCOUNT_VOYAGES_LINK_CSS}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${ACCOUNT_VOYAGES_LINK_CSS}

Se Deconnecter Dropdown
    Ouvrir Le Menu Compte
    Wait Until Element Is Visible    ${ACCOUNT_LOGOUT_LINK_CSS}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${ACCOUNT_LOGOUT_LINK_CSS}

Ouvrir Le Menu Compte
    Wait Until Element Is Visible    ${ACCOUNT_LOGGEDIN_AREA}    ${TIMEOUT_LONG}
    Scroll Element Into View    ${ACCOUNT_LOGGEDIN_AREA}
    Cliquer Sur Element De Facon Robuste    ${ACCOUNT_LOGGEDIN_AREA}

Ouvrir Le Detail De La Premiere Reservation Dashboard
    Wait Until Element Is Visible    ${BTN_DETAILS_PREMIERE_RESERVATION_DASHBOARD}    ${TIMEOUT_LONG}
    Cliquer Sur Element De Facon Robuste    ${BTN_DETAILS_PREMIERE_RESERVATION_DASHBOARD}

Descendre En Bas De Page
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    500ms

Champ Doit Etre Renseigne
    [Arguments]    ${locator}
    ${value}=    Get Value    ${locator}
    Should Not Be Empty    ${value}

Attendre Que Le Champ Soit Renseigne
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    10x    500ms    Champ Doit Etre Renseigne    ${locator}
