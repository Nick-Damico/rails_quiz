import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["choiceForm"];
  static values = {
    url: String,
  };

  connect() {
    console.log(this.choiceFormTargets);
  }

  addChoice(e) {
    fetch(this.urlValue, {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
    .then((response) => {
      if (response.ok) {
        return response.text();
      } else {
        throw new Error("Network response was not ok");
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
