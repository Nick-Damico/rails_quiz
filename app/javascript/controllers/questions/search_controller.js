import { Controller } from "@hotwired/stimulus";
import { addClass, removeClass } from "helpers/html_helper";

// Connects to data-controller="questions--search"
export default class extends Controller {
  static targets = ["input", "question"];

  connect() {
    this._addEventListeners();
  }

  onInput(e) {
    if (!this.hasQuestionTarget) return;

    const searchValue = e.target.value.toLowerCase().trim();

    for (let question of this.questionTargets) {
      let questionText = question.textContent.toLowerCase().trim();
      let classList = [...question.classList];

      if (questionText.includes(searchValue) && classList.includes("hidden")) { 
          removeClass(question, "hidden");
        }

      if (!questionText.includes(searchValue)) {
        addClass(question, "hidden");
      }
    }
  }
  }
}