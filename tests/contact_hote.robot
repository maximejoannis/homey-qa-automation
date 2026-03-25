*** Settings ***
Documentation       Parcours contacter l'hôte depuis une annonce
Resource            ../resources/common.resource
Resource            ../resources/navigation.resource
Resource            ../resources/contact_hote.resource
Resource            ../resources/assertions.resource
Resource            ../variables/data.robot
Test Setup          Setup Test
Test Teardown       Teardown Test

*** Test Cases ***
CONTACT-CT01 - Ouvrir la modal contacter l'hôte
    [Tags]    regression    contact_hote    quarantine
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Page Should Contain Element    ${MODAL_CONTACTER_HOTE}

CONTACT-CT02 - Vérifier la présence des champs du formulaire
    [Tags]    smoke    regression    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Le Formulaire Contacter L Hote Doit Etre Visible

CONTACT-CT03 - Renseigner les champs du formulaire
    [Tags]    smoke    regression    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Renseigner Le Formulaire Contacter L Hote
    ...    ${CONTACT_NOM}
    ...    ${CONTACT_EMAIL}
    ...    ${CONTACT_TELEPHONE}
    ...    ${CONTACT_MESSAGE}
    Les Valeurs Saisies Doivent Etre Conservees
    ...    ${CONTACT_NOM}
    ...    ${CONTACT_EMAIL}
    ...    ${CONTACT_TELEPHONE}
    ...    ${CONTACT_MESSAGE}

CONTACT-CT04 - Fermer la modal via le bouton de fermeture
    [Tags]    regression    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Fermer La Modal Contacter L Hote
    Wait Until Element Is Not Visible    ${MODAL_CONTACTER_HOTE}    ${TIMEOUT_UI}

CONTACT-CT05 - Vérifier la présence des champs cachés du formulaire
    [Tags]    regression    ui    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Les Champs Caches Contacter L Hote Doivent Etre Presents

CONTACT-CT06 - Vérifier les placeholders et attributs principaux
    [Tags]    regression    ui    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_CONTACT_NOM}    placeholder
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_CONTACT_EMAIL}    placeholder
    Le Champ Doit Avoir Un Attribut Non Vide    ${CHAMP_CONTACT_MESSAGE}    placeholder

CONTACT-CT07 - Soumettre le formulaire
    [Tags]    regression    contact_hote    quarantine
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Renseigner Le Formulaire Contacter L Hote
    ...    ${CONTACT_NOM}
    ...    ${CONTACT_EMAIL}
    ...    ${CONTACT_TELEPHONE}
    ...    ${CONTACT_MESSAGE}
    Soumettre Le Formulaire Contacter L Hote

CONTACT-CT08 - Vérifier le titre de la modal
    [Tags]    regression    ui    contact_hote
    Aller Sur La Premiere Annonce Depuis La Home
    Ouvrir La Modal Contacter L Hote
    Element Should Be Visible    ${TITRE_MODAL_CONTACT}
