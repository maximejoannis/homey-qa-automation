const {
  test,
  expect,
} = require('../../src/fixtures/test');

const {
  reservationData,
} = require('../../src/data/reservation');

const {
  traveler,
} = require('../../src/data/users');

test.describe(
  'US03 - Voyageur authentifié par storageState',
  () => {
    test.fixme(
      'TC-US03-AC01-02 voyageur connecté peut envoyer une demande valide',
      async () => {
        /*
         * Test exclu temporairement du périmètre d’automatisation.
         *
         * Motifs :
         * - anomalie applicative : l’hôte ne reçoit pas les demandes
         *   de réservation envoyées par le voyageur ;
         * - l’environnement de formation ne peut pas être réinitialisé ;
         * - les réservations créées persistent et consomment les
         *   périodes disponibles ;
         * - le scénario ne peut donc pas être exécuté de manière
         *   répétable et fiable dans la CI.
         *
         * Ce test pourra être réactivé lorsque :
         * 1. l’anomalie de transmission des demandes sera corrigée ;
         * 2. un environnement réinitialisable ou des données de test
         *    maîtrisées seront disponibles.
         */
      }
    );

    test(
      'TC-US03-AC02-02 le nombre de voyageurs égal à zéro est refusé @critical',
      async ({
        page,
        homePage,
        searchResultsPage,
        listingPage,
      }) => {
        await page.goto('/');

        await test.step(
          'Vérifier que le voyageur est connecté',
          async () => {
            await expect(
              page
                .getByText(traveler.username, {
                  exact: false,
                })
                .first()
            ).toBeVisible({
              timeout: 10_000,
            });
          }
        );

        await test.step(
          'Rechercher et ouvrir une annonce',
          async () => {
            await homePage.search();

            await searchResultsPage.openListing(
              reservationData.listingIndex
            );

            await listingPage.expectLoaded();
          }
        );

        await test.step(
          'Renseigner des dates de réservation',
          async () => {
            await listingPage
              .setFutureDatesForAuthenticationCheck(
                30,
                reservationData.minimumStayDays
              );
          }
        );

        await test.step(
          'Ne sélectionner aucun voyageur',
          async () => {
            await listingPage.expectNoGuestsSelected();
          }
        );

        await test.step(
          'Vérifier que zéro voyageur est refusé',
          async () => {
            await listingPage.requestButton.click();

            await expect(
              page.getByText(
                /veuillez choisir des voyageurs/i
              )
            ).toBeVisible({
              timeout: 5_000,
            });
          }
        );
      }
    );
  }
);
