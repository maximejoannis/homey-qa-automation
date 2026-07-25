const {
  test,
} = require('../../src/fixtures/test');

const {
  reservationData,
} = require('../../src/data/reservation');

test.describe(
  'US03 - Faire une demande de réservation',
  () => {
    test.beforeEach(
      async ({
        homePage,
        searchResultsPage,
        listingPage,
      }) => {
        await homePage.goto();

        await homePage.search();

        await searchResultsPage.openListing(
          reservationData.listingIndex
        );

        await listingPage.expectLoaded();
      }
    );

    test(
      'TC-US03-AC01-01 visiteur non connecté peut commencer mais pas finaliser @smoke @critical',
      async ({
        listingPage,
      }) => {
        const selectedPeriod =
          await listingPage.setFutureDatesForAuthenticationCheck(
            30,
            reservationData.minimumStayDays
          );

        test.info().annotations.push({
          type: 'Période injectée',
          description:
            `${selectedPeriod.startValue} → ` +
            `${selectedPeriod.endValue} ` +
            `(${reservationData.minimumStayDays} jours)`,
        });

        await listingPage.setGuests(
          reservationData.guests
        );

        await listingPage.expectGuestCannotFinalize();
      }
    );

    test(
      'TC-US03-AC02-01 les dates passées ne sont pas proposées comme disponibles @regression',
      async ({
        listingPage,
      }) => {
        const checkedPastDates =
          await listingPage.expectPastDatesNotSelectable();

        test.info().annotations.push({
          type: 'Dates passées contrôlées',
          description: String(checkedPastDates),
        });
      }
    );
  }
);