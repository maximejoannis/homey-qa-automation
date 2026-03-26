*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    OperatingSystem
Library    String

Resource   ../variables/env.robot

*** Keywords ***
Setup Test
    Log    ==================================================    console=yes
    Log    [SETUP] Test: ${TEST NAME}    console=yes
    Log    [SETUP] URL: ${BASE_URL}    console=yes
    Log    [SETUP] Navigateur: ${BROWSER}    console=yes
    Log    [SETUP] Remote URL: ${REMOTE_URL}    console=yes
    Ouvrir Le Navigateur Et Acceder A L Application

Teardown Test
    Run Keyword If Test Failed    Capturer Les Preuves En Cas D Echec
    ${current_url}=    Recuperer L Url Courante De Facon Securisee
    Log    [TEARDOWN] URL finale: ${current_url}    console=yes
    Fermer Le Navigateur De Facon Securisee

Ouvrir Le Navigateur Et Acceder A L Application
    IF    '${REMOTE_URL}' != 'None'
        Open Browser    ${BASE_URL}    ${BROWSER}    remote_url=${REMOTE_URL}
    ELSE
        Open Browser    ${BASE_URL}    ${BROWSER}
    END
    Register Keyword To Run On Failure    NONE
    Set Window Size    1920    1080
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT}
    Attendre Le Chargement De La Page

Attendre Le Chargement De La Page
    Wait Until Keyword Succeeds    5x    2s    Wait Until Page Contains Element    css=body    ${TIMEOUT_UI}

Fermer Le Navigateur De Facon Securisee
    ${result}=    Run Keyword And Ignore Error    Close Browser
    IF    '${result}[0]' != 'PASS'
        Log    [WARN] Impossible de fermer le navigateur proprement.    console=yes
    END

Capturer Les Preuves En Cas D Echec
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${safe_name}=    Convertir Le Nom De Test En Nom De Fichier    ${TEST NAME}

    Create Directory    results
    Capturer Une Capture D Ecran De Facon Securisee    results/FAIL_${safe_name}_${timestamp}.png
    Sauvegarder Le Html De La Page Si Disponible    results/FAIL_${safe_name}_${timestamp}.html

Convertir Le Nom De Test En Nom De Fichier
    [Arguments]    ${name}
    ${safe}=    Replace String Using Regexp    ${name}    ["<>:|*?\r\n]    _
    ${safe}=    Replace String Using Regexp    ${safe}    [\\/]    _
    ${safe}=    Replace String Using Regexp    ${safe}    \s+    _
    RETURN    ${safe}

Capturer Une Capture D Ecran De Facon Securisee
    [Arguments]    ${path}
    ${result}=    Run Keyword And Ignore Error    Capture Page Screenshot    ${path}
    IF    '${result}[0]' != 'PASS'
        Log    [WARN] Impossible de capturer le screenshot.    console=yes
    END

Sauvegarder Le Html De La Page Si Disponible
    [Arguments]    ${path}
    ${source_result}=    Run Keyword And Ignore Error    Get Source
    IF    '${source_result}[0]' == 'PASS'
        Create File    ${path}    ${source_result}[1]    encoding=UTF-8
    END

Recuperer L Url Courante De Facon Securisee
    ${result}=    Run Keyword And Ignore Error    Get Location
    IF    '${result}[0]' != 'PASS'
        RETURN    N/A
    END
    RETURN    ${result}[1]

Cliquer Sur Element De Facon Robuste
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    ${TIMEOUT_UI}
    Scroll Element Into View    ${locator}
    ${clicked}=    Run Keyword And Return Status    Click Element    ${locator}
    IF    not ${clicked}
        Cliquer Sur Element Via Javascript    ${locator}
    END

Cliquer Sur Element Via Javascript
    [Arguments]    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Le Champ Ne Doit Pas Etre Vide
    [Arguments]    ${locator}
    ${value}=    Get Value    ${locator}
    Should Not Be Empty    ${value}

Attendre Que Le Champ Soit Renseigne
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    5x    1s    Le Champ Ne Doit Pas Etre Vide    ${locator}

Extraire Une Valeur Avec Regex
    [Arguments]    ${texte}    ${pattern}
    ${matches}=    Get Regexp Matches    ${texte}    ${pattern}    1
    Should Not Be Empty    ${matches}
    RETURN    ${matches}[0]

Recuperer L Url Courante
    ${url}=    Get Location
    Should Not Be Empty    ${url}
    RETURN    ${url}

Recuperer L Id Reservation Depuis L Url
    ${url}=    Recuperer L Url Courante
    Log    [INFO] URL courante: ${url}    console=yes

    ${status}    ${reservation_id}=    Run Keyword And Ignore Error
    ...    Extraire Une Valeur Avec Regex    ${url}    .*/reservation/([0-9]+).*

    IF    '${status}' == 'PASS'
        Log    [INFO] ID réservation trouvé dans le path URL: ${reservation_id}    console=yes
        RETURN    ${reservation_id}
    END

    ${status}    ${reservation_id}=    Run Keyword And Ignore Error
    ...    Extraire Une Valeur Avec Regex    ${url}    .*booking_id=([0-9]+).*

    IF    '${status}' == 'PASS'
        Log    [INFO] ID réservation trouvé dans la query string: ${reservation_id}    console=yes
        RETURN    ${reservation_id}
    END

    Fail    Aucun identifiant de réservation exploitable trouvé dans l URL : ${url}

Verifier Que L Id Reservation Est Valide
    [Arguments]    ${reservation_id}
    Should Not Be Empty    ${reservation_id}
    Should Match Regexp    ${reservation_id}    ^[0-9]+$

Sauvegarder Le Contexte Runtime Reservation
    [Arguments]    ${reservation_id}
    Create Directory    results
    ${json}=    Catenate
    ...    {
    ...    "reservation_id":"${reservation_id}"
    ...    }
    Create File    results/runtime_context.json    ${json}    encoding=UTF-8
    Log    [INFO] runtime_context.json généré avec reservation_id=${reservation_id}    console=yes

Capturer Et Sauvegarder L Id Reservation
    ${reservation_id}=    Recuperer L Id Reservation Depuis L Url
    Verifier Que L Id Reservation Est Valide    ${reservation_id}
    Set Suite Variable    ${RESERVATION_ID}    ${reservation_id}
    Sauvegarder Le Contexte Runtime Reservation    ${reservation_id}
    Log    [INFO] RESERVATION_ID=${RESERVATION_ID}    console=yes
