import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  scrollDown() {
    // Get the target section element
    const targetSection = document.getElementById('targetSection');
    
    // Scroll the page down to the target section smoothly
    targetSection.scrollIntoView({ behavior: 'smooth' });
  }
}
