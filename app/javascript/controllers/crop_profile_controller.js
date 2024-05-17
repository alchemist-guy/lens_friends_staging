import { Controller } from "@hotwired/stimulus"
import Cropper from "cropperjs"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    // Do nothing on connect, as Cropper will be initialized when the file input changes
  }

  connectCropper() {
    if (this.hasInputTarget) {
      var inputElement = this.inputTarget
      var imageElement = document.createElement('img')
      var reader = new FileReader()

      reader.onload = function (e) {
        imageElement.src = e.target.result
      }

      reader.readAsDataURL(inputElement.files[0])

      reader.onloadend = () => {
        var cropperContainer = this.previewTarget
        cropperContainer.src = imageElement.src

        // Initialize CropperJS instance
        // this.cropper = new Cropper(cropperContainer, {
        //   autoCropArea: 1,
        //   aspectRatio: 1,
        //   viewMode:0,
        //   dragMode: "move",
        //   responsive: true,
        // });
      }
    }
  }

}