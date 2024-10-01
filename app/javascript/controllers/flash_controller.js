import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {}

  onClick(e) {
    this.element.classList.add('animate-fadeOut')
    setTimeout(() => { this.element.remove() }, 700);
  }
}
