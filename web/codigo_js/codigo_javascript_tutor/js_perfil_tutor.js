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
//para cards

const cardContainer = document.getElementById('card-container');
const flechaIzquierda = document.getElementById('flecha-izquierda');
const flechaDerecha = document.getElementById('flecha-derecha');
const desplazamiento = 200;

flechaDerecha.addEventListener('click', () => {
    console.log("Flecha derecha clickeada");
    cardContainer.scrollLeft += desplazamiento;
});

flechaIzquierda.addEventListener('click', () => {
    console.log("Flecha izquierda clickeada");
    cardContainer.scrollLeft -= desplazamiento; 
});
const flechaIzquierdaInsignia = document.getElementById('flecha-izquierda-insignia');
const flechaDerechaInsignia = document.getElementById('flecha-derecha-insignia');
const cardInsignias = document.getElementById('card-container-insignia');

flechaDerechaInsignia.addEventListener('click', () => {
    console.log("Flecha derecha clickeada");
    cardInsignias.scrollLeft += desplazamiento;
});

flechaIzquierdaInsignia.addEventListener('click', () => {
    console.log("Flecha izquierda clickeada");
    cardInsignias.scrollLeft -= desplazamiento; 
});


//copiar codigo presa
function copiarCodigo(event) {
    // Obtiene el texto del elemento que quieres copiar
    const codigoPresa = document.getElementById('codigoPresa').innerText;

    // Copia el texto al portapapeles
    navigator.clipboard.writeText(codigoPresa)
        .then(() => {
            // Si la copia es exitosa, muestra un alert
            alert('Texto copiado: ' + codigoPresa);
        })
        .catch(err => {
            console.error('Error al copiar: ', err);
        });
}

document.getElementById('editarBoton').addEventListener('click', function() {
    document.getElementById('modalPremio').style.display = 'flex';
});

function cerrarModal() {
    document.getElementById('modalPremio').style.display = 'none';
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

function toggleVisibility() {
    const infoAdicional = document.getElementById("infoAdicional");
    if (infoAdicional.style.display === "none" || infoAdicional.style.display === "") {
        infoAdicional.style.display = "grid"; // Mostrar el elemento como grilla
    } else {
        infoAdicional.style.display = "none"; // Ocultar el elemento
    }
}
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('info_actualizada').addEventListener('submit', function (event) {
        event.preventDefault(); // Previene el envío desde el inicio

        let valid = true;

        // Oculta todos los mensajes de error al inicio de cada envío
        document.getElementById('nombreError').style.display = 'none';
        document.getElementById('edadError').style.display = 'none';
        document.getElementById('correoError').style.display = 'none';
        document.getElementById('contrasenaError').style.display = 'none';

        const nombre = document.getElementById('nombre-acutalizado').value.trim();
        if (nombre.length < 2) {
            document.getElementById('nombreError').textContent = 'Nombre inválido, muy pocos caracteres.';
            document.getElementById('nombreError').style.display = 'block';
            valid = false;
        }

        const edad = parseInt(document.getElementById('edad-actualizado').value);
        if (isNaN(edad) || edad <= 0 || edad > 120) {
            document.getElementById('edadError').textContent = 'Edad inválida.';
            document.getElementById('edadError').style.display = 'block';
            valid = false;
        }

        const correo = document.getElementById('email-actualizado').value.trim();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(correo)) {
            document.getElementById('correoError').textContent = 'Correo electrónico inválido.';
            document.getElementById('correoError').style.display = 'block';
            valid = false;
        }

        const contrasena = document.getElementById('contrasena-actualizada').value;
        if (contrasena.length < 6) {
            document.getElementById('contrasenaError').textContent = 'La contraseña debe tener al menos 6 caracteres.';
            document.getElementById('contrasenaError').style.display = 'block';
            valid = false;
        }

        // Solo procesa el envío si `valid` es true
        if (valid) {
            // Aquí puedes enviar el formulario manualmente si necesitas, por ejemplo:
             document.getElementById('info_actualizada').submit();
        }
    });
});