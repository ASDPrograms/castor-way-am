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
// Obtener las referencias de los elementos
const cardContainer = document.getElementById('card-container');
const flechaIzquierda = document.getElementById('flecha-izquierda');
const flechaDerecha = document.getElementById('flecha-derecha');
// Cantidad de píxeles que deseas desplazar (ajusta según sea necesario)
const desplazamiento = 200;

// Función para desplazar hacia la derecha
flechaDerecha.addEventListener('click', () => {
    console.log("Flecha derecha clickeada");
    cardContainer.scrollLeft += desplazamiento; // Desplaza hacia la derecha
});

// Función para desplazar hacia la izquierda
flechaIzquierda.addEventListener('click', () => {
    console.log("Flecha izquierda clickeada");
    cardContainer.scrollLeft -= desplazamiento; // Desplaza hacia la izquierda
});
//copiar codigo presa

function copiarCodigo(event) {
    const codigoPresa = document.getElementById('codigoPresa').innerText; // Obtener el texto del código presa
    navigator.clipboard.writeText(codigoPresa) // Copiar al portapapeles
        .then(() => {
            alert('Código copiado: ' + codigoPresa); // Mensaje de éxito (opcional)
        })
        .catch(err => {
            console.error('Error al copiar: ', err); // Manejo de errores
        });

    // Cambiar el cursor mientras se copia
    const originalCursor = event.target.style.cursor; // Guardar el cursor original
    event.target.style.cursor = 'wait'; // Cambiar a cursor de espera

    // Restaurar el cursor original después de un breve tiempo
    setTimeout(() => {
        event.target.style.cursor = originalCursor; // Restaurar cursor original
    }, 1000); // Cambia el tiempo según sea necesario
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
