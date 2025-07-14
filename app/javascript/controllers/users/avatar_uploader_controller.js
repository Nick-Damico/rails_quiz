import { Controller } from "@hotwired/stimulus";

const displayStyles = {
  dropZone: {
    active: ["border-emerald-500"],
    inactive: ["border-gray-300"],
  },
  icon: {
    active: ["stroke-emerald-500"],
    inactive: ["stroke-gray-500"],
  },
  preview: {
    active: ["hidden"],
  }
};

// Connects to data-controller="users--avatar-uploader"
export default class extends Controller {
  static targets = ["dropzone", "fileInput", "icon", "preview"];

  connect() {
    console.log("Avatar Uploader Controller connected");
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
          const file = item.getAsFile();
          const reader = new FileReader()

          reader.addEventListener("load", () => {
            this.previewTarget.src = reader.result;
            this.previewTarget.classList.remove(...displayStyles.preview.active);
          })

          reader.readAsDataURL(file);
        }
      });
    }
  }

  _toggleDropzoneStyles(action) {
    if (action === "enter") {
      this.dropzoneTarget.classList.add(...displayStyles.dropZone.active);
      this.dropzoneTarget.classList.remove(...displayStyles.dropZone.inactive);

      this.iconTarget.classList.add(...displayStyles.icon.active);
      this.iconTarget.classList.remove(...displayStyles.icon.inactive);
    } else if (action === "leave") {
      this.dropzoneTarget.classList.remove(...displayStyles.dropZone.active);
      this.dropzoneTarget.classList.add(...displayStyles.dropZone.inactive);

      this.iconTarget.classList.remove(...displayStyles.icon.active);
      this.iconTarget.classList.add(...displayStyles.icon.inactive);
    }
  }
}
