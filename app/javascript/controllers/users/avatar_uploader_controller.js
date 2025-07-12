import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="users--avatar-uploader"
export default class extends Controller {
  static targets = ["dropzone", "fileInput", "preview"];

  connect() {
    console.log("Avatar Uploader Controller connected");
  }

  onBrowse(event) {
    console.log("Browse button clicked");
    this.fileInputTarget.click();
  }

  onDragOver(event) {}
  onDrop(event) {}
}
