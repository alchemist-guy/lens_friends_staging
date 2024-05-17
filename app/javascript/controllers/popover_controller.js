import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popover"
export default class extends Controller {

  connect() {
    setTimeout(() => {
      this.hideAfterDelay("notice-popover");
      this.hideAfterDelay("alert-popover");
    }, 0);
  }

  hideAfterDelay(targetId) {
    const target = document.getElementById(targetId);

    if (target) {
      setTimeout(() => {
        target.style.opacity = "0";
        setTimeout(() => {
          target.style.display = "none";
        }, 500);
      }, 5000);
    }
  }
}