// @ts-check
const { defineConfig, devices } = require('@playwright/test');
require('dotenv').config({ quiet: true });

if (!process.env.BASE_URL) {
  throw new Error(
    'BASE_URL est obligatoire. Configurez le secret GitHub BASE_URL ou votre fichier .env local.'
  );
}

module.exports = defineConfig({
  testDir: './tests',
  timeout: 30_000,
  expect: { timeout: 5000 },
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: 0,
  workers: 1,
  reporter: [
    ['list'],
    ['html', { outputFolder: 'playwright-report', open: 'never' }],
    ['allure-playwright', {
      resultsDir: 'allure-results',
      detail: true,
      suiteTitle: false,
      environmentInfo: {
        application: 'Homey',
        baseURL: process.env.BASE_URL || 'http://livraison3.testacademy.fr/',
        framework: 'Playwright',
        platform: process.platform,
        node: process.version,
      },
    }],
  ],
  use: {
    baseURL: process.env.BASE_URL || 'http://livraison3.testacademy.fr/',
    headless: true,
    ignoreHTTPSErrors: true,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
    actionTimeout: 12_000,
    navigationTimeout: 25_000,
    locale: 'fr-FR',
    launchOptions: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH
      ? { executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH }
      : undefined,
  },
  projects: [
    {
      name: 'setup',
      testMatch: /.*\.setup\.js/,
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'chromium',
      testMatch: /.*\.spec\.js/,
      testIgnore: /.*\.auth\.spec\.js/,
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'chromium-authenticated',
      testMatch: /.*\.auth\.spec\.js/,
      dependencies: ['setup'],
      use: {
        ...devices['Desktop Chrome'],
        storageState: 'playwright/.auth/traveler.json',
      },
    },
    {
      name: 'firefox',
      testMatch: /.*\.spec\.js/,
      testIgnore: /.*\.auth\.spec\.js/,
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'firefox-authenticated',
      testMatch: /.*\.auth\.spec\.js/,
      dependencies: ['setup'],
      use: {
        ...devices['Desktop Firefox'],
        storageState: 'playwright/.auth/traveler.json',
      },
    },
  ],
});
