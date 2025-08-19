import { Controller } from "@hotwired/stimulus";
import debounce from "helpers/debounce";
import { addClass, removeClass } from "helpers/html_helper";

// Connects to data-controller="questions--search"
export default class extends Controller {
  static targets = ["input", "question"];

  connect() {
    this._addEventListeners();
    this.debouncedFilter = debounce((text) => {
      this.filterOnInput(text);
    }, 600);
  }

  saveInput(){
    console.log('Saving data');
  }

  onInput(e) {
    this.debouncedFilter(e.target.value)
  }

  filterOnInput(text) {
    if (!this.hasQuestionTarget) return;

    const searchValue = text.toLowerCase().trim();

    for (let question of this.questionTargets) {
      let questionText = question.textContent.toLowerCase().trim();
      let classList = [...question.classList];

      if (questionText.includes(searchValue) && classList.includes("hidden")) { 
        removeClass(question, "hidden");
      }

      if (!questionText.includes(searchValue)) {
        addClass(question, "hidden");
      }
    }
  }

  _addEventListeners() {
    // for (let question of this.questionTargets) {
    //   question.addEventListener("transitionend", (event) => {
    //     console.log("Transition ended:", event.propertyName);
    //     if (event.propertyName === "opacity") {
    //       if ([...event.target.classList].includes("opacity-0")) { 
    //         console.log("has opacity-0");
    //         addClass(event.target, "hidden");
    //       } else {
    //         removeClass(event.target, "hidden");
    //       }
    //     }

        // console.log(event.propertyName)
        // question.classList.add("hidden");
      // }, { once: true });
    // }
  }
}