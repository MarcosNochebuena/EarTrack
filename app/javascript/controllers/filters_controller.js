import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Search Controller Connected");
  }

  submitForm() {
    clearTimeout(this.timeout);
  
    this.timeout = setTimeout(() => {
      // Enviar el formulario utilizando Turbo
      this.formTarget.requestSubmit();
    }, 300);
  }
  
}