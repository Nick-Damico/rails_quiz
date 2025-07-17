import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="users--avatar-uploader"
export default class extends Controller {
  static targets = ["dropzone", "fileInput", "icon", "preview"];

  connect() {
    console.log("Avatar Uploader Controller connected");
    this.reader = new FileReader();
    this.errors = new Object();

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
    event.preventDefault();

    if (this._validateDrop(event)) {
      if (event.dataTransfer.items) {
        [...event.dataTransfer.items].forEach((item) => {
          if (item.kind === "file") {
            this._getReader().readAsDataURL(item.getAsFile());
          }
        });
      }
    } else {
      this._showErrors();
      this._clearErrors();
    }
    this._toggleDropzoneStyles("leave");
  }

  _getErrors() {
    return this.errors;
  }

  _getReader() {
    return this.reader;
  }

  _loadFile(event, reader) {
    this.previewTarget.src = reader.result;
    this.previewTarget.classList.remove("hidden");
  }

  _toggleDropzoneStyles(action) {
    if (action === "enter") {
      this.element.classList.add("is-active");
    } else if (action === "leave") {
      this.element.classList.remove("is-active");
    }
  }

  _validateDrop(event) {
    event.dataTransfer.files.length > 1 &&
      (this._getErrors().count =
        "You can only upload one file at a time for your avatar.");

    Array(...event.dataTransfer.files).forEach((file) => {
      if(!(/image\/*/.test(file.type))) {
        this._getErrors().type = "You can only upload an image file."
      }
    })

    return !this._hasErrors();
  }

  _clearErrors() {
    this.errors = {};
  }

  _hasErrors() {
    return Object.keys(this._getErrors()).length > 0;
  }

  _showErrors(errors) {
    for (let error of Object.values(this._getErrors())) {
      alert(error);
    }
  }
}
