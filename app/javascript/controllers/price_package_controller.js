import NestedForm from 'stimulus-rails-nested-form'

export default class extends NestedForm {
  static targets = ["addButton"];

  connect() {
    super.connect()
    this.checkClass();
  }

  checkClass() {
    var wrapperElements = document.querySelectorAll('.price-package-wrapper');
    var numberOfElements = wrapperElements.length;

    console.log(`Number of elements with the class "price-package-wrapper": ${numberOfElements}`);

    if (numberOfElements >= 5) {
      this.addButtonTarget.classList.add('hidden'); // Hide the addButton
    } else {
      this.addButtonTarget.classList.remove('hidden'); // Show the addButton
    }

  }


}
