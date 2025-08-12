import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="questions--search"
export default class extends Controller {
  static targets = ["input", "question"];

  connect() {
    console.log("Questions/Search Controller connected");
  }
}