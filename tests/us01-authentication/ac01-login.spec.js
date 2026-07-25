const { test } = require('../../src/fixtures/test');
const { traveler, host, invalidUser } = require('../../src/data/users');

test.describe('US01 - Se connecter', () => {
  test(
    'TC-US01-AC01-01 connexion Voyageur réussie @smoke @critical',
    async ({ homePage, loginModal, dashboardPage }) => {
      test.skip(
        !traveler.username || !traveler.password,
        'Identifiants Voyageur requis dans TRAVELER_USERNAME et TRAVELER_PASSWORD.'
      );

      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(traveler.username, traveler.password);
      await dashboardPage.expectTravelerDashboard();
    }
  );

  test(
    'TC-US01-AC01-02 connexion Hôte réussie @critical',
    async ({ homePage, loginModal, dashboardPage }) => {
      test.skip(
        !host.username || !host.password,
        'Identifiants Hôte requis dans les variables HOST_USERNAME/HOST_PASSWORD.'
      );

      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(host.username, host.password);
      await dashboardPage.expectHostDashboard();
    }
  );

  test(
    'TC-US01-AC02-01 coordonnées invalides : erreur affichée et aucune connexion',
    async ({ homePage, loginModal }) => {
      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(invalidUser.username, invalidUser.password);
      await loginModal.expectInvalidCredentials();
    }
  );

  test(
    'TC-US01-AC02-02 popup contient les fonctions attendues',
    async ({ homePage, loginModal }) => {
      await homePage.goto();
      await homePage.openLogin();
      await loginModal.expectRequiredFunctions();
    }
  );
});
