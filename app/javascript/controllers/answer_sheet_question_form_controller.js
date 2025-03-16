import { Controller } from "@hotwired/stimulus";
import { removeDisabledAttribute } from "helpers/html_helper";

// Connects to data-controller="answer-sheet-question-form"
export default class extends Controller {
  static targets = ["submitButton"];

  enableSubmit() {
    if (this.hasSubmitButtonTarget) {
      removeDisabledAttribute(this.submitButtonTarget);
    }
  }
}
