import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["choice"];
  static values = {
    url: String,
  };

  connect() { }

  addChoice(e) {
    let choice_count = this.choiceTargets.length
    let url_params = new URLSearchParams({ 'choice_count': choice_count })

    fetch(`${this.urlValue}?${url_params}`, {
      method: "GET",
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
    .then((response) => {
      if (response.ok) {
        return response.text();
      } else {
        throw new Error("Response failed");
      }
    })
    .then((html) => {
      Turbo.renderStreamMessage(html);
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
  }
}
