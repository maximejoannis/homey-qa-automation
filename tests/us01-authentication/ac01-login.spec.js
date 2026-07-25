const { test } = require('../../src/fixtures/test');
const {
  traveler,
  host,
  invalidUser,
  invalidPassword,
} = require('../../src/data/users');

test.describe('US01 - Se connecter', () => {
  test(
    'TC-AUTH-001 ouverture de la popup et fonctions attendues @smoke',
    async ({ homePage, loginModal }) => {
      await homePage.goto();
      await homePage.openLogin();
      await loginModal.expectRequiredFunctions();
    }
  );

  test(
    'TC-AUTH-002 et TC-AUTH-003 connexion Voyageur et rubriques autorisées @smoke @critical',
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
    'TC-AUTH-004 et TC-AUTH-005 connexion Hôte et rubriques autorisées @critical',
    async ({ homePage, loginModal, dashboardPage }) => {
      test.skip(
        !host.username || !host.password,
        'Identifiants Hôte requis dans HOST_USERNAME et HOST_PASSWORD.'
      );

      await homePage.goto();
      await homePage.openLogin();
      await loginModal.login(host.username, host.password);
      await dashboardPage.expectHostDashboard();
    }
  );

  test(
    'TC-AUTH-006 identifiant inexistant : connexion refusée',
    async ({ homePage, loginModal }) => {
      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(
        invalidUser.username,
        invalidUser.password
      );

      await loginModal.expectUnknownUsernameRejected();
    }
  );

  test(
    'TC-AUTH-007 mot de passe erroné : connexion refusée',
    async ({ homePage, loginModal }) => {
      test.skip(
        !traveler.username,
        'Identifiant Voyageur requis dans TRAVELER_USERNAME.'
      );

      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(
        traveler.username,
        invalidPassword
      );

      await loginModal.expectWrongPasswordRejected(
        traveler.username
      );
    }
  );

  test(
    'TC-AUTH-010 déconnexion Voyageur réussie @critical',
    async ({ homePage, loginModal, dashboardPage }) => {
      test.skip(
        !traveler.username || !traveler.password,
        'Identifiants Voyageur requis dans TRAVELER_USERNAME et TRAVELER_PASSWORD.'
      );

      await homePage.goto();
      await homePage.openLogin();

      await loginModal.login(
        traveler.username,
        traveler.password
      );

      await dashboardPage.expectTravelerDashboard();
      await dashboardPage.logout();
    }
  );

  test.fixme(
    'TC-AUTH-008 champs vides : validation et aucune authentification',
    async () => {
      // À activer après observation du comportement réel.
    }
  );

  test.fixme(
    'TC-AUTH-009 se souvenir de moi : persistance conforme à la règle métier',
    async () => {
      // À activer après clarification de la règle métier.
    }
  );
});
