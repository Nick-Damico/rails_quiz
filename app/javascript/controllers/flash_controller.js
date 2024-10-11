import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.removeOnTimeout(2500)
  }

  onClick(e) {
    this.removeOnTimeout()
  }

  removeOnTimeout(delay = 0) {
    setTimeout(() => { this.element.classList.add('animate-fadeOut') }, delay);

    this.element.addEventListener('transitionend', () => { this.element.remove() });
  }
}
