import SearchFilter from "controllers/search_filter";
import { addClass, removeClass } from "helpers/html_helper";

// Connects to data-controller="questions--search"
export default class extends SearchFilter {
  onInput(e) {
    this.debouncedFilter(e.target.value)
  }
}