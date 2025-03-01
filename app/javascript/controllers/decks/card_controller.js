import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="decks--card"
export default class extends Controller {
  static targets = ["card", "front", "back", "menu"];

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
  }

  displayMenu(e) {
    if (!this.hasCardTarget || !this.hasMenuTarget) return;

    let card = this._getCardForTarget(e.target);
    if (!card) return;

    let menu = this._getCardMenu(card);
    if (!menu) return;

    menu.classList.toggle("hidden");
  }

  dismissMenu(e) {
    let card = this._getCardForTarget(e.target);
    let menu = this._getCardMenu(card);
    if (!menu) return;
    if (menu.classList.contains("hidden")) return;

    menu.classList.add("hidden");
  }

  _getCardMenu(card) {
    return this.menuTargets.find((menu) => card.contains(menu));
  }

  _getCardForTarget(target) {
    return this.cardTargets.find((card) => card.contains(target));
  }
}
