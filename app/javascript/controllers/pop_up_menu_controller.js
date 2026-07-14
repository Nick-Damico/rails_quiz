import { Controller } from "@hotwired/stimulus";
import { addClass, isHidden, toggleHidden } from "helpers/html_helper";

// Connects to data-controller="pop-up-menu"
export default class extends Controller {
  static targets = ["menu"];

  /* Lifecycles */
  connect() {
    this.eventClick = this.handleOutsideClick.bind(this);
    document.addEventListener("click", this.eventClick);
  }

  disconnect() {
    document.removeEventListner("click", this.eventClick);
  }

  /* ACTIONS */
  displayMenu(e) {
    toggleHidden(this.menuTarget);
  }

  handleOutsideClick(e) {
    if (this.element.contains(e.target)) return;
    if (isHidden(this.menuTarget)) return;

    addClass(this.menuTarget, "hidden");
  }
}
