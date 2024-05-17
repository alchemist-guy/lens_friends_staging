import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu","profileImage"];

  connect() {
    console.log('hello from Stimulus');

    document.addEventListener('click', this.handleClickOutside.bind(this));
  }

  toggleMenu() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.toggle('hidden');
    }
  }

  handleClickOutside(event) {
    if (this.hasMenuTarget && this.hasProfileImageTarget) {
      var isOutsideMenu = !this.menuTarget.contains(event.target);
      var isOutsideProfileImage = !this.profileImageTarget.contains(event.target);

      // Hide the menu if the click is outside both the menu and profile image
      if (isOutsideMenu && isOutsideProfileImage) {
        this.menuTarget.classList.add('hidden');
      }
    }
  }

}
