import { Controller } from "@hotwired/stimulus";
import { addClass } from "helpers/html_helper";

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.removeOnTimeout(2500);
  }

  onClick(e) {
    this.removeOnTimeout();
  }

  removeOnTimeout(delay = 0) {
    this.element.addEventListener("animationend", () => this.element.remove());
    setTimeout(() => {
      addClass(this.element, "animate-fadeOut");
    }, delay);
  }
}
