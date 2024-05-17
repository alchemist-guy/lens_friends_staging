import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-nav"
export default class extends Controller {
  static targets = ['nav', 'togglebtn'];

  toggle() {
    this.navTarget.classList.toggle('hidden');

    if (this.navTarget.classList.contains('hidden')) {
      this.togglebtnTarget.textContent = "☰";
    } else {
      this.togglebtnTarget.textContent = "X";
    }
  }
}
