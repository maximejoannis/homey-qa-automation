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
