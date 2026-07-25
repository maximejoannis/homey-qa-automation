const { expect } = require('@playwright/test');

class LoginModal {
  constructor(page) {
    this.page = page;
    this.modal = page.getByRole('dialog');

    this.username = this.modal.getByRole('textbox', {
      name: /nom d'utilisateur ou email/i,
    });

    this.password = this.modal.locator(
      'input[name="password"][type="password"]'
    );

    this.submit = this.modal.getByRole('button', {
      name: /^se connecter$/i,
    });

    this.rememberMe = this.modal.getByRole('checkbox', {
      name: /souviens-toi de moi/i,
    });

    this.forgotPassword = this.modal.getByRole('link', {
      name: /mot de passe.*oubli/i,
    });

    this.feedback = this.modal.getByText(
  /invalid username or email|identifiant incorrect|connexion impossible|incorrect username or password/i
    );

    this.passwordRequiredFeedback = this.modal.getByText(
      /the password field is empty|le champ mot de passe est vide/i
    );
  }

  async login(username, password) {
    await expect(this.modal).toBeVisible();

    await this.username.fill(username);
    await expect(this.username).toHaveValue(username);

    /*
     * fill() est annulé par le comportement JavaScript du site.
     * La saisie clavier progressive reproduit l'action utilisateur.
     */
    await this.password.click();
    await this.password.pressSequentially(password, {
      delay: 50,
    });

    await expect(
      this.password,
      'Le mot de passe doit rester présent avant la soumission.'
    ).toHaveValue(password);

    await expect(this.submit).toBeEnabled();
    await this.submit.click();
  }

  async expectInvalidCredentials() {
    await expect(this.modal).toBeVisible();

    await expect(
      this.passwordRequiredFeedback,
      'Le site considère le mot de passe comme vide.'
    ).toBeHidden();

    await expect(this.feedback).toBeVisible({
      timeout: 10000,
    });

    await expect(this.page).not.toHaveURL(
      /\/dashboard\/?/i
    );
  }

  async expectRequiredFunctions() {
    await expect(this.username).toBeVisible();
    await expect(this.password).toBeVisible();
    await expect(this.rememberMe).toBeVisible();
    await expect(this.forgotPassword).toBeVisible();
    await expect(this.submit).toBeVisible();
  }
}

module.exports = { LoginModal };
