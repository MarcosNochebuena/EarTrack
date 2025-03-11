import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="keys"
export default class extends Controller {
  static targets = ["deleteButton"];
  static values = {
    keyId: Number,
  };

  connect() {
    console.log("Keys Controller connected");
  }

  delete(event) {
    event.preventDefault();
    this.checkAndConfirmDelete(this.keyIdValue);
  }

  checkAndConfirmDelete(keyId) {
    // Primero verificamos si la clave tiene aretes asociados
    fetch(`/keys/${keyId}/check_associations`, {
      headers: {
        Accept: "application/json",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.has_associations) {
          // Si tiene aretes asociados, mostramos una advertencia más clara
          Swal.fire({
            title: "¡Atención!",
            html: `Esta clave tiene <strong>${data.count} aretes</strong> asociados.<br><br><strong>¡IMPORTANTE!</strong> Al eliminar esta clave, también se eliminarán todos los aretes asociados a ella de forma permanente.`,
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Sí, eliminar todo",
            cancelButtonText: "Cancelar",
          }).then((result) => {
            if (result.isConfirmed) {
              this.performDelete(keyId);
            }
          });
        } else {
          // Si no tiene aretes asociados, pedimos confirmación para eliminar
          Swal.fire({
            title: "¿Estás seguro?",
            text: "Esta acción eliminará la clave permanentemente.",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar",
          }).then((result) => {
            if (result.isConfirmed) {
              this.performDelete(keyId);
            }
          });
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        Swal.fire({
          title: "Error",
          text: "No se pudo verificar las asociaciones de la clave.",
          icon: "error",
        });
      });
  }

  performDelete(keyId) {
    // Si el usuario confirma, enviamos la solicitud DELETE
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");

    fetch(`/keys/${keyId}`, {
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
          throw new Error("Error al eliminar la clave");
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
