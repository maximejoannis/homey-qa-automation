*** Settings ***
Resource    ../resources/common.resource
Resource    ../variables/env.robot

*** Keywords ***
Aller Sur La Premiere Annonce Depuis La Home
    Go To    ${BASE_URL}
    Attendre Le Chargement De La Page
    Execute Javascript    window.scrollTo(0, 0)

    ${search_button_present}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element    ${BTN_CHERCHER_HOME}    5s

    IF    ${search_button_present}
        Cliquer Sur Element De Facon Robuste    ${BTN_CHERCHER_HOME}
        Sleep    2s
    END

    Wait Until Page Contains Element    ${PREMIERE_ANNONCE_TRIGGER}    ${TIMEOUT_UI}
    Scroll Element Into View    ${PREMIERE_ANNONCE_TRIGGER}
    Wait Until Keyword Succeeds    3x    2s    Cliquer Sur Element De Facon Robuste    ${PREMIERE_ANNONCE_TRIGGER}
