import { Controller } from "@hotwired/stimulus";
import {
  isDisabled,
  toggleHidden,
  removeDisabledAttribute,
} from "helpers/html_helper";

// Connects to data-controller="decks--review-settings"
export default class extends Controller {
  static targets = ["spaceRepetitionCheckbox", "nextReviewMsg", "submitBtn"];

  connect() {}

  toggleSpaceRepetition() {
    if (isDisabled(this.submitBtnTarget)) {
      removeDisabledAttribute(this.submitBtnTarget);
    }

    toggleHidden(this.nextReviewMsgTarget);
  }
}
