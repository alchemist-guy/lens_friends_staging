import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-opener"
export default class extends Controller {
  static targets = ["open", "modal", "close"];
  connect() {
    document.addEventListener('click', this.handleClickOutside.bind(this));
  }

  openModal(){
    if (this.hasOpenTarget) {
      this.openTarget.classList.toggle('hidden');
    }
  }

  closeModal(){
    if (this.hasCloseTarget) {
      this.closeTarget.classList.add('hidden');
    }
  }

  handleClickOutside(event) {
    if (this.hasOpenTarget && this.hasModalTarget) {
      var isOutsideMenu = !this.modalTarget.contains(event.target);

      // Hide the menu if the click is outside both the menu and profile image
      if (isOutsideMenu) {
        this.openTarget.classList.add('hidden');
      }
    }
  }

}
