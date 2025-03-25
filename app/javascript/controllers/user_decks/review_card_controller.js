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
    addEventListener("turbo:submit-end", () => this._afterRatingCard());
  }

  /* LIFECYCLE CALLBACKS */
  cardTargetConnected(card) {
    if (this._isReviewed()) {
      this._showButtons();
    }
  }

  /* ACTIONS */
  flip(e) {
    /*
      The parent flip method is called when the user clicks on the card.
      It sets the cards flipped state to true, then toggles button(s) visibility.
     */
    super.flip(e);
    const card = this._getCardForTarget(e.target)
    if (!card) return;
    if (this._isReviewed(card)) return;

    this._showRatingPrompt();
    this._addId(card.dataset.id); // Stores card ids that have been reviewed.
  }

  /* PRIVATE */
  _afterRatingCard() {
   this._hideRatingPrompt();
   this._showButtons();
  }

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

  _isReviewed(card) {
    return this.idsValue.includes(card.dataset.id)
  }
}
