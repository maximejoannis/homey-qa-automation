const { expect } = require('@playwright/test');

const ONE_DAY_IN_MS = 24 * 60 * 60 * 1000;

const FRENCH_MONTHS = {
  janvier: 0,
  février: 1,
  fevrier: 1,
  mars: 2,
  avril: 3,
  mai: 4,
  juin: 5,
  juillet: 6,
  août: 7,
  aout: 7,
  septembre: 8,
  octobre: 9,
  novembre: 10,
  décembre: 11,
  decembre: 11,
};

class ListingPage {
  /**
   * @param {import('@playwright/test').Page} page
   */
  constructor(page) {
    this.page = page;

    /*
     * La page contient plusieurs modules de réservation dans le DOM.
     * Le module desktop est celui visible dans les rapports Playwright.
     */
    this.bookingModule = page
      .locator('#homey_remove_on_mobile')
      .filter({
        has: page.getByRole('textbox', {
          name: /^début$/i,
        }),
      })
      .first();

    this.startDate = this.bookingModule.getByRole(
      'textbox',
      {
        name: /^début$/i,
      }
    );

    this.endDate = this.bookingModule.getByRole(
      'textbox',
      {
        name: /^fin$/i,
      }
    );

    this.guestsInput = this.bookingModule.getByRole(
      'textbox',
      {
        name: /^voyageurs$/i,
      }
    );

    /*
     * L'id single-booking-search-calendar existe plusieurs fois.
     * Le calendrier est donc obligatoirement limité au module actif.
     */
    this.bookingCalendar = this.bookingModule.locator(
      '#single-booking-search-calendar'
    );

    this.requestButton =
      this.bookingModule.getByRole('button', {
        name: /^demande de réservation$/i,
      });

    this.applyGuestsButton =
      this.bookingModule.getByRole('button', {
        name: /^appliquer$/i,
      });

    this.successMessage = page
      .getByText(
        /demande.*envoyée|réservation.*envoyée|demande.*soumise|réservation.*confirmée|en attente d'approbation|à l'étude/i
      )
      .first();

    this.unavailableDatesMessage = page
      .getByText(
        /vos dates ne sont pas disponibles|dates.*indisponibles/i
      )
      .first();

    this.guestsValidationMessage = page
      .getByText(
        /veuillez choisir des voyageurs|choisir.*voyageur|nombre de voyageurs|voyageurs.*requis/i
      )
      .first();

    this.authenticationMessage = page
      .getByText(/vous devez vous connecter/i)
      .first();

    this.authenticationDialog = page
      .getByRole('dialog')
      .filter({
        hasText:
          /se connecter|connexion|connectez-vous|bon retour parmi nous/i,
      })
      .first();

    this.authenticationForm = page
      .locator('form:has(input[type="password"])')
      .first();
  }

  get calendarNextButton() {
    return this.bookingCalendar
      .locator(
        [
          'button.next',
          'button.next-month',
          '.next button',
          '.next-month button',
          'button[aria-label*="suivant" i]',
          'button[aria-label*="next" i]',
        ].join(', ')
      )
      .last();
  }

  get adultPlusButton() {
    return this.bookingModule
      .locator(
        [
          '.adult_plus',
          '[class*="adult"][class*="plus"]',
          '[data-action="increase-adults"]',
          '[data-action="increment-adults"]',
          '.guest-people-wrap button:has(.fa-plus)',
        ].join(', ')
      )
      .first();
  }

  async expectLoaded() {
    await expect(this.bookingModule).toBeVisible({
      timeout: 10_000,
    });

    await expect(this.startDate).toBeVisible();
    await expect(this.endDate).toBeVisible();
    await expect(this.guestsInput).toBeVisible();
    await expect(this.requestButton).toBeVisible();

    await expect(this.startDate).toHaveAttribute(
      'readonly',
      ''
    );

    await expect(this.endDate).toHaveAttribute(
      'readonly',
      ''
    );

    await expect(this.guestsInput).toHaveAttribute(
      'readonly',
      ''
    );
  }

  /**
   * Convertit un titre comme "juillet 2026".
   *
   * @param {string} monthLabel
   * @returns {{year: number, monthIndex: number}}
   */
  parseMonthLabel(monthLabel) {
    const normalized = monthLabel
      .trim()
      .toLowerCase()
      .replace(/\s+/g, ' ');

    const match = normalized.match(
      /^([a-zàâäéèêëîïôöùûüç]+)\s+(\d{4})$/i
    );

    if (!match) {
      throw new Error(
        `Titre de mois non reconnu : "${monthLabel}".`
      );
    }

    const monthName = match[1];
    const year = Number(match[2]);
    const monthIndex = FRENCH_MONTHS[monthName];

    if (
      monthIndex === undefined ||
      !Number.isInteger(year)
    ) {
      throw new Error(
        `Titre de mois invalide : "${monthLabel}".`
      );
    }

    return {
      year,
      monthIndex,
    };
  }

  async openBookingCalendar() {
    await expect(this.startDate).toBeVisible();

    await this.startDate.click();

    await expect(this.bookingCalendar).toHaveCount(1);

    await expect(this.bookingCalendar).toBeVisible({
      timeout: 5_000,
    });
  }

  /**
   * Retourne les panneaux mensuels du calendrier.
   */
 async getCalendarMonths() {
  const headings =
    this.bookingCalendar.getByRole(
      'heading',
      { level: 4 }
    );

  const count = await headings.count();
  const months = [];

  for (
    let index = 0;
    index < count;
    index += 1
  ) {
    const heading = headings.nth(index);

    if (!(await heading.isVisible())) {
      continue;
    }

    const month = heading.locator('..');

    /*
     * Le panneau doit contenir une liste ayant
     * au moins un jour numérique.
     */
    const containsDays = await month
      .locator('li')
      .filter({
        hasText: /^\d{1,2}$/,
      })
      .count();

    if (containsDays > 0) {
      months.push(month);
    }
  }

  return months;
}

  /**
   * Retourne les dates futures qui semblent sélectionnables.
   */
  async getVisibleFutureDates() {
  await expect(this.bookingCalendar).toBeVisible();

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const dates = [];
  const months = await this.getCalendarMonths();

  const unavailablePattern =
    /disabled|disable|unavailable|past|reserved|booked|blocked|pending|empty/i;

  for (const month of months) {
    const heading = month
      .getByRole('heading', { level: 4 })
      .first();

    const monthLabel = (
      await heading.innerText()
    ).trim();

    let parsedMonth;

    try {
      parsedMonth =
        this.parseMonthLabel(monthLabel);
    } catch {
      continue;
    }

    /*
     * Les jours sont directement des <li>.
     * Il n'existe pas forcément d'enfant .day-number.
     */
    const cells = month.locator('ul').last().locator('> li');
    const cellCount = await cells.count();

    for (
      let index = 0;
      index < cellCount;
      index += 1
    ) {
      const cell = cells.nth(index);

      const dayText = (
        await cell.textContent()
      )?.trim() || '';

      if (!/^\d{1,2}$/.test(dayText)) {
        continue;
      }

      const className =
        (await cell.getAttribute('class')) || '';

      const ariaDisabled =
        await cell.getAttribute('aria-disabled');

      if (
        ariaDisabled === 'true' ||
        unavailablePattern.test(className)
      ) {
        continue;
      }

      /*
       * Le snapshot montre que les dates disponibles
       * sont les <li> ayant un comportement cliquable.
       */
      const isClickable = await cell.evaluate(
        element => {
          const style =
            window.getComputedStyle(element);

          return (
            style.cursor === 'pointer' ||
            element.onclick !== null ||
            element.classList.contains('available')
          );
        }
      );

      if (!isClickable) {
        continue;
      }

      const date = new Date(
        parsedMonth.year,
        parsedMonth.monthIndex,
        Number(dayText)
      );

      date.setHours(0, 0, 0, 0);

      if (date <= today) {
        continue;
      }

      dates.push({
        date,
        day: Number(dayText),
        monthLabel,
        cell,
      });
    }
  }

  dates.sort(
    (first, second) =>
      first.date.getTime() -
      second.date.getTime()
  );

  return dates;
}

  async resetDateSelection() {
    await this.page.keyboard
      .press('Escape')
      .catch(() => {});

    await this.startDate.click();

    await expect(this.bookingCalendar).toBeVisible({
      timeout: 5_000,
    });
  }

  /**
   * Essaie de sélectionner une cellule et vérifie
   * que la valeur du champ a changé.
   *
   * @param {import('@playwright/test').Locator} cell
   * @param {import('@playwright/test').Locator} input
   * @returns {Promise<boolean>}
   */
  async tryToSelectDate(cell, input) {
  const previousValue =
    await input.inputValue();

  await cell.scrollIntoViewIfNeeded();

  try {
    await cell.click({
      timeout: 2_000,
    });

    await expect
      .poll(
        async () => await input.inputValue(),
        {
          timeout: 2_000,
          message:
            'La date cliquée doit être inscrite dans le champ.',
        }
      )
      .not.toBe(previousValue);

    return true;
  } catch {
    return false;
  }
}

  /**
   * Sélectionne une période disponible.
   *
   * @param {number} minimumStayDays
   */
  async selectAvailablePeriod(minimumStayDays = 2) {
  await this.openBookingCalendar();

  for (let viewIndex = 0; viewIndex < 3; viewIndex += 1) {
    const availableDates =
      await this.getVisibleFutureDates();

    /*
     * Ne tester que les dates réellement candidates.
     * Cela évite des dizaines d'attentes successives.
     */
    const startCandidates =
      availableDates.slice(0, 5);

    for (const startCandidate of startCandidates) {
      const startSelected =
        await this.tryToSelectDate(
          startCandidate.cell,
          this.startDate
        );

      if (!startSelected) {
        continue;
      }

      const datesAfterStart =
        await this.getVisibleFutureDates();

      const minimumEndDate = new Date(
        startCandidate.date
      );

      minimumEndDate.setDate(
        minimumEndDate.getDate() +
          minimumStayDays
      );

      const endCandidate =
        datesAfterStart.find(
          candidate =>
            candidate.date >= minimumEndDate
        );

      if (!endCandidate) {
        await this.resetDateSelection();
        continue;
      }

      const endSelected =
        await this.tryToSelectDate(
          endCandidate.cell,
          this.endDate
        );

      if (endSelected) {
        return {
          startDate: startCandidate.date,
          endDate: endCandidate.date,
          durationInDays: Math.round(
            (
              endCandidate.date.getTime() -
              startCandidate.date.getTime()
            ) /
              (24 * 60 * 60 * 1000)
          ),
          startDay: startCandidate.day,
          endDay: endCandidate.day,
          startMonthLabel:
            startCandidate.monthLabel,
          endMonthLabel:
            endCandidate.monthLabel,
        };
      }

      await this.resetDateSelection();
    }

    if (
      !(await this.calendarNextButton
        .isVisible()
        .catch(() => false))
    ) {
      break;
    }

    const previousMonth =
      await this.bookingCalendar
        .getByRole('heading', { level: 4 })
        .first()
        .innerText();

    await this.calendarNextButton.click();

    await expect
      .poll(
        async () =>
          await this.bookingCalendar
            .getByRole('heading', { level: 4 })
            .first()
            .innerText(),
        {
          timeout: 3_000,
        }
      )
      .not.toBe(previousMonth);
  }

  throw new Error(
    `Aucune période disponible d'au moins ${minimumStayDays} jours trouvée.`
  );
}

  /**
   * Prépare des dates futures directement dans les champs pour tester
   * le contrôle d'authentification, indépendamment du calendrier tiers.
   *
   * Ce scénario reproduit le fallback éprouvé du test Robot Framework :
   * retrait temporaire de readonly, affectation des valeurs et émission
   * des événements attendus par l'application.
   *
   * @param {number} startInDays
   * @param {number} stayInDays
   */
  async setFutureDatesForAuthenticationCheck(
    startInDays = 30,
    stayInDays = 2
  ) {
    if (
      !Number.isInteger(startInDays) ||
      startInDays <= 0 ||
      !Number.isInteger(stayInDays) ||
      stayInDays <= 0
    ) {
      throw new Error(
        'Les décalages de dates doivent être des entiers strictement positifs.'
      );
    }

    await expect(this.startDate).toBeVisible();

    const dates = await this.bookingModule.evaluate(
      (module, parameters) => {
        const startInput = module.querySelector(
          'input[name="arrive"]'
        );
        const endInput = module.querySelector(
          'input[name="depart"]'
        );

        if (!startInput || !endInput) {
          throw new Error(
            'Champs arrive/depart introuvables dans le module de réservation.'
          );
        }

        const toIsoDate = date => {
          const year = date.getFullYear();
          const month = String(
            date.getMonth() + 1
          ).padStart(2, '0');
          const day = String(
            date.getDate()
          ).padStart(2, '0');

          return `${year}-${month}-${day}`;
        };

        const startDate = new Date();
        startDate.setHours(12, 0, 0, 0);
        startDate.setDate(
          startDate.getDate() +
            parameters.startInDays
        );

        const endDate = new Date(startDate);
        endDate.setDate(
          endDate.getDate() +
            parameters.stayInDays
        );

        const startValue = toIsoDate(startDate);
        const endValue = toIsoDate(endDate);

        for (const [input, value] of [
          [startInput, startValue],
          [endInput, endValue],
        ]) {
          input.removeAttribute('readonly');
          input.value = value;

          for (const eventName of [
            'input',
            'change',
            'blur',
          ]) {
            input.dispatchEvent(
              new Event(eventName, {
                bubbles: true,
              })
            );
          }
        }

        return {
          startValue,
          endValue,
        };
      },
      {
        startInDays,
        stayInDays,
      }
    );

    await expect(this.startDate).toHaveValue(
      dates.startValue
    );
    await expect(this.endDate).toHaveValue(
      dates.endValue
    );

    await this.page.keyboard
      .press('Escape')
      .catch(() => {});

    return dates;
  }

  async openGuestsSelector() {
    await expect(this.guestsInput).toBeVisible();

    await this.guestsInput.click();

    await expect(this.adultPlusButton).toBeVisible({
      timeout: 5_000,
    });
  }

  /**
   * @param {number} guests
   */
  async setGuests(guests) {
    if (
      !Number.isInteger(guests) ||
      guests <= 0
    ) {
      throw new Error(
        'Le nombre de voyageurs doit être un entier strictement positif.'
      );
    }

    await this.openGuestsSelector();

    /*
     * Sur Homey, le compteur adulte commence généralement à zéro.
     * On clique le nombre de fois demandé.
     */
    for (
      let index = 0;
      index < guests;
      index += 1
    ) {
      await this.adultPlusButton.click();
    }

    await expect(
      this.applyGuestsButton
    ).toBeVisible();

    await this.applyGuestsButton.click();

    await expect(this.guestsInput).not.toHaveValue(
      ''
    );

    const displayedGuests =
      Number.parseInt(
        await this.guestsInput.inputValue(),
        10
      ) || 0;

    expect(
      displayedGuests
    ).toBeGreaterThanOrEqual(guests);
  }

  async expectNoGuestsSelected() {
    const guestsValue =
      await this.guestsInput.inputValue();

    const guests =
      Number.parseInt(guestsValue, 10) || 0;

    expect(guests).toBe(0);
  }

  async expectZeroGuestsRejected() {
    await this.expectNoGuestsSelected();

    await this.requestButton.click();

    await expect(
      this.guestsValidationMessage
    ).toBeVisible({
      timeout: 5_000,
    });

    await expect(
      this.successMessage
    ).toBeHidden();
  }

  async expectBookingFormReady() {
    await expect(this.startDate).not.toHaveValue(
      ''
    );

    await expect(this.endDate).not.toHaveValue(
      ''
    );

    await expect(this.guestsInput).not.toHaveValue(
      ''
    );

    const unavailableMessageVisible =
      await this.unavailableDatesMessage
        .isVisible()
        .catch(() => false);

    expect(unavailableMessageVisible).toBe(false);

    await expect(this.requestButton).toBeEnabled({
      timeout: 10_000,
    });
  }

  async submitReservation() {
    await this.expectBookingFormReady();

    await this.requestButton.click();
  }

  /**
   * Vérifie uniquement les données nécessaires à la soumission isolée.
   * La disponibilité réelle est volontairement hors périmètre de ces tests.
   */
  async expectReservationDataFilled() {
    await expect(this.startDate).not.toHaveValue('');
    await expect(this.endDate).not.toHaveValue('');
    await expect(this.guestsInput).not.toHaveValue('');
  }

  /**
   * Déclenche le gestionnaire applicatif du bouton même lorsque Homey le
   * désactive après son contrôle de disponibilité. Cette méthode est réservée
   * aux scénarios isolés qui mockent la persistance ou vérifient l'authentification.
   */
  async triggerRequestButtonHandler() {
    await expect(this.requestButton).toBeVisible();

    await this.requestButton.evaluate(button => {
      button.disabled = false;
      button.removeAttribute('disabled');
      button.removeAttribute('aria-disabled');
      button.classList.remove('disabled');

      button.dispatchEvent(
        new MouseEvent('click', {
          bubbles: true,
          cancelable: true,
          view: window,
        })
      );
    });
  }

  /**
   * Soumet le formulaire sans créer de réservation réelle.
   *
   * La requête est reconnue uniquement par ses données métier
   * (arrive et depart), sans dépendre du nom interne de l'action
   * WordPress. Les autres appels vers admin-ajax.php continuent
   * normalement.
   *
   * @returns {Promise<{rawBody: string, parameters: URLSearchParams}>}
   */
  async submitReservationWithoutPersistence() {
    await this.expectReservationDataFilled();

    let capturedBody = null;

    const ajaxPattern = '**/wp-admin/admin-ajax.php*';

    const routeHandler = async route => {
      const request = route.request();

      if (request.method() !== 'POST') {
        await route.continue();
        return;
      }

      const rawBody = request.postData() || '';

      let decodedBody = rawBody;

      try {
        decodedBody = decodeURIComponent(
          rawBody.replace(/\+/g, ' ')
        );
      } catch {
        // Le corps brut reste exploitable si le décodage échoue.
      }

      const containsBookingDates =
        /(?:^|[&\s])arrive(?:\[\])?=/.test(decodedBody) &&
        /(?:^|[&\s])depart(?:\[\])?=/.test(decodedBody);

      if (!containsBookingDates) {
        await route.continue();
        return;
      }

      capturedBody = rawBody;

      await route.fulfill({
        status: 200,
        contentType: 'application/json; charset=utf-8',
        body: JSON.stringify({
          success: true,
          message:
            'Demande de réservation envoyée avec succès.',
          msg:
            'Demande de réservation envoyée avec succès.',
          reservation_id: 'mock-reservation-id',
        }),
      });
    };

    await this.page.route(ajaxPattern, routeHandler);

    try {
      await this.triggerRequestButtonHandler();

      await expect
        .poll(
          () => capturedBody,
          {
            timeout: 10_000,
            message:
              'Le clic doit envoyer une requête POST contenant arrive et depart.',
          }
        )
        .not.toBeNull();
    } finally {
      await this.page.unroute(
        ajaxPattern,
        routeHandler
      );
    }

    return {
      rawBody: capturedBody,
      parameters: new URLSearchParams(capturedBody),
    };
  }

  async expectReservationSent() {
    await expect
      .poll(
        async () => {
          const successVisible =
            await this.successMessage
              .isVisible()
              .catch(() => false);

          const currentUrl = this.page.url();

          return (
            successVisible ||
            /dashboard|reservation|booking/i.test(
              currentUrl
            )
          );
        },
        {
          timeout: 15_000,
          message:
            'La demande de réservation doit être créée.',
        }
      )
      .toBe(true);
  }

  async expectGuestCannotFinalize() {
    await this.expectReservationDataFilled();
    await this.triggerRequestButtonHandler();

    await expect
      .poll(
        async () => {
          const messageVisible =
            await this.authenticationMessage
              .isVisible()
              .catch(() => false);

          const dialogVisible =
            await this.authenticationDialog
              .isVisible()
              .catch(() => false);

          const formVisible =
            await this.authenticationForm
              .isVisible()
              .catch(() => false);

          return (
            messageVisible ||
            dialogVisible ||
            formVisible
          );
        },
        {
          timeout: 10_000,
          message:
            'Le visiteur doit être invité à se connecter.',
        }
      )
      .toBe(true);

    await expect(
      this.successMessage
    ).toBeHidden();
  }

  async expectPastDatesNotSelectable() {
    await this.openBookingCalendar();

    const initialStartValue =
      await this.startDate.inputValue();

    const pastDates = this.bookingCalendar.locator(
      [
        '.days > li.past',
        '.days > li.past-day',
        '.days > li.disabled',
        '.days > li.disable',
        '.days > li[aria-disabled="true"]',
      ].join(', ')
    );

    const pastDateCount = await pastDates.count();

    /*
     * On limite le contrôle à cinq cellules.
     * Il n'est pas nécessaire de cliquer toutes les dates passées.
     */
    const numberOfDatesToCheck = Math.min(
      pastDateCount,
      5
    );

    for (
      let index = 0;
      index < numberOfDatesToCheck;
      index += 1
    ) {
      const pastDate = pastDates.nth(index);

      await pastDate
        .click({
          force: true,
          timeout: 500,
        })
        .catch(() => {});

      await expect(this.startDate).toHaveValue(
        initialStartValue
      );
    }

    return numberOfDatesToCheck;
  }
}

module.exports = {
  ListingPage,
};