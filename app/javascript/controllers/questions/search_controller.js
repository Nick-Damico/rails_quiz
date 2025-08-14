import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="questions--search"
export default class extends Controller {
  static targets = ["input", "question"];

  connect() {
    this._addEventListeners();
  }

  onInput(e) {
    console.log("Search input changed:", e.target.value);
    if (!this.hasQuestionTarget) return;

    const searchValue = e.target.value.toLowerCase().trim();

    for (let question of this.questionTargets) {
      let questionText = question.textContent.toLowerCase().trim();
      if (questionText.includes(searchValue)) { 
        question.classList.remove("animate-fadeOut");
        // question.classList.remove("opacity-0");
        continue;
      }

      question.classList.add("animate-fadeOut");
    }
  }
  }
}