import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pagy"
export default class extends Controller {
  connect() {
    Pagy.init(this.element)
  }
}
