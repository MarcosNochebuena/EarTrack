import "@hotwired/turbo-rails";  // Correcto: al nivel superior
import "controllers";  // Asegúrate de que esté configurado correctamente
import "@popperjs/core";
import "bootstrap";  // Esto está bien, asegúrate de que se carga correctamente
import Swal from 'sweetalert2';  // SweetAlert2 correctamente importado
window.Swal = Swal;

// Tu código personalizado aquí
window.addEventListener('turbo:load', event => {
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }
});
