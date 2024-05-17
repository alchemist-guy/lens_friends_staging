import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session-type"
export default class extends Controller {
  static targets = ["family", "portrait", "couples", "product", "graduation",
                    "maternity", "newborn", "interior", "fashion", "branding",
                    "wedding", "boudoir"];

  connect() {
    // this.toggleFamily();
  }

  toggleFamily() {
    var checkbox = this.element.querySelector(".hidden-family-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.familyTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  togglePortrait() {
    var checkbox = this.element.querySelector(".hidden-portrait-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.portraitTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleCouple() {
    var checkbox = this.element.querySelector(".hidden-couple-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.couplesTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleProduct() {
    var checkbox = this.element.querySelector(".hidden-product-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.productTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleGraduation() {
    var checkbox = this.element.querySelector(".hidden-graduation-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.graduationTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleMaternity() {
    var checkbox = this.element.querySelector(".hidden-maternity-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.maternityTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleNewborn() {
    var checkbox = this.element.querySelector(".hidden-newborn-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.newbornTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleInterior() {
    var checkbox = this.element.querySelector(".hidden-interior-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.interiorTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleFashion() {
    var checkbox = this.element.querySelector(".hidden-fashion-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.fashionTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleBranding() {
    var checkbox = this.element.querySelector(".hidden-branding-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.brandingTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleWedding() {
    var checkbox = this.element.querySelector(".hidden-wedding-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.weddingTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

  toggleBoudoir() {
    var checkbox = this.element.querySelector(".hidden-boudoir-checkbox");

    // Toggle the value attribute of the hidden input between "true" and "false"
    checkbox.value = (checkbox.value === "true") ? "false" : "true";

    // Toggle the "selected" class for styling based on the updated checkbox value
    this.boudoirTarget.classList.toggle("bg-[#B7BAA7]", checkbox.value === "true");
  }

}