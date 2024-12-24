import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["choice"];
  static values = { url: String };

  connect() {}

  addChoice(e) {
    let choice_count = this.choiceTargets.length;
    let url_params = new URLSearchParams({ choice_count: choice_count });

    fetch(`${this.urlValue}?${url_params}`, {
      method: "GET",
      headers: { Accept: "text/vnd.turbo-stream.html" },
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

  remove_choice(e) {
    // TODO: Add custom dialog for confirm the deletion.
    //       This should match the prompt that Rails uses.
    let choiceContainer = this.choiceTargets.find((el) =>
      el.contains(e.target)
    );

    if (choiceContainer) {
      choiceContainer.remove();
    } else {
      console.error("choice element could not be removed. Refresh page.");
    }
  }
}
