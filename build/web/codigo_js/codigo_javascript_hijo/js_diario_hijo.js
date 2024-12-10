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

function desplegar() {
const content = document.getElementById('notas-thismonth-Desplegado');
    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
    } else {
        content.style.display = 'none';
    }
}

function desplegar2() {
const content = document.getElementById('notas-antmonth-Desplegado');
    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
    } else {
        content.style.display = 'none';
    }
}
function desplegar3() {
const content = document.getElementById('notas-antSmonth-Desplegado');
    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
    } else {
        content.style.display = 'none';
    }
}  

// Escuchar clicks en las notas
document.addEventListener('click', function (event) {
    const nota = event.target.closest('.contenedor-cada-nota'); // Detecta si el clic fue en una nota

    if (nota) {
        // Obtener los datos de la nota seleccionada
        const titulo = nota.dataset.titulo;
        const info = nota.dataset.info;
        const fecha = nota.dataset.fecha;
        const sentimiento = nota.dataset.sentimiento;

        // Actualizar el contenido del modal
        document.getElementById('modal-titulo').textContent = titulo;
        document.getElementById('modal-fecha').textContent = fecha;
        document.getElementById('modal-info').textContent = info;
        document.getElementById('modal-img-sentimiento').src = `../img/estado_animo_img/${sentimiento}.svg`;

        // Mostrar el modal
        document.getElementById('modal-Notas').style.display = 'flex';
    }
});


//Ciera modal fuera del modal
document.getElementById('modal-Notas').addEventListener('click', function(event) {
    // Si el clic es en el fondo (fuera de la zona del contenido), cerrar el modal
    if (event.target === this) {
        cerrarModal();
    }
});


function cerrarModal() {
    document.getElementById('modal-Notas').style.display = 'none';
}