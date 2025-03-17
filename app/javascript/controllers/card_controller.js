import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="decks--card"
export default class extends Controller {
  static targets = ["card", "front", "back"];

  static values = {
    ids: Array,
    flipped: Boolean,
  };

  /* LIFECYCLE CALLBACKS */
  cardTargetDisconnected() {
    this.flippedValue = false;
  }

  /* ACTIONS */
  flip(e) {
    let card = this._getCardForTarget(e.target);
    if (!card) return;

    let cardFront = this.frontTargets.find((front) => card.contains(front));
    let cardBack = this.backTargets.find((back) => card.contains(back));
    if (!(cardFront || cardBack)) return;

    // returns true if the class was added, false if it was removed
    if (cardFront.classList.toggle("hidden")) {
      cardFront.classList.remove("flex");

      cardBack.classList.add("flex");
      cardBack.classList.remove("hidden");
    } else {
      cardFront.classList.add("flex");

      cardBack.classList.remove("flex");
      cardBack.classList.add("hidden");
    }

    if (this.flippedValue) return;

    this.flippedValue = true;
    this._addId(card.dataset.id);
  }

  /* PRIVATE */
  _getCardForTarget(target) {
    return this.cardTargets.find((card) => card.contains(target));
  }

  _addId(id) {
    if (this.idsValue.includes(id)) return;

    this.idsValue = [...this.idsValue, id];
  }
}
