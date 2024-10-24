import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {
  static targets = ["form"]
  connect() {
    console.log("FIlTERS CONTROLLER")
  }
  submitForm() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 300)
  }
}
