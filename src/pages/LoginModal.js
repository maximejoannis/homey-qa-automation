const { expect } = require('@playwright/test');

class LoginModal {
  constructor(page) {
    this.page = page;
    this.modal = page.locator('#modal-login');

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

    this.unknownUsernameFeedback = this.modal.getByText(
      /^\s*Invalid username or email\s*$/i
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

  /**
   * Cas :
   * Identifiant inexistant
   */
  async expectUnknownUsernameRejected() {
    await expect(this.modal).toBeVisible();

    await expect(
      this.unknownUsernameFeedback,
      'Le message "Invalid username or email" doit être affiché.'
    ).toBeVisible({
      timeout: 10000,
    });

    await expect(this.page).not.toHaveURL(/\/dashboard\/?/i);
  }

  /**
   * Cas :
   * Mot de passe erroné
   */
  async expectWrongPasswordRejected(username) {
    await expect(this.modal).toBeVisible();

    const escapedUsername = username.replace(
      /[.*+?^${}()|[\]\\]/g,
      '\\$&'
    );

    const feedback = this.modal.getByText(
      new RegExp(
        `^\\s*The password you entered for the username ${escapedUsername} is incorrect\\.\\s*$`,
        'i'
      )
    );

    await expect(
      feedback,
      'Le message "The password you entered..." doit être affiché.'
    ).toBeVisible({
      timeout: 10000,
    });

    await expect(this.page).not.toHaveURL(/\/dashboard\/?/i);
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
