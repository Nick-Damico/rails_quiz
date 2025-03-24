import CardController from "controllers/card_controller";
import { removeHiddenClass } from "helpers/html_helper";
import { capitalize } from "helpers/string_helper";
import { addClass } from "../../helpers/html_helper";

// Connects to data-controller="user-decks--card"
export default class extends CardController {
  static targets = [
    "completeBtnContainer",
    "nextBtnContainer",
    "prevBtnContainer",
    "ratingPrompt",
  ];

  connect() {
    addEventListener("turbo:submit-end", () => {
      this._hideRatingPrompt();
    });
  }

  /* LIFECYCLE CALLBACKS */
  cardTargetConnected(card) {
    if (!this.idsValue.includes(card.dataset.id)) return;

    this._showButtons();
  }

  /* ACTIONS */
  flip(e) {
    /*
      The parent flip method is called when the user clicks on the card.
      It sets the cards flipped state to true, then toggles button(s) visibility.
     */
    super.flip(e);
    if (!this.flippedValue) return;

    this._showButtons();
    this._showRatingPrompt();
  }

  /* PRIVATE */
  _showButtons() {
    [
      "prevBtnContainerTarget",
      "nextBtnContainerTarget",
      "completeBtnContainerTarget",
    ].forEach((btnContainer) => {
      if (this[`has${capitalize(btnContainer)}`]) {
        removeHiddenClass(this[`${btnContainer}`]);
      }
    });
  }

  _showRatingPrompt() {
    if (!this.hasRatingPromptTarget) return;

    addClass(this.ratingPromptTarget, "animate-rating-slide-in");
  }

  _hideRatingPrompt() {
    if (!this.hasRatingPromptTarget) return;

    addClass(this.ratingPromptTarget, "animate-rating-slide-out");
  }
}
