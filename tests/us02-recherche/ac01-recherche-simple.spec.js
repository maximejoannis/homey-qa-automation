const { test, expect } = require('../../src/fixtures/test');

test.describe('US02 - Réaliser une recherche simple', () => {
  test(
    'TC-US02-AC01-01 recherche sans critère affiche au moins un résultat @smoke',
    async ({ page, homePage, searchResultsPage }) => {
      await homePage.goto();
      await homePage.search();

      await expect(page).toHaveURL(url => url.pathname !== '/');
      await expect(searchResultsPage.searchButton).toBeVisible();
      await expect(searchResultsPage.results).not.toHaveCount(0);
      await expect(searchResultsPage.results.first()).toBeVisible();
    }
  );

  test(
    'TC-US02-AC02-01 un résultat ouvre une annonce avec formulaire de réservation',
    async ({ homePage, searchResultsPage, listingPage }) => {
      await homePage.goto();
      await homePage.search();
      await searchResultsPage.openListing(0);
      await listingPage.expectLoaded();
    }
  );

  test(
    'TC-US02-AC03-01 champs de dates visibles et éditables',
    async ({ homePage }) => {
      await homePage.goto();

      await expect(homePage.startDateInput).toBeVisible();
      await expect(homePage.startDateInput).toBeEditable();
      await expect(homePage.endDateInput).toBeVisible();
      await expect(homePage.endDateInput).toBeEditable();
    }
  );

  test(
    'TC-US02-AC03-02 destination de plus de 20 caractères sélectionnée',
    async ({ homePage }) => {
      await homePage.goto();

      const destination = 'Las Palmas de Gran Canaria';
      expect(destination.length).toBeGreaterThan(20);

      await homePage.selectDestination(destination);
      await expect(
        homePage.destinationInput.locator('option:checked')
      ).toHaveText(destination);
    }
  );
});
