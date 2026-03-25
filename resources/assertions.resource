*** Settings ***
Resource    ../resources/common.resource

*** Keywords ***
Textfield Value Should Be
    [Arguments]    ${locator}    ${expected}
    ${value}=    Get Value    ${locator}
    Should Be Equal    ${value}    ${expected}

Textarea Value Should Be
    [Arguments]    ${locator}    ${expected}
    ${value}=    Get Value    ${locator}
    Should Be Equal    ${value}    ${expected}

Le Champ Doit Avoir La Valeur D Attribut
    [Arguments]    ${locator}    ${attribute}    ${expected}
    ${value}=    Get Element Attribute    ${locator}    ${attribute}
    Should Be Equal    ${value}    ${expected}

Le Champ Doit Avoir Un Attribut Non Vide
    [Arguments]    ${locator}    ${attribute}
    ${value}=    Get Element Attribute    ${locator}    ${attribute}
    Should Not Be Empty    ${value}
