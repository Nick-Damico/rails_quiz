import CardController from "controllers/card_controller";
import { removeHiddenClass, addClass } from "helpers/html_helper";
import { capitalize } from "helpers/string_helper";

// Connects to data-controller="user-decks--card"
export default class extends CardController {
  static targets = [
    "correctIcon",
    "incorrectIcon",
    "completeBtnContainer",
    "nextBtnContainer",
    "prevBtnContainer",
    "ratingPrompt",
  ];

  iconTargetMap = {
    correct: "correctIconTarget",
    incorrect: "incorrectIconTarget",
  };

  connect() {
    addEventListener("turbo:submit-end", (e) => this._afterRatingCard(e));
  }

  /* LIFECYCLE CALLBACKS */
  cardTargetConnected(card) {
    if (this._isReviewed(card)) {
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
    const card = this._getCardForTarget(e.target);
    if (!card) return;
    if (this._isReviewed(card)) return;

    this._showRatingPrompt();
    this._addId(card.dataset.id); // Stores card ids that have been flipped.
  }

  /* PRIVATE */
  _afterRatingCard(e) {
    this._hideRatingPrompt();
    this._showButtons();
    this._setReviewedIcon(e);
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
    if (card.dataset.rating === "not_rated") return false;

    return true;
  }

  // Review that this is setup correctly
  // maybe check for error, success
  async _setReviewedIcon(e) {
    const response = e.detail.fetchResponse.response;
    if (!response.ok) return;

    const data = await response.json();
    if (data.rating === undefined) return;

    const icon = this[this.iconTargetMap[data.rating]];
    addClass(icon, "opacity-100");
  }
}
