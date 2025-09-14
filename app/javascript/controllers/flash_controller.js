import { Controller } from "@hotwired/stimulus";
import { addClass } from "helpers/html_helper";

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    useTimeOut: { type: Boolean, default: true },
    timeOutDelay: { type: Number, default: 3000 },
  };

  connect() {
    if (this.useTimeOutValue) {
      this.removeOnTimeout(this.timeOutDelayValue);
    }
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
