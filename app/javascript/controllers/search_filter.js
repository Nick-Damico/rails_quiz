import { Controller } from "@hotwired/stimulus"
import { addClass, removeClass } from "helpers/html_helper";
import debounce from "helpers/debounce";

export default class extends Controller {
  static targets = ["input", "item"];

  connect() {
    this.debouncedFilter = debounce((text) => {
      this.filterOnInput(text);
    })
  }

  filterOnInput(text) {
    if (!this.hasItemTarget) return;

    const searchValue = this._normalizeText(text);

    for (let item of this.itemTargets) {
      let itemText = this._normalizeText(item.textContent);
      let classList = [...item.classList];

      if (itemText.includes(searchValue) && classList.includes("hidden")) { 
        removeClass(item, "hidden");
      }

      if (!itemText.includes(searchValue)) {
        addClass(item, "hidden");
      }
    }
  }

  _normalizeText(text) {
    return text.toLowerCase().trim();
  }
}