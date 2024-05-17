import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-gallery"
export default class extends Controller {
  static targets = ["image","showImages","video","showVideos"];
  connect() {
  }

  openImage() {
    this.imageTarget.click();
  }

  openVideo() {
    this.videoTarget.click();
  }

  previewImages() {
    const showImagesTarget = this.showImagesTarget;
    showImagesTarget.innerHTML = '';

    Array.from(this.imageTarget.files).forEach((file) => {
        const reader = new FileReader();

        reader.onload = (event) => {
            const img = document.createElement('img');
            img.src = event.target.result;
            img.classList.add('h-56', 'object-cover'); // Adjusted styling

            showImagesTarget.appendChild(img);
        };

        reader.readAsDataURL(file);
    });
  }

  previewVideos() {
    var showVideosTarget = this.showVideosTarget;
    showVideosTarget.innerHTML = '';

    Array.from(this.videoTarget.files).forEach((file) => {
        const video = document.createElement('video');
        video.src = URL.createObjectURL(file);
        video.classList.add('h-56', 'object-cover'); // Adjusted styling
        video.controls = true; // Add controls to the video element

        showVideosTarget.appendChild(video);
    });
  }

}
