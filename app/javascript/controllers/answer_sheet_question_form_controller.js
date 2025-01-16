import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="answer-sheet-question-form"
export default class extends Controller {
  static targets = ["submitButton"];
  connect() {
    console.log("AnswerSheetQuestionForm");
    console.log();
  }

  enableSubmit() {
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.removeAttribute("disabled");
    }
  }
}
