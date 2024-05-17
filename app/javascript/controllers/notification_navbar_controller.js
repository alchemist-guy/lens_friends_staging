import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-navbar"
export default class extends Controller {
  static targets = ["open", "notification"];
  connect() {
    document.addEventListener('click', this.handleClickOutside.bind(this));
  }

  openNotification(){
    if (this.hasOpenTarget) {
      this.openTarget.classList.toggle('hidden');
    }
  }

  handleClickOutside(event) {
    if (this.hasOpenTarget && this.hasNotificationTarget) {
      var isOutsideMenu = !this.notificationTarget.contains(event.target);

      // Hide the menu if the click is outside both the menu and profile image
      if (isOutsideMenu) {
        this.openTarget.classList.add('hidden');
      }
    }
  }


}
