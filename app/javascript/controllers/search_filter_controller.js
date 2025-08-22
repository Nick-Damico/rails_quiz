import { Controller } from "@hotwired/stimulus";
import { addClass, removeClass, isHidden } from "helpers/html_helper";
import { normalize } from "helpers/string_helper";
import debounce from "helpers/debounce";

export default class extends Controller {
  static targets = ["item", "itemContainer", "emptyMessage"];

  connect() {
    this.debouncedFilter = debounce((text) => {
      this.filter(text);
    });
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

      if (this._containerIsEmpty()) {
        this._displayEmptyMessage();
      } else {
        this._hideEmptyMessage();
      }
    }
  }

  _containerIsEmpty() {
    return this.items().every((item) => isHidden(item));
  }

  _displayEmptyMessage() {
    removeClass(this.emptyMessageTarget, 'hidden')
  }

  _hideEmptyMessage() {
    addClass(this.emptyMessageTarget, 'hidden')
  }

  items() {
    return this.itemTargets;
  }
}
