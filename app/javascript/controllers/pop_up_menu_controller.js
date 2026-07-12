import { Controller } from "@hotwired/stimulus";
import { addClass, isHidden, toggleHidden } from "helpers/html_helper";

// Connects to data-controller="pop-up-menu"
export default class extends Controller {
  static targets = ["menu"];

  connect() {}

  /* ACTIONS */
  displayMenu(e) {
    if (!isHidden(this.menuTarget)) this._removeEventListener(); 

    // State Change
    toggleHidden(this.menuTarget);

    // Check if menu is visible after state change
    if (!isHidden(this.menuTarget)) {
      this.eventClick = this._handleOutsideClick;
      document.addEventListener("click", this.eventClick.bind(this));
    }
  }

  /* PRIVATE */
  _handleOutsideClick(e) {
    if (!this.menuTarget.contains(e.target) && !isHidden(this.menuTarget)) {
      addClass(this.menuTarget, "hidden");
      this._removeEventListener()
    }
  }

  _removeEventListener() {
    document.removeEventListener("click", this.eventClick);
  }
}
