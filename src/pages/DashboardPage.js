const { expect } = require('@playwright/test');

class DashboardPage {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    this.page = page;

    /*
     * Éléments communs aux tableaux de bord
     * Voyageur et Hôte.
     */

    this.title = page.getByRole('heading', {
      name: /^tableau de bord$/i,
      level: 1,
    });

    this.welcomeMessage = page.getByRole('heading', {
      name: /bon retour parmi nous/i,
      level: 2,
    });

    this.dashboardLink = page
      .getByRole('link', {
        name: /^tableau de bord$/i,
      })
      .first();

    this.profileLink = page
      .getByRole('link', {
        name: /^profil/i,
      })
      .first();

    this.messagesLink = page
      .getByRole('link', {
        name: /^messages$/i,
      })
      .first();

    this.walletLink = page
      .getByRole('link', {
        name: /^portefeuille/i,
      })
      .first();

    this.invoicesLink = page
      .getByRole('link', {
        name: /^factures$/i,
      })
      .first();

    this.logoutLink = page
      .getByRole('link', {
        name: /^se déconnecter$/i,
      })
      .first();

    /*
     * Éléments spécifiques au Voyageur.
     */

    this.tripsLink = page
      .getByRole('link', {
        name: /^voyages$/i,
      })
      .first();

    this.favoritesLink = page
      .getByRole('link', {
        name: /^favoris$/i,
      })
      .first();

    this.reservationsTitle = page.getByRole('heading', {
      name: /^mes réservations$/i,
      level: 2,
    });

    this.recentMessagesTitle = page.getByRole('heading', {
      name: /^messages récents$/i,
      level: 2,
    });

    /*
     * Éléments spécifiques à l'Hôte.
     *
     * Les expressions régulières permettent de supporter
     * de légères différences de libellés dans l'application.
     */

    this.listingsLink = page
      .getByRole('link', {
        name: /mes annonces|annonces/i,
      })
      .first();

    this.createListingLink = page
      .getByRole('link', {
        name:
          /créer(?:\s+une)?\s+annonce|ajouter(?:\s+une)?\s+annonce|nouvelle annonce/i,
      })
      .first();

    this.reservationsLink = page
      .getByRole('link', {
        name: /^réservations$/i,
      })
      .first();
  }

  /**
   * Vérifie que l'utilisateur est connecté
   * et que le tableau de bord est chargé.
   */
  async expectLoaded() {
    await expect(this.page).toHaveURL(
      /\/dashboard\/?/i
    );

    await expect(this.title).toBeVisible();
    await expect(this.welcomeMessage).toBeVisible();
    await expect(this.logoutLink).toBeVisible();
  }

  /**
   * Vérifie le tableau de bord Voyageur.
   */
  async expectTravelerDashboard() {
    await this.expectLoaded();

    await expect(this.dashboardLink).toBeVisible();
    await expect(this.profileLink).toBeVisible();
    await expect(this.tripsLink).toBeVisible();
    await expect(this.walletLink).toBeVisible();
    await expect(this.favoritesLink).toBeVisible();
    await expect(this.invoicesLink).toBeVisible();
    await expect(this.messagesLink).toBeVisible();
    await expect(this.logoutLink).toBeVisible();

    // Les fonctions réservées à l'Hôte ne doivent pas être proposées.
    await expect(this.createListingLink).toBeHidden();
    await expect(this.reservationsLink).toBeHidden();
  }

  /**
   * Vérifie le tableau de bord Hôte.
   */
  async expectHostDashboard() {
    await this.expectLoaded();

    await expect(this.dashboardLink).toBeVisible();
    await expect(this.profileLink).toBeVisible();
    await expect(this.listingsLink).toBeVisible();
    await expect(this.createListingLink).toBeVisible();
    await expect(this.reservationsLink).toBeVisible();
    await expect(this.walletLink).toBeVisible();
    await expect(this.favoritesLink).toBeVisible();
    await expect(this.invoicesLink).toBeVisible();
    await expect(this.messagesLink).toBeVisible();
    await expect(this.logoutLink).toBeVisible();

    // La rubrique Voyageur ne doit pas être proposée à l'Hôte.
    await expect(this.tripsLink).toBeHidden();
  }

  /**
   * Ouvre directement le tableau de bord.
   */
  async goto() {
    await this.page.goto('/index.php/dashboard/');
    await this.expectLoaded();
  }

  /**
   * Ouvre les voyages du Voyageur.
   */
  async openTrips() {
    await expect(this.tripsLink).toBeVisible();
    await this.tripsLink.click();
  }

  /**
   * Ouvre les messages.
   */
  async openMessages() {
    await expect(this.messagesLink).toBeVisible();
    await this.messagesLink.click();
  }

  /**
   * Ouvre les annonces de l'Hôte.
   */
  async openListings() {
    await expect(this.listingsLink).toBeVisible();
    await this.listingsLink.click();
  }

  /**
   * Ouvre la création d'une annonce.
   */
  async openCreateListing() {
    await expect(
      this.createListingLink
    ).toBeVisible();

    await this.createListingLink.click();
  }

  /**
   * Ouvre les réservations de l'Hôte.
   */
  async openReservations() {
    await expect(
      this.reservationsLink
    ).toBeVisible();

    await this.reservationsLink.click();
  }

  /**
   * Déconnecte l'utilisateur.
   */
  async logout() {
    await expect(this.logoutLink).toBeVisible();

    await Promise.all([
      this.page.waitForURL(
        url => !url.pathname.includes('/dashboard/'),
        {
          waitUntil: 'domcontentloaded',
        }
      ),
      this.logoutLink.click(),
    ]);

    await expect(
      this.page.getByRole('link', {
        name: /^se connecter$/i,
      })
    ).toBeVisible();
  }
}

module.exports = {
  DashboardPage,
};