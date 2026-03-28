*** Variables ***
${BASE_URL}                             http://livraison3.testacademy.fr
${BROWSER}                              chrome
${REMOTE_URL}                           None
${TIMEOUT_UI}                           15s
${TIMEOUT_LONG}                         30s
${SELENIUM_TIMEOUT}                     15s
${SELENIUM_IMPLICIT}                    0s

${BTN_CHERCHER_HOME}                    css=.search-button .btn-primary
${PREMIERE_ANNONCE_TRIGGER}             xpath=(//div[contains(@class,'infobox_trigger')]//*[contains(@class,'hover-effect')])[1]

${BTN_LOGIN}                            css=.homey_login_button

${CHAMP_RESERVATION_ARRIVEE}            name=arrive
${CHAMP_RESERVATION_DEPART}             name=depart
${CHAMP_RESERVATION_VOYAGEURS}          name=guests
${BTN_DEMANDE_RESERVATION}              id=request_for_reservation
${MSG_CONNEXION_POUR_RESERVATION}       Vous devez vous connecter

${CALENDRIER_WRAPPER}                   css=#single-booking-search-calendar
${CALENDRIER_JOUR_DISPONIBLE}           xpath=(//div[@id='single-booking-search-calendar']//td[not(contains(@class,'disabled')) and not(contains(@class,'past')) and not(contains(@class,'week')) and not(contains(@class,'datepicker-switch')) and .//span[contains(@class,'day-number')]])[1]
${CALENDRIER_JOUR_DISPONIBLE_2}         xpath=(//div[@id='single-booking-search-calendar']//td[not(contains(@class,'disabled')) and not(contains(@class,'past')) and not(contains(@class,'week')) and not(contains(@class,'datepicker-switch')) and .//span[contains(@class,'day-number')]])[2]

${VOYAGEURS_PANEL}                      xpath=(//div[contains(@class,'sidebar-booking-module-body')])[last()]
${BTN_ADULTE_PLUS}                      xpath=(//button[contains(@class,'adult_plus')] | //a[contains(@class,'adult_plus')] | //span[contains(@class,'adult_plus')] | //i[contains(@class,'adult_plus')])[1]
${BTN_ENFANT_PLUS}                      xpath=(//button[contains(@class,'child_plus')] | //a[contains(@class,'child_plus')] | //span[contains(@class,'child_plus')] | //i[contains(@class,'child_plus')])[1]
${BTN_APPLIQUER_VOYAGEURS}              xpath=(//button[contains(@class,'guest-apply-btn')] | //div[contains(@class,'guest-apply-btn')]//button | //div[contains(@class,'guest-apply-btn')]//*[contains(@class,'btn')])[1]

${CHK_EXTRA_BREAKFAST}                  css=#homey_remove_on_mobile input[name="extra_price[]"][data-name="Breakfast"]
${LBL_EXTRA_BREAKFAST}                  xpath=//div[@id='homey_remove_on_mobile']//label[contains(@class,'homey_extra_price')][.//span[contains(@class,'control-text') and normalize-space(.)='Breakfast']]

${CHK_EXTRA_LUNCH}                      css=#homey_remove_on_mobile input[name="extra_price[]"][data-name="Lunch"]
${LBL_EXTRA_LUNCH}                      xpath=//div[@id='homey_remove_on_mobile']//label[contains(@class,'homey_extra_price')][.//span[contains(@class,'control-text') and normalize-space(.)='Lunch']]

${CHK_EXTRA_DINNER}                     css=#homey_remove_on_mobile input[name="extra_price[]"][data-name="Dinner"]
${LBL_EXTRA_DINNER}                     xpath=//div[@id='homey_remove_on_mobile']//label[contains(@class,'homey_extra_price')][.//span[contains(@class,'control-text') and normalize-space(.)='Dinner']]

${BTN_CONTACTER_HOTE}                   xpath=//button[@data-target='#modal-contact-host']
${MODAL_CONTACTER_HOTE}                 id=modal-contact-host
${BTN_FERMER_MODAL_CONTACT}             css=#modal-contact-host button.close
${TITRE_MODAL_CONTACT}                  css=#modal-contact-host .modal-title
${FORM_CONTACTER_HOTE}                  xpath=//div[@id='modal-contact-host']//form[@method='POST']

${CHAMP_CONTACT_NOM}                    name=name
${CHAMP_CONTACT_EMAIL}                  name=email
${CHAMP_CONTACT_TELEPHONE}              name=phone
${CHAMP_CONTACT_MESSAGE}                name=message

${BTN_CONTACT_SOUMETTRE}                css=#modal-contact-host .contact_listing_host
${ZONE_CONTACT_MESSAGES}                css=#modal-contact-host .homey_contact_messages

${HIDDEN_TARGET_EMAIL}                  css=#modal-contact-host input[name="target_email"]
${HIDDEN_HOST_CONTACT_SECURITY}         css=#modal-contact-host input[name="host_contact_security"]
${HIDDEN_PERMALINK}                     css=#modal-contact-host input[name="permalink"]
${HIDDEN_LISTING_TITLE}                 css=#modal-contact-host input[name="listing_title"]
${HIDDEN_ACTION}                        css=#modal-contact-host input[name="action"]

${DEUXIEME_ANNONCE_TRIGGER}             css=.item-wrap:nth-child(2) .hover-effect

${CALENDRIER_DATE_1_CONNECTE}           css=.sidebar-booking-module-body:nth-child(2) .single-listing-calendar-wrap:nth-child(1) .current-month:nth-child(20) > .day-number
${CALENDRIER_DATE_2_CONNECTE}           css=.block-body-sidebar > #single-listing-date-range > #single-booking-search-calendar > .single-listing-calendar-wrap:nth-child(2) .current-month:nth-child(30) > .day-number

${BTN_ADULTE_PLUS_CONNECTE}             css=.sidebar-booking-module-body:nth-child(2) .adult_plus > .fa
${BTN_ENFANT_PLUS_CONNECTE}             css=.sidebar-booking-module-body:nth-child(2) .child_plus
${BTN_APPLIQUER_VOYAGEURS_CONNECTE}     css=.sidebar-booking-module-body:nth-child(2) .guest-apply-btn > .btn
${BTN_FINALISER_APRES_DEMANDE}          css=.block-body-sidebar .payment-list-price-detail
