import CardController from "controllers/card_controller";
import { removeHiddenClass } from "helpers/html_helper";

// Connects to data-controller="user-decks--card"
export default class extends CardController {
  static targets = ["prevBtnContainer", "nextBtnContainer"];

  flip(e) {
    /*
      The parent flip method is called when the user clicks on the card.
      It sets the cards flipped state to true, then toggles button(s) visibility.
     */
    super.flip(e);
    if (!this.cardFlippedValue) return;

    if (this.hasPrevBtnContainerTarget) {
      removeHiddenClass(this.prevBtnContainerTarget);
    }

    if (this.hasNextBtnContainerTarget) {
      removeHiddenClass(this.nextBtnContainerTarget);
    }
  }
}
