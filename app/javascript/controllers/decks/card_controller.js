import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="decks--card"
export default class extends Controller {
  static targets = ["card", "front", "back", "menu"];

  connect() {}

  flip(e) {
    let card = this.cardTargets.find((card) => card.contains(e.target));
    if (!card) return;

    let cardFront = this.frontTargets.find((front) => card.contains(front));
    let cardBack = this.backTargets.find((back) => card.contains(back));
    if (!cardFront || !cardBack) return;

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

  displayMenu() {
    if (!this.hasMenuTarget) return;

    this.menuTarget.classList.toggle("hidden")
  }

  dismissMenu() {
    if (!this.hasMenuTarget) return;
    if (this.menuTarget.classList.contains("hidden")) return; 

    this.menuTarget.classList.add("hidden") 
  }
}
