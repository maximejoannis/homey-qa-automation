*** Settings ***
Resource    ../resources/common.resource
Resource    ../variables/env.robot

*** Keywords ***
Ouvrir La Modal Contacter L Hote
    Wait Until Element Is Visible    ${BTN_CONTACTER_HOTE}    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    ${BTN_CONTACTER_HOTE}
    Wait Until Element Is Visible    ${MODAL_CONTACTER_HOTE}    ${TIMEOUT_UI}

Fermer La Modal Contacter L Hote
    Wait Until Element Is Visible    ${BTN_FERMER_MODAL_CONTACT}    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    ${BTN_FERMER_MODAL_CONTACT}

Le Formulaire Contacter L Hote Doit Etre Visible
    Page Should Contain Element    ${CHAMP_CONTACT_NOM}
    Page Should Contain Element    ${CHAMP_CONTACT_EMAIL}
    Page Should Contain Element    ${CHAMP_CONTACT_TELEPHONE}
    Page Should Contain Element    ${CHAMP_CONTACT_MESSAGE}
    Page Should Contain Element    ${BTN_CONTACT_SOUMETTRE}
    Page Should Contain Element    ${ZONE_CONTACT_MESSAGES}

Renseigner Le Formulaire Contacter L Hote
    [Arguments]    ${nom}    ${email}    ${telephone}    ${message}
    Wait Until Element Is Visible    ${CHAMP_CONTACT_NOM}    ${TIMEOUT_UI}
    Click Element    ${CHAMP_CONTACT_NOM}
    Input Text    ${CHAMP_CONTACT_NOM}    ${nom}

    Click Element    ${CHAMP_CONTACT_EMAIL}
    Input Text    ${CHAMP_CONTACT_EMAIL}    ${email}

    Click Element    ${CHAMP_CONTACT_TELEPHONE}
    Input Text    ${CHAMP_CONTACT_TELEPHONE}    ${telephone}

    Click Element    ${CHAMP_CONTACT_MESSAGE}
    Input Text    ${CHAMP_CONTACT_MESSAGE}    ${message}

Soumettre Le Formulaire Contacter L Hote
    Wait Until Element Is Visible    ${BTN_CONTACT_SOUMETTRE}    ${TIMEOUT_UI}
    Cliquer Sur Element De Facon Robuste    ${BTN_CONTACT_SOUMETTRE}

Les Valeurs Saisies Doivent Etre Conservees
    [Arguments]    ${nom}    ${email}    ${telephone}    ${message}
    Textfield Value Should Be    ${CHAMP_CONTACT_NOM}        ${nom}
    Textfield Value Should Be    ${CHAMP_CONTACT_EMAIL}      ${email}
    Textfield Value Should Be    ${CHAMP_CONTACT_TELEPHONE}  ${telephone}
    Textarea Value Should Be     ${CHAMP_CONTACT_MESSAGE}    ${message}

Les Champs Caches Contacter L Hote Doivent Etre Presents
    Page Should Contain Element    ${HIDDEN_TARGET_EMAIL}
    Page Should Contain Element    ${HIDDEN_HOST_CONTACT_SECURITY}
    Page Should Contain Element    ${HIDDEN_PERMALINK}
    Page Should Contain Element    ${HIDDEN_LISTING_TITLE}
    Page Should Contain Element    ${HIDDEN_ACTION}
