import CardController from "controllers/card_controller";
import { addClass } from "helpers/html_helper";

// Connects to data-controller="decks--card"
export default class extends CardController {
  static targets = ["menu"];

  /* LIFE CYCLE CALLBACKS */
  displayMenu(e) {
    if (!this.hasCardTarget || !this.hasMenuTarget) return;

    let card = this._getCardForTarget(e.target);
    if (!card) return;

    let menu = this._getCardMenu(card);
    if (!menu) return;

    menu.classList.toggle("hidden");
  }

  /* ACTIONS */
  dismissMenu(e) {
    let card = this._getCardForTarget(e.target);
    let menu = this._getCardMenu(card);
    if (!menu) return;
    if (menu.classList.contains("hidden")) return;

    addClass(menu, "hidden");
  }

  /* PRIVATE */
  _getCardMenu(card) {
    return this.menuTargets.find((menu) => card.contains(menu));
  }
}
