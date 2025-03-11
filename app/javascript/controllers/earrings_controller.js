import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="earrings"
export default class extends Controller {
  static values = {
    earringId: Number,
  };

  connect() {
    console.log("Earrings Controller connected");
  }

  delete(event) {
    event.preventDefault();
    this.confirmDelete(this.earringIdValue);
  }

  confirmDelete(earringId) {
    Swal.fire({
      title: "¿Estás seguro?",
      text: "Esta acción eliminará el arete permanentemente.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Sí, eliminar",
      cancelButtonText: "Cancelar",
    }).then((result) => {
      if (result.isConfirmed) {
        this.performDelete(earringId);
      }
    });
  }

  performDelete(earringId) {
    // Si el usuario confirma, enviamos la solicitud DELETE
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");

    fetch(`/earrings/${earringId}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
        Accept: "text/vnd.turbo-stream.html",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Error al eliminar el arete");
        }
        return response.text();
      })
      .then((html) => {
        // Procesamos la respuesta Turbo Stream
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const turboStreamElements = doc.querySelectorAll("turbo-stream");

        turboStreamElements.forEach((element) => {
          Turbo.renderStreamMessage(element.outerHTML);
        });
      })
      .catch((error) => {
        console.error("Error:", error);
        Swal.fire({
          title: "Error",
          text: error.message,
          icon: "error",
        });
      });
  }
}
