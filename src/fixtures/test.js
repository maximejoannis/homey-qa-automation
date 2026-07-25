const base = require('@playwright/test');

const { HomePage } = require('../pages/HomePage');
const { LoginModal } = require('../pages/LoginModal');
const {
  SearchResultsPage,
} = require('../pages/SearchResultsPage');
const {
  ListingPage,
} = require('../pages/ListingPage');
const {
  DashboardPage,
} = require('../pages/DashboardPage');


const test = base.test.extend({
  homePage: async ({ page }, use) => {
    const homePage = new HomePage(page);

    await use(homePage);
  },

  loginModal: async ({ page }, use) => {
    const loginModal = new LoginModal(page);

    await use(loginModal);
  },

  searchResultsPage: async ({ page }, use) => {
    const searchResultsPage =
      new SearchResultsPage(page);

    await use(searchResultsPage);
  },

  listingPage: async ({ page }, use) => {
    const listingPage = new ListingPage(page);

    await use(listingPage);
  },

  dashboardPage: async ({ page }, use) => {
    const dashboardPage = new DashboardPage(page);

    await use(dashboardPage);
  },

});

module.exports = {
  test,
  expect: base.expect,
};