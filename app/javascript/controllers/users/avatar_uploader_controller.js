import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="users--avatar-uploader"
export default class extends Controller {
  static targets = ["dropzone", "fileInput", "icon", "preview"];

  connect() {
    console.log("Avatar Uploader Controller connected");
    this.reader = new FileReader();

    this._getReader().addEventListener("load", (event) =>
      this._loadFile(event, this._getReader())
    );
  }

  onBrowse(event) {
    this.fileInputTarget.click();
  }

  onDragOver(event) {
    event.preventDefault();
    this._toggleDropzoneStyles("enter");
  }

  onDragLeave(event) {
    event.preventDefault();
    this._toggleDropzoneStyles("leave");
  }

  onDrop(event) {
    console.log("file dropped");
    event.preventDefault();

    if (event.dataTransfer.items) {
      [...event.dataTransfer.items].forEach((item) => {
        if (item.kind === "file") {
          this._getReader().readAsDataURL(item.getAsFile());
        }
      });
    }
  }

  _getReader() {
    return this.reader;
  }

  _loadFile(event, reader) {
    this.previewTarget.src = reader.result;
    this.previewTarget.classList.remove("hidden");
    this._toggleDropzoneStyles("leave");
  }

  _toggleDropzoneStyles(action) {
    if (action === "enter") {
      this.element.classList.add("is-active");
    } else if (action === "leave") {
      this.element.classList.remove("is-active");
    }
  }
}
