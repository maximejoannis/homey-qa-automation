const { expect } = require('@playwright/test');

class HomePage {
  constructor(page) {
    this.page = page;

    // Recherche
    this.destinationInput = page.getByRole('combobox').first();
    this.startDateInput = page.getByRole('textbox', { name: /début/i }).first();
    this.endDateInput = page.getByRole('textbox', { name: /fin/i }).first();
    this.guestsInput = page.getByRole('textbox', { name: /voyageurs/i }).first();

    this.searchButton = page.getByRole('button', {
      name: /^chercher$/i,
    });

    // Connexion
    this.loginButton = page.getByRole('link', {
      name: /se connecter/i,
    });
  }

  async goto() {
    await this.page.goto('/');
  }

  async openLogin() {
    await this.loginButton.click();
  }

  async search() {
    await this.searchButton.click();
  }

  async selectDestination(destination) {
    await this.destinationInput.selectOption({
      label: destination,
    });
  }
}

module.exports = { HomePage };