import { Controller } from "@hotwired/stimulus"
import { addClass, removeClass } from "helpers/html_helper";
import { normalize } from "helpers/string_helper";
import debounce from "helpers/debounce";

export default class extends Controller {
  static targets = ["item"];

  connect() {
    this.debouncedFilter = debounce((text) => {
      this.filter(text);
    })
  }

  onInput(evt) {
    this.debouncedFilter(evt.target.value);
  }

  filter(text) {
    if (!this.hasItemTarget) return;

    const searchValue = normalize(text);

    // TODO: Filter only on whole words
    for (let item of this.items()) {
      let itemText = normalize(item.textContent);
      let classList = [...item.classList];

      if (itemText.includes(searchValue) && classList.includes("hidden")) { 
        removeClass(item, "hidden");
      }

      if (!itemText.includes(searchValue)) {
        addClass(item, "hidden");
      }
    }
  }
  items() {
