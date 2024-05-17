import { Controller } from "@hotwired/stimulus"

  // Connects to data-controller="profile-form"
  export default class extends Controller {
    static targets = ["input", "preview","defaultImage"];

    connect() {
      console.log("Hello, Stimulus!", this.element);
    }

    preview() {
      let input = this.inputTarget;
      let preview = this.previewTarget;
      let file = input.files[0];
      let reader = new FileReader();

      reader.onloadend = function () {
        preview.src = reader.result;
      };

      if (file) {
        reader.readAsDataURL(file);
        this.defaultImageTarget.classList.add('hidden');
        this.previewTarget.classList.remove('hidden');

      } else {
        preview.src = "";
      }
    }

  }
    