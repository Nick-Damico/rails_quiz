import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['button', 'linksContainer']

  connect() {
    console.log("Navbar connected!")
  }

  onClick() {
    if (!this.hasLinksContainerTarget) return

    this.linksContainerTarget.classList.toggle('hidden')
  }
}
