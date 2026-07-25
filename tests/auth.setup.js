const { test: setup, expect } = require('@playwright/test');
const { traveler } = require('../src/data/users');
const { HomePage } = require('../src/pages/HomePage');
const { LoginModal } = require('../src/pages/LoginModal');
const { DashboardPage } = require('../src/pages/DashboardPage');

const travelerAuthFile = 'playwright/.auth/traveler.json';

setup('authentification Voyageur', async ({ page }) => {
  setup.skip(
    !traveler.username || !traveler.password,
    'Identifiants Voyageur requis dans TRAVELER_USERNAME et TRAVELER_PASSWORD.'
  );

  const homePage = new HomePage(page);
  const loginModal = new LoginModal(page);
  const dashboardPage = new DashboardPage(page);

  await homePage.goto();
  await homePage.openLogin();
  await loginModal.login(traveler.username, traveler.password);
  await dashboardPage.expectTravelerDashboard();

  await page.context().storageState({ path: travelerAuthFile });
  await expect(page).toHaveURL(/\/dashboard\/?/i);
});
