import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["button", "modal"];

  connect() {
    console.log(this.hasModalTarget)
  }

  showModal() {
    this.modalTarget.showModal()
  }
}
