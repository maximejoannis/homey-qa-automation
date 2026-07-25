class SearchResultsPage {
  constructor(page) {
    this.page = page;
    this.results = page.locator('.item-wrap, .property-item, .listing-wrap .media');
    this.map = page.locator('#map, .map-wrap, .google-map, .leaflet-container').first();
    this.searchButton = page.getByRole('button', { name: /chercher/i });
    this.emptyState = page.getByText(/aucun résultat|aucune annonce|0 résultat/i).first();
  }

  async openListing(index = 0) {
    const result = this.results.nth(index);
    await result.locator('a').first().click();
    await this.page.waitForLoadState('domcontentloaded');
  }
}

module.exports = { SearchResultsPage };
