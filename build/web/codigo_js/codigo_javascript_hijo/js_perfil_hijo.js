/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



const toggleButton = document.querySelector('.toggle');
const sidebar = document.querySelector('.sidebar');
const logo = document.getElementById('iconoNavLogo');

// Agregar evento de clic al botón de toggle
toggleButton.addEventListener('click', () => {
    sidebar.classList.toggle('collapsed');
    if (sidebar.classList.contains('collapsed')) {
        logo.src = '../img/icono_azul_logo.svg'; // Logo cuando está contraído
    } else {
        logo.src = '../img/logo_letras_castorway.svg'; // Logo original
    }

});

function toggleVisibility() {
    const infoAdicional = document.getElementById("infoAdicional");
    if (infoAdicional.style.display === "none" || infoAdicional.style.display === "") {
        infoAdicional.style.display = "grid"; // Mostrar el elemento como grilla
    } else {
        infoAdicional.style.display = "none"; // Ocultar el elemento
    }
}
document.getElementById('editarBoton').addEventListener('click', function() {
    document.getElementById('modalPremio').style.display = 'flex';
});

function cerrarModal() {
    document.getElementById('modalPremio').style.display= 'none';  
}
window.onload = function () {
    // Obtener el contenedor de los hijos
    var contenedorHijos = document.getElementById("contenedor-hijos");

    // Contar el número de hijos dentro del contenedor
    var hijos = contenedorHijos.children.length;

    // Si hay 2 hijos o más, mostrar la barra de desplazamiento vertical
    if (hijos >= 2) {
        contenedorHijos.style.overflowY = 'scroll';  // Activa el scroll vertical
    }
};