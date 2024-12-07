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

function desplegarBurbujas() {
    var contenedor = document.getElementById("burbujasDesp");
    if (contenedor.style.display === "none" || contenedor.style.display === "") {
        contenedor.style.display = "block";
        contenedor.style.opacity = "0";
        setTimeout(function () {
            contenedor.style.opacity = "1"; // Efecto de desvanecimiento
        }, 10);
    } else {
        contenedor.style.opacity = "0";
        setTimeout(function () {
            contenedor.style.display = "none"; // Ocultar después de la transición
        }, 300);
    }
}


function addNewDiv() {
// Clonamos el primer div "container"
    var container = document.querySelector('.container');
    var clone = container.cloneNode(true);
    // Eliminamos el botón del nuevo div para que no siga añadiendo más divs infinitamente
    var button = clone.querySelector('.button-overlay');
    if (button) {
        button.remove();
    }

// Añadimos el nuevo div clonado al contenedor principal
    var containerWrapper = document.getElementById('container-wrapper');
    containerWrapper.appendChild(clone);
}


function openModal() {
    document.getElementById("noChildModal").style.display = "flex"; // Muestra el modal
}

function closeModal() {
    document.getElementById("noChildModal").style.display = "none"; // Oculta el modal
}


function toggleBurbujas() {
// Selecciona todas las burbujas escondidas
    var burbujasEscondidas = document.querySelectorAll(".burbujas-escondidas");
    // Itera sobre cada burbuja escondida y alterna su visibilidad
    burbujasEscondidas.forEach(function (burbuja) {
        if (burbuja.style.display === "none" || burbuja.style.display === "") {
            burbuja.style.display = "flex"; // Muestra la burbuja escondida como un contenedor flex
        } else {
            burbuja.style.display = "none"; // Esconde la burbuja escondida
        }
    });
    // Selecciona todos los <td> que tienen la clase "td-burbujas-escondidas"
    var burbujasEscondidasTd = document.querySelectorAll("td#td-burbujas-escondidas"); // Ajusta el selector

    burbujasEscondidasTd.forEach(function (burbujaTd) {
        if (burbujaTd.style.display === "none" || burbujaTd.style.display === "") {
            burbujaTd.style.display = "table-cell"; // Muestra el <td> escondido
        } else {
            burbujaTd.style.display = "none"; // Esconde el <td>
        }
    });
}


function cambiarUsuario(idKit) {
    // Mostrar el idKit en la consola
    console.log("idKit actual: " + idKit);

    // Realizar la petición AJAX para obtener la información del usuario
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "procesa_recompensas_tutor.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Aquí puedes actualizar la sección de la página donde se muestran los hábitos
            document.getElementById("recom").innerHTML = xhr.responseText;
        }
    };
    xhr.send("idKit=" + idKit);
}


var modalCrearActividad = document.getElementById("modalCrearActividad");
var btnCrearAct = document.getElementById("crearActBtn");
var btnEditarAct = document.getElementById("editarActividadBtn");
var formulario = document.getElementById("formulario-nuevo-habito");
var cerrarModalBtn = document.getElementById("cerrarModalBtn");
var tituloModal = document.getElementById("p-nuevo-habito-tit");
var btnMandarFormuActi = document.getElementById("mandarFormsNuevaActividad");
var imagen = document.getElementById("selectedIcon");


if (btnCrearAct !== null) {
    btnCrearAct.onclick = function () {
        formulario.action = "formulario_procesa_recompensas_tutor.jsp";
        btnMandarFormuActi.textContent = "Crear";
        tituloModal.textContent = "Nuevo hábito";
        formulario.reset();
        modalCrearActividad.style.display = "block";
        modalCrearActividad.style.display = "flex";
  
        imagen.src = "../img/iconos_formularios/icono_selector_iconos.svg";
    };
}

if (btnEditarAct !== null) {
    btnEditarAct.onclick = function () {
        cerrarModalPremio();
        formulario.action = "EditarPremio.jsp";

        tituloModal.textContent = "Editar hábito";
        btnMandarFormuActi.textContent = "Editar";
        document.getElementById("nombreHabito").value = document.getElementById("nomPre").innerText;
        imagen.src = document.getElementById("rutaImagenP").innerText;
        document.getElementById("iconSrcInput").value = document.getElementById("rutaImagenP").innerText;
        document.getElementById("recompensaActividad").value = document.getElementById("costoP").innerText;
        document.getElementById("opcionesTipo").value = document.getElementById("TipoP").innerText;
        document.getElementById('info-extra').value = document.getElementById("InfPre").innerText;
        document.getElementById("opcionesCategoria").value = document.getElementById("CatPre").innerText;
        document.getElementById("opcionesNivel").value = document.getElementById("nivPre").innerText;


        modalCrearActividad.style.display = "block";
        modalCrearActividad.style.display = "flex";


        document.getElementById('idActividadEditarActividad').value = document.getElementById('idPrem').innerText;
    };
}

cerrarModalBtn.onclick = function () {
    modalCrearActividad.style.display = "none";
};


var cerrarModalBtn = document.getElementById("cerrarModalBtn");

var modalCrearActividad = document.getElementById("modalCrearActividad");

cerrarModalBtn.onclick = function (event) {
    event.preventDefault();
    modalCrearActividad.style.display = "none";
};

// Función para limpiar el formulario
function limpiarFormulario() {
    // Limpieza de campos
    document.getElementById('nombreHabito').value = '';
    document.getElementById('recompensaActividad').value = '';

    // Restablecer opciones a sus valores por defecto
    document.getElementById('opcionesTipo').selectedIndex = 0;
    document.getElementById('opcionesCategoria').selectedIndex = 0;
    document.getElementById('opcionesNivel').selectedIndex = 0;
    document.getElementById('info-extra').value = '';
    document.getElementById('charCount').textContent = '0/350 caracteres'; // Reiniciar contador de caracteres


    // Restablecer el ícono al valor por defecto
    var defaultIconSrc = "../img/iconos_formularios/icono_selector_iconos.svg"; // Ruta del ícono por defecto
    var selectedIcon = document.getElementById("selectedIcon");
    selectedIcon.src = defaultIconSrc; // Restablecer el ícono
    document.getElementById("iconSrcInput").value = defaultIconSrc; // Limpiar el input oculto del ícono


    // Ocultar mensajes de error
    document.getElementById('nombreHabitoError').style.display = 'none';
    document.getElementById('errorRecompensa').style.display = 'none';
    document.getElementById('errorTipo').style.display = 'none';
    document.getElementById('errorTipoCategoria').style.display = 'none';
    document.getElementById('erroropcionesNivel').style.display = 'none';
    document.getElementById('errorInfoExtra').style.display = 'none';

    // Eliminar clases de error
    document.getElementById('nombreHabito').classList.remove('input-error');
    document.getElementById('recompensaActividad').classList.remove('input-error');
    document.getElementById('opcionesTipo').classList.remove('input-error');
    document.getElementById('opcionesCategoria').classList.remove('input-error');
    document.getElementById('opcionesNivel').classList.remove('input-error');
    document.getElementById('info-extra').classList.remove('input-error');


    // Cerrar opciones de color e ícono si están abiertas

    var iconOptions = document.getElementById("iconOptions"); // Asegúrate de que esto esté definido
    iconOptions.style.display = 'none';


    // Llamar a la función de actualización de alineación
    updateAlignment();
}


// Validación del campo "Nombre del Premio"
function validateNombreHabito() {
    const inputNombreHabito = document.getElementById('nombreHabito');
    const errorSpan = document.getElementById('nombreHabitoError');
    const nombreHabito = inputNombreHabito.value.trim();

    // Si hay un valor predeterminado que tiene al menos 3 caracteres
    if (nombreHabito.length >= 3) {
        // Oculta el mensaje de error
        errorSpan.style.display = 'none';
        inputNombreHabito.classList.remove('input-error'); // Quitar el estilo de error
        return true; // Validación exitosa
    }

    // Si el campo está vacío o tiene menos de 3 caracteres
    if (nombreHabito === "" || nombreHabito.length < 3) {
        // Muestra el mensaje de error
        errorSpan.style.display = 'block';
        errorSpan.textContent = 'El nombre del hábito debe tener al menos 3 caracteres.'; // Mensaje de error
        inputNombreHabito.classList.add('input-error'); // Resaltar el campo con un borde o estilo de error
        return false; // Validación fallida
    }
}



document.getElementById('nombreHabito').addEventListener('input', validateNombreHabito);
// Validación del campo "Nombre del Hábito"
function validateNombreHabito() {
    const inputNombreHabito = document.getElementById('nombreHabito');
    const errorSpan = document.getElementById('nombreHabitoError');
    const nombreHabito = inputNombreHabito.value.trim();

    console.log(`Validando Nombre del Hábito: "${nombreHabito}"`);

    if (nombreHabito.length >= 3) {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputNombreHabito.classList.remove('input-error'); // Quitar estilo de error
        return true; // Validación exitosa
    }

    if (nombreHabito === "" || nombreHabito.length < 3) {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        errorSpan.textContent = 'El nombre del hábito debe tener al menos 3 caracteres.'; // Mensaje de error
        inputNombreHabito.classList.add('input-error'); // Resaltar el campo
        return false; // Validación fallida
    }
}

// Validación del campo "Costo de Premio" (1-100)
function validateRecompensa() {
    const inputRecompensa = document.getElementById('recompensaActividad');
    const errorSpan = document.getElementById('errorRecompensa');
    const recompensaNumero = parseInt(inputRecompensa.value, 10);

    console.log(`Validando Costo de Premio: ${recompensaNumero}`);

    if (isNaN(recompensaNumero) || recompensaNumero > 1000 || recompensaNumero <= 0) {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        inputRecompensa.classList.add('input-error'); // Agregar estilo de error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputRecompensa.classList.remove('input-error'); // Quitar estilo de error
        return true;
    }
}

// Validación del campo "Tipo de Premio"
function validateTipo() {
    const inputTipo = document.getElementById('opcionesTipo');
    const errorSpan = document.getElementById('errorTipo');

    console.log(`Validando Tipo de Premio: ${inputTipo.selectedIndex}`);

    if (inputTipo.selectedIndex === 0) {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        inputTipo.classList.add('input-error'); // Agregar estilo de error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputTipo.classList.remove('input-error'); // Quitar estilo de error
        return true;
    }
}

// Validación del campo "Categoría de Premio"
function validateTipo1() {
    const inputTipo = document.getElementById('opcionesCategoria');
    const errorSpan = document.getElementById('errorTipoCategoria');

    console.log(`Validando Categoría de Premio: ${inputTipo.selectedIndex}`);

    if (inputTipo.selectedIndex === 0) {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        inputTipo.classList.add('input-error'); // Agregar estilo de error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputTipo.classList.remove('input-error'); // Quitar estilo de error
        return true;
    }
}
function validateTipo2() {
    const inputTipo = document.getElementById('opcionesNivel');
    const errorSpan = document.getElementById('erroropcionesNivel');

    console.log(`Validando Nivel de Premio: ${inputTipo.selectedIndex}`);

    if (inputTipo.selectedIndex === 0) {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        inputTipo.classList.add('input-error'); // Agregar estilo de error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputTipo.classList.remove('input-error'); // Quitar estilo de error
        return true;
    }
}

// Validación del campo "Información Extra"
function validateInfoExtra() {
    const inputInfoExtra = document.getElementById('info-extra');
    const errorSpan = document.getElementById('errorInfoExtra');

    console.log(`Validando Información Extra: "${inputInfoExtra.value}"`);

    if (inputInfoExtra.value.trim() === "") {
        errorSpan.style.display = 'block'; // Mostrar mensaje de error
        inputInfoExtra.classList.add('input-error'); // Agregar estilo de error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar mensaje de error
        inputInfoExtra.classList.remove('input-error'); // Quitar estilo de error
        return true;
    }
}

// Añadir event listeners para las validaciones al escribir
document.getElementById('nombreHabito').addEventListener('input', validateNombreHabito);
document.getElementById('recompensaActividad').addEventListener('input', validateRecompensa);
document.getElementById('opcionesTipo').addEventListener('change', validateTipo);
document.getElementById('opcionesCategoria').addEventListener('change', validateTipo1);
document.getElementById('opcionesNivel').addEventListener('change', validateTipo2);
document.getElementById('info-extra').addEventListener('input', validateInfoExtra);
// Mostrar las opciones filtradas por el input de "Nombre del Premio"
function showOptionsNombre() {
    document.getElementById('options-nombre').style.display = 'block';
}

function filterOptionsNombre() {
    const input = document.getElementById('nombreHabito').value.toLowerCase();
    const options = document.querySelectorAll('.options-nombre div:not(.category)');
    options.forEach(option => {
        const text = option.textContent.toLowerCase();
        option.style.display = text.includes(input) ? 'block' : 'none';
    });
    const visibleOptions = Array.from(options).some(option => option.style.display === 'block');
    document.getElementById('options-nombre').style.display = visibleOptions ? 'block' : 'none';
}

document.querySelectorAll('.options-nombre div:not(.category)').forEach(option => {
    option.addEventListener('click', function () {
        document.getElementById('nombreHabito').value = this.getAttribute('data-value');
        document.getElementById('options-nombre').style.display = 'none';
    });
});
const optionsDiv = document.getElementById('options-nombre');
const containerDiv = document.querySelector('.input-nombre-habito-container'); // Seleccionar correctamente el contenedor

// Mostrar opciones cuando el input se enfoca
function showOptionsNombre() {
    optionsDiv.style.display = 'block';
}

// Ocultar opciones cuando el mouse sale del contenedor
containerDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none';
});

// Ocultar opciones si se hace clic fuera del contenedor
window.addEventListener('click', function (event) {
    if (!containerDiv.contains(event.target)) {
        optionsDiv.style.display = 'none';
    }
});

// Evitar que se oculte cuando el mouse está sobre el menú de opciones
optionsDiv.addEventListener('mouseenter', function () {
    optionsDiv.style.display = 'block';
});
optionsDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none'; // Ocultar si el mouse sale del menú
});

// Validación final del formulario antes de enviar
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('formulario-nuevo-habito').addEventListener('submit', function (event) {
        let valid = true;

        // Validar campos adicionales
        if (!validateNombreHabito()) {
            valid = false;
        }
        if (!validateIconSrcInput()) {
            valid = false;
        }
        if (!validateRecompensa()) {
            valid = false;
        }
        if (!validateTipo()) {
            valid = false;
        }
        if (!validateTipo1()) {
            valid = false;
        }
        if (!validateTipo2()) {
            valid = false;
        }
        if (!validateInfoExtra()) {
            valid = false;
        }
        updateAlignment();
        if (!valid) {
            event.preventDefault();
        }
    });
});

// Elementos del DOM
var nombreHabitoError = document.getElementById("nombreHabitoError");
var iconColorContainer = document.querySelector(".input-icono-habito-container");


// Elementos del DOM
var nombreHabitoError = document.getElementById("nombreHabitoError");
var iconColorContainer = document.querySelector(".input-icono-habito-container");

// Función para actualizar el align-items
function updateAlignment() {
    // Verificar si el span de error está visible
    var isErrorVisible = window.getComputedStyle(nombreHabitoError).display !== "none";
    console.log("Estado de 'nombreHabitoError' visible:", isErrorVisible);

    if (isErrorVisible) {
        iconColorContainer.style.alignItems = "center";

    } else {
        iconColorContainer.style.alignItems = "flex-end";

    }
}
// Llamar la función cuando sea necesario, por ejemplo, después de validar el formulario
updateAlignment();

// Objeto que contiene los datos de cada premio
const premiosData = {
// Recompensas Juguetes
    "Coche de juguete": {
        nivel: "común",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 100,
        infoExtra: "Este coche de juguete es perfecto para desarrollar la imaginación y fomentar el juego simbólico. Los niños pueden crear sus propias aventuras y escenarios mientras mejoran sus habilidades motoras.",
        icon: "../img/Iconos-recompensas/coche_juguete.svg"
    },
    "Muñeca": {
        nivel: "común",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 150,
        infoExtra: "Una muñeca que se convertirá en la mejor amiga de tu hijo. Ideal para fomentar el juego de roles, la creatividad y la empatía mientras los niños crean historias y escenarios divertidos.",
        icon: "../img/Iconos-recompensas/muneca.svg"
    },
    "Pelota": {
        nivel: "común",
        categoria: "Juguetes",
        tipo: "Salud",
        costo: 200,
        infoExtra: "Una pelota versátil para disfrutar al aire libre. Jugar con una pelota ayuda a desarrollar habilidades motoras, coordinación y fomenta un estilo de vida activo y saludable.",
        icon: "../img/Iconos-recompensas/pelota.svg"
    },
    "Bloques de construcción": {
        nivel: "raro",
        categoria: "Juguetes",
        tipo: "Productividad",
        costo: 300,
        infoExtra: "Estos bloques de construcción estimulan la creatividad y el pensamiento crítico. Los niños pueden construir lo que imaginen, desarrollando habilidades espaciales y de resolución de problemas.",
        icon: "../img/Iconos-recompensas/bloques_construccion.svg"
    },
    "Set de LEGO": {
        nivel: "epico",
        categoria: "Juguetes",
        tipo: "Productividad",
        costo: 500,
        infoExtra: "Un clásico que nunca pasa de moda. Este set de LEGO permite a los niños crear estructuras complejas mientras desarrollan su imaginación y habilidades de planificación. Ideal para horas de diversión creativa.",
        icon: "../img/Iconos-recompensas/Lego.svg"

    },
    "Robot de juguete": {
        nivel: "raro",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 250,
        infoExtra: "Este robot interactivo es perfecto para aprender sobre tecnología de una manera divertida. Los niños pueden programar sus movimientos y crear historias emocionantes mientras juegan.",
        icon: "../img/Iconos-recompensas/Robot.svg"
    },
    "Drone para niños": {
        nivel: "epico",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 600,
        infoExtra: "Un emocionante drone diseñado para niños que permite explorar el aire. Desarrolla habilidades de control y coordinación mientras los niños se divierten en el exterior.",
        icon: "../img/Iconos-recompensas/Dron.svg"

    },
    "Camión de bomberos": {
        nivel: "raro",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 350,
        infoExtra: "Este camión de bomberos inspirará historias de rescate y aventuras emocionantes. Fomenta el juego imaginativo y la creatividad mientras los niños recrean situaciones heroicas.",
        icon: "../img/Iconos-recompensas/Bomberos.svg"
    },
    "Juegos de mesa (ej. Monopoly, Uno)": {
        nivel: "raro",
        categoria: "Juguetes",
        tipo: "Sociales",
        costo: 400,
        infoExtra: "Una forma excelente de pasar tiempo en familia o con amigos. Los juegos de mesa ayudan a desarrollar habilidades sociales, pensamiento estratégico y, sobre todo, ¡muchas risas!",
        icon: "../img/Iconos-recompensas/Juegos_de_mesa.svg"
    },
    "Puzzles y rompecabezas": {
        nivel: "raro",
        categoria: "Juguetes",
        tipo: "Productividad",
        costo: 350,
        infoExtra: "Un reto divertido que fomenta la concentración y la resolución de problemas. Los puzzles ayudan a desarrollar habilidades cognitivas mientras los niños se divierten armando imágenes.",
        icon: "../img/Iconos-recompensas/Puzzle.svg"

    },
    "Kits de ciencia o experimentos": {
        nivel: "epico",
        categoria: "Juguetes",
        tipo: "Educativos",
        costo: 450,
        infoExtra: "Estos kits permiten a los niños explorar el mundo de la ciencia a través de experimentos prácticos y divertidos. Aprenderán conceptos científicos de manera interactiva y entretenida.",
        icon: "../img/Iconos-recompensas/Ciencia.svg"
    },
    "Figuras de acción (ej. superhéroes)": {
        nivel: "común",
        categoria: "Juguetes",
        tipo: "Personales",
        costo: 200,
        infoExtra: "Figuras de acción que invitan a los niños a crear sus propias historias llenas de aventuras y heroísmo. Perfectas para el juego imaginativo y el desarrollo de narrativas creativas.",
        icon: "../img/Iconos-recompensas/Heroe.svg"

    },

// Recompensas de Tiempo
    "15 minutos adicionales de TV": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Personales",
        costo: 50,
        infoExtra: "Un pequeño premio para disfrutar de un episodio extra de tu serie o programa favorito. Ideal para relajarse y disfrutar de un momento de entretenimiento.",
        icon: "../img/Iconos-recompensas/TV.svg"
    },
    "30 minutos de videojuego": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Personales",
        costo: 100,
        infoExtra: "Más tiempo para sumergirte en el mundo de tus videojuegos favoritos. Un premio que proporciona diversión y entretenimiento adicional.",
        icon: "../img/Iconos-recompensas/VideoJuego.svg"
    },
    "Hora de dormir extendida": {
        nivel: "raro",
        categoria: "Tiempo",
        tipo: "Emocionales",
        costo: 200,
        infoExtra: "Una hora extra para quedarte despierto y disfrutar de actividades tranquilas. Perfecto para un momento especial de conexión familiar antes de dormir.",
        icon: "../img/Iconos-recompensas/Dormir.svg"
    },
    "30 minutos de parque": {
        nivel: "raro",
        categoria: "Tiempo",
        tipo: "Salud",
        costo: 150,
        infoExtra: "Disfruta de un tiempo adicional al aire libre, jugando en el parque. Ideal para mantenerse activo, socializar y disfrutar de la naturaleza.",
        icon: "../img/Iconos-recompensas/Parque.svg"
    },
    "Una tarde en casa de amigos": {
        nivel: "raro",
        categoria: "Tiempo",
        tipo: "Sociales",
        costo: 200,
        infoExtra: "Un tiempo especial para jugar y compartir con amigos. Fomenta las relaciones sociales y crea recuerdos divertidos.",
        icon: "../img/Iconos-recompensas/Amigos.svg"
    },
    "Día libre de tareas escolares": {
        nivel: "raro",
        categoria: "Tiempo",
        tipo: "Personales",
        costo: 75,
        infoExtra: "Un día libre de todas las tareas escolares, perfecto para relajarse y disfrutar de tiempo libre.",
        icon: "../img/Iconos-recompensas/Tareas.svg"
    },
    "Una noche de películas con palomitas": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Sociales",
        costo: 30,
        infoExtra: "Disfruta de una noche acogedora viendo tus películas favoritas acompañada de palomitas.",
        icon: "../img/Iconos-recompensas/Pelicula.svg"
    },
    "Sesión de lectura extra": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Personales",
        costo: 20,
        infoExtra: "Dedica tiempo extra a la lectura de tus libros favoritos para relajarte y aprender.",
        icon: "../img/Iconos-recompensas/Libro.svg"
    },
    "Día sin reglas de casa": {
        nivel: "raro",
        categoria: "Tiempo",
        tipo: "Sociales",
        costo: 50,
        infoExtra: "Un día especial donde puedes disfrutar de libertad total en casa, sin reglas que seguir.",
        icon: "../img/Iconos-recompensas/No_Reglas.svg"
    },
    "Tarde de juegos de mesa en familia": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Sociales",
        costo: 40,
        infoExtra: "Disfruta de una divertida tarde jugando juegos de mesa con la familia.",
        icon: "../img/Iconos-recompensas/Juegos_Familia.svg"
    },
    "Tiempo de relajación en la bañera": {
        nivel: "común",
        categoria: "Tiempo",
        tipo: "Personales",
        costo: 60,
        infoExtra: "Dedica un tiempo para relajarte en la bañera, con burbujas y música suave.",
        icon: "../img/Iconos-recompensas/banera.svg"
    },

// Recompensas de Comida
    "Helado": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 5,
        infoExtra: "Un delicioso helado de tu sabor favorito, ideal para refrescarte en un día caluroso. Perfecto para compartir con amigos o disfrutar en un momento de relax.",
        icon: "../img/Iconos-recompensas/Helado.svg"
    },
    "Pizza": {
        nivel: "raro",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 25,
        infoExtra: "Una rica pizza con tus ingredientes preferidos, perfecta para disfrutar en una noche de juegos o una reunión familiar. Comparte con quienes más quieres.",
        icon: "../img/Iconos-recompensas/Pizza.svg"
    },
    "Chocolates": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 10,
        infoExtra: "Una selección de deliciosos chocolates para satisfacer tu antojo. Ideal para compartir con amigos o como un regalo especial.",
        icon: "../img/Iconos-recompensas/Chocolate.svg"
    },
    "Palomitas de maíz": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 5,
        infoExtra: "Un clásico de las noches de cine, estas palomitas son perfectas para disfrutar mientras miras tu película favorita. Comparte la diversión con tus amigos.",
        icon: "../img/Iconos-recompensas/Palomitas.svg"
    },
    "Cena en tu restaurante favorito": {
        nivel: "legendario",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 50,
        infoExtra: "Una cena gourmet en tu restaurante favorito, donde podrás disfrutar de una experiencia culinaria única con un ambiente acogedor y excelente servicio.",
        icon: "../img/Iconos-recompensas/Restaurante.svg"
    },
    "Tarta de cumpleaños extra": {
        nivel: "raro",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 30,
        infoExtra: "Una deliciosa tarta de cumpleaños decorada de forma especial para hacer tu celebración aún más memorable. Ideal para compartir con amigos y familiares.",
        icon: "../img/Iconos-recompensas/Pastel_cumpleaños.svg"
    },
    "Galletas caseras": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 15,
        infoExtra: "Galletas recién horneadas, crujientes por fuera y suaves por dentro. Perfectas para acompañar con un vaso de leche o como un regalo para alguien especial.",
        icon: "../img/Iconos-recompensas/Galleta.svg"
    },
    "Una caja de dulces sorpresa": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Sociales",
        costo: 10,
        infoExtra: "Una caja llena de deliciosos dulces variados que te sorprenderán en cada bocado. Ideal para disfrutar en cualquier ocasión especial.",
        icon: "../img/Iconos-recompensas/Dulces.svg"
    },
    "Batidos de frutas": {
        nivel: "raro",
        categoria: "Comida",
        tipo: "Salud",
        costo: 20,
        infoExtra: "Batidos refrescantes de frutas frescas, perfectos para nutrir tu cuerpo y deleitar tu paladar. Una opción saludable para cualquier momento del día.",
        icon: "../img/Iconos-recompensas/Batido_Frutas.svg"
    },
    "Desayuno en la cama": {
        nivel: "común",
        categoria: "Comida",
        tipo: "Personales",
        costo: 15,
        infoExtra: "Un delicioso desayuno servido en la cama, con todo lo que amas para comenzar el día con energía. Perfecto para mimarte en una mañana especial.",
        icon: "../img/Iconos-recompensas/Desayuno_Cama.svg"
    },

// Recompensas Especiales 
    "Salir al cine": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 50,
        infoExtra: "Disfruta de una experiencia cinematográfica en la pantalla grande con entradas para la película que has estado esperando. Perfecto para una noche de diversión.",
        icon: "../img/Iconos-recompensas/Cine.svg"
    },
    "Paseo a la playa": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Emocionales",
        costo: 70,
        infoExtra: "Un día completo en la playa, disfrutando del sol, el mar y la arena. Ideal para relajarte y desconectar de la rutina diaria.",
        icon: "../img/Iconos-recompensas/Playa.svg"
    },
    "Día en el zoológico": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 60,
        infoExtra: "Un día emocionante observando a tus animales favoritos en el zoológico. Ideal para aprender y divertirte en un entorno familiar.",
        icon: "../img/Iconos-recompensas/Zoo.svg"
    },
    "Visita al parque de diversiones": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 80,
        infoExtra: "Una aventura llena de emoción en un parque de diversiones. Disfruta de atracciones, juegos y deliciosas comidas con amigos o familiares.",
        icon: "../img/Iconos-recompensas/Parque_Diversiones.svg"
    },
    "Día de picnic": {
        nivel: "raro",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 40,
        infoExtra: "Un día al aire libre con un picnic delicioso en un parque. Disfruta de la naturaleza y la buena compañía mientras saboreas tus comidas favoritas.",
        icon: "../img/Iconos-recompensas/Picnic.svg"
    },
    "Día de compras": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 60,
        infoExtra: "Un día emocionante de compras donde podrás adquirir lo que desees. Ideal para consentirte con un nuevo atuendo o gadgets.",
        icon: "../img/Iconos-recompensas/Compras.svg"
    },
    "Concierto de tu banda favorita": {
        nivel: "legendario",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 100,
        infoExtra: "Una noche inolvidable disfrutando de un concierto de tu banda favorita en vivo. Comparte la experiencia con amigos y vibra al ritmo de la música.",
        icon: "../img/Iconos-recompensas/Concierto.svg"
    },
    "Excursión al museo": {
        nivel: "raro",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 100,
        infoExtra: "Un emocionante día de exploración en un museo, aprendiendo sobre historia, arte o ciencia.",
        icon: "../img/Iconos-recompensas/Museo.svg"
    },
    "Viaje de fin de semana a una ciudad cercana": {
        nivel: "epico",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 400,
        infoExtra: "Un viaje de fin de semana a una ciudad cercana para explorar nuevas culturas y gastronomía.",
        icon: "../img/Iconos-recompensas/Viaje_Ciudad.svg"
    },
    "Día de spa en casa": {
        nivel: "raro",
        categoria: "Especiales",
        tipo: "Personales",
        costo: 80,
        infoExtra: "Dedica un día a consentirte con un spa en casa, incluyendo tratamientos relajantes.",
        icon: "../img/Iconos-recompensas/Spa.svg"
    },
    "Visita a una granja o reserva natural": {
        nivel: "epico",
        categoria: "Especiales",
        tipo: "Sociales",
        costo: 150,
        infoExtra: "Disfruta de un día en la naturaleza visitando una granja o reserva natural, aprendiendo sobre la vida rural.",
        icon: "../img/Iconos-recompensas/Granja.svg"
    },

// Recompensas de Tecnología
    "Nueva tablet o e-reader": {
        nivel: "raro",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 300,
        infoExtra: "Un dispositivo portátil que te permitirá disfrutar de tus libros y aplicaciones favoritas en cualquier lugar. Ideal para leer, estudiar o entretenerte.",
        icon: "../img/Iconos-recompensas/Tablet.svg"
    },
    "Auriculares inalámbricos": {
        nivel: "común",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 150,
        infoExtra: "Auriculares de alta calidad para disfrutar de tu música sin cables. Perfectos para hacer ejercicio o simplemente relajarte con tus canciones favoritas.",
        icon: "../img/Iconos-recompensas/Auriculares.svg"
    },
    "Juego de video nuevo": {
        nivel: "común",
        categoria: "Tecnología",
        tipo: "Recreación",
        costo: 60,
        infoExtra: "Un nuevo juego de video que te ofrecerá horas de diversión y desafíos. Ideal para compartir con amigos o disfrutar en solitario.",
        icon: "../img/Iconos-recompensas/Video_Nuevo.svg"
    },
    "Accesorios para la consola de videojuegos": {
        nivel: "común",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 50,
        infoExtra: "Accesorios para mejorar tu experiencia de juego, ya sea un control adicional, un soporte o un headset. Perfectos para los amantes de los videojuegos.",
        icon: "../img/Iconos-recompensas/Accesorios.svg"
    },
    "Cámara instantánea": {
        nivel: "raro",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 200,
        infoExtra: "Una cámara que imprime fotos al instante, ideal para capturar y compartir momentos especiales. Perfecta para eventos y celebraciones.",
        icon: "../img/Iconos-recompensas/Camara.svg"
    },
    "Suscripción a un servicio de streaming": {
        nivel: "común",
        categoria: "Tecnología",
        tipo: "Recreación",
        costo: 12,
        infoExtra: "Acceso a un mundo de series, películas y documentales al instante. Ideal para disfrutar de noches de cine en casa.",
        icon: "../img/Iconos-recompensas/Streaming.svg"
    },
    "Reloj inteligente": {
        nivel: "raro",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 250,
        infoExtra: "Un reloj que te ayuda a mantenerte conectado y activo, monitoreando tu salud y actividades diarias. Ideal para un estilo de vida moderno.",
        icon: "../img/Iconos-recompensas/Reloj.svg"
    },
    "Laptop nueva": {
        nivel: "raro",
        categoria: "Tecnología",
        tipo: "Personales",
        costo: 700,
        infoExtra: "Una nueva laptop para realizar tus tareas diarias, estudiar o jugar. Perfecta para el trabajo y el entretenimiento.",
        icon: "../img/Iconos-recompensas/Laptop.svg"
    },
    "Altavoz Bluetooth": {
        nivel: "común",
        categoria: "Tecnología",
        tipo: "Recreación",
        costo: 100,
        infoExtra: "Un altavoz portátil que te permitirá disfrutar de tu música favorita en cualquier lugar. Perfecto para fiestas o días de campo.",
        icon: "../img/Iconos-recompensas/Altavoz.svg"
    },

    // Recompensas de Entretenimiento 
    "Entradas para un espectáculo": {
        nivel: "epico",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 200,
        infoExtra: "Entradas para disfrutar de un emocionante espectáculo en vivo, ya sea teatro, comedia o danza. Perfecto para una noche de diversión.",
        icon: "../img/Iconos-recompensas/Entradas.svg"
    },
    "Suscripción a una revista": {
        nivel: "común",
        categoria: "Entretenimiento",
        tipo: "Educativos",
        costo: 10,
        infoExtra: "Una suscripción a tu revista favorita, donde podrás aprender sobre temas de interés y disfrutar de contenido exclusivo.",
        icon: "../img/Iconos-recompensas/Revista.svg"
    },
    "Curso en línea de un tema de interés": {
        nivel: "raro",
        categoria: "Entretenimiento",
        tipo: "Educativos",
        costo: 50,
        infoExtra: "Un curso en línea para aprender sobre un tema que te apasione. Ideal para mejorar tus habilidades y conocimientos desde la comodidad de tu hogar.",
        icon: "../img/Iconos-recompensas/Curso_Linea.svg"
    },
    "Pase anual a un parque temático": {
        nivel: "legendario",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 500,
        infoExtra: "Un pase que te permitirá disfrutar de un año completo de diversión en un parque temático, con acceso a atracciones y eventos especiales.",
        icon: "../img/Iconos-recompensas/Pase_Anual.svg"
    },
    "Tarjeta de regalo para una tienda de entretenimiento": {
        nivel: "raro",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 100,
        infoExtra: "Una tarjeta de regalo para gastar en tu tienda de entretenimiento favorita. Perfecta para elegir lo que más te gusta.",
        icon: "../img/Iconos-recompensas/Tarjeta.svg"
    },
    "Día de karaoke con amigos": {
        nivel: "raro",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 30,
        infoExtra: "Una divertida noche de karaoke con amigos, cantando tus canciones favoritas y disfrutando de risas y buena compañía.",
        icon: "../img/Iconos-recompensas/Karaoke.svg"
    },
    "Taller de arte o manualidades": {
        nivel: "raro",
        categoria: "Entretenimiento",
        tipo: "Habilidades",
        costo: 40,
        infoExtra: "Un taller práctico donde podrás aprender nuevas habilidades artísticas y crear tus propias obras de arte. Perfecto para expresar tu creatividad.",
        icon: "../img/Iconos-recompensas/Manualidades.svg"
    },
    "Clases de cocina": {
        nivel: "raro",
        categoria: "Entretenimiento",
        tipo: "Educativos",
        costo: 120,
        infoExtra: "Aprende a preparar deliciosos platillos con clases de cocina que despierten tu creatividad culinaria.",
        icon: "../img/Iconos-recompensas/Cocina.svg"
    },
    "Participación en una escape room": {
        nivel: "epico",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 200,
        infoExtra: "Vive una emocionante experiencia de resolución de acertijos y trabajo en equipo en una escape room.",
        icon: "../img/Iconos-recompensas/EscapeRoom.svg"
    },
    "Festival de música": {
        nivel: "legendario",
        categoria: "Entretenimiento",
        tipo: "Sociales",
        costo: 300,
        infoExtra: "Disfruta de un festival de música con tus artistas favoritos y vive una experiencia inolvidable.",
        icon: "../img/Iconos-recompensas/Musica.svg"
    },
// Recompensas de Deporte
    "Equipo deportivo nuevo (ej. bicicleta, patines)": {
        nivel: "epico",
        categoria: "Deporte",
        tipo: "Personales",
        costo: 400,
        infoExtra: "Obtén un equipo deportivo nuevo, como una bicicleta o patines, para disfrutar de actividades al aire libre y mantenerte activo.",
        icon: "../img/Iconos-recompensas/Equipo_Deportivo.svg"
    },
    "Entradas para un evento deportivo": {
        nivel: "raro",
        categoria: "Deporte",
        tipo: "Sociales",
        costo: 150,
        infoExtra: "Disfruta de la emoción de un evento deportivo en vivo con entradas para ver a tu equipo favorito.",
        icon: "../img/Iconos-recompensas/Entradas_Estadio.svg"
    },
    "Clase de deportes (ej. natación, fútbol)": {
        nivel: "raro",
        categoria: "Deporte",
        tipo: "Educativos",
        costo: 100,
        infoExtra: "Participa en clases de deportes como natación o fútbol para mejorar tus habilidades y mantenerte activo.",
        icon: "../img/Iconos-recompensas/Clases_Deporte.svg"
    },
    "Pase para un gimnasio": {
        nivel: "común",
        categoria: "Deporte",
        tipo: "Personales",
        costo: 80,
        infoExtra: "Obtén un pase para un gimnasio y accede a instalaciones para entrenar y mantenerte en forma.",
        icon: "../img/Iconos-recompensas/Gym.svg"
    },
    "Ropa deportiva nueva": {
        nivel: "común",
        categoria: "Deporte",
        tipo: "Personales",
        costo: 60,
        infoExtra: "Consigue ropa deportiva nueva para que te sientas cómodo y con estilo mientras practicas tus deportes favoritos.",
        icon: "../img/Iconos-recompensas/Ropa_Deportiva.svg"
    },
    "Accesorios para practicar un deporte (ej. balón, raqueta)": {
        nivel: "raro",
        categoria: "Deporte",
        tipo: "Personales",
        costo: 70,
        infoExtra: "Adquiere accesorios necesarios para practicar tu deporte favorito, como un balón o una raqueta.",
        icon: "../img/Iconos-recompensas/Accesorios_Deporte.svg"
    },
    "Un día en un parque de aventuras": {
        nivel: "legendario",
        categoria: "Deporte",
        tipo: "Sociales",
        costo: 300,
        infoExtra: "Disfruta de un día lleno de emoción en un parque de aventuras, donde podrás practicar diferentes deportes y actividades al aire libre.",
        icon: "../img/Iconos-recompensas/Parque_Aventuras.svg"
    },
    "Día de senderismo en la naturaleza": {
        nivel: "raro",
        categoria: "Deporte",
        tipo: "Sociales",
        costo: 90,
        infoExtra: "Participa en un día de senderismo y disfruta de la belleza de la naturaleza mientras te mantienes activo.",
        icon: "../img/Iconos-recompensas/Senderismo.svg"
    },
// Recompensas de Educación
    "Herramientas para el aprendizaje (ej. calculadora, diccionario)": {
        nivel: "común",
        categoria: "Educación",
        tipo: "Personales",
        costo: 30,
        infoExtra: "Consigue herramientas que facilitarán tu aprendizaje, como una calculadora o un diccionario.",
        icon: "../img/Iconos-recompensas/Calculadora.svg"
    },

    "Clases de música o arte": {
        nivel: "raro",
        categoria: "Educación",
        tipo: "Educativos",
        costo: 100,
        infoExtra: "Participa en clases de música o arte para desarrollar tu creatividad y habilidades artísticas.",
        icon: "../img/Iconos-recompensas/Clases_Musica.svg"
    },
    "Visitas a bibliotecas o centros culturales": {
        nivel: "común",
        categoria: "Educación",
        tipo: "Sociales",
        costo: 20,
        infoExtra: "Realiza visitas a bibliotecas o centros culturales para ampliar tus horizontes y aprender de nuevas experiencias.",
        icon: "../img/Iconos-recompensas/Biblioteca_1.svg"
    },
    "Material de arte (pinturas, lápices, etc.)": {
        nivel: "raro",
        categoria: "Educación",
        tipo: "Personales",
        costo: 60,
        infoExtra: "Consigue material de arte como pinturas y lápices para expresar tu creatividad y realizar tus obras.",
        icon: "../img/Iconos-recompensas/Arte.svg"
    },
    // Recompensas de Aventura
    "Día de camping": {
        nivel: "raro",
        categoria: "Aventura",
        tipo: "Aventuras",
        costo: 150,
        infoExtra: "Disfruta de un día al aire libre en la naturaleza, acampando y explorando el entorno.",
        icon: "../img/Iconos-recompensas/Camping.svg"
    },
    "Escalada en roca": {
        nivel: "epico",
        categoria: "Aventura",
        tipo: "Experiencias",
        costo: 250,
        infoExtra: "Experimenta la emoción de escalar en roca en un entorno seguro y desafiante.",
        icon: "../img/Iconos-recompensas/Escalada.svg"
    },
    "Paseo en kayak o canoa": {
        nivel: "raro",
        categoria: "Aventura",
        tipo: "Experiencias",
        costo: 100,
        infoExtra: "Disfruta de un paseo en kayak o canoa por ríos o lagos, rodeado de naturaleza.",
        icon: "../img/Iconos-recompensas/Kayak.svg"
    },
    "Safari en un parque nacional": {
        nivel: "legendario",
        categoria: "Aventura",
        tipo: "Experiencias",
        costo: 600,
        infoExtra: "Embárcate en un safari y observa la vida salvaje en su hábitat natural.",
        icon: "../img/Iconos-recompensas/Safari.svg"
    },
    "Exploración de cuevas": {
        nivel: "epico",
        categoria: "Aventura",
        tipo: "Experiencias",
        costo: 180,
        infoExtra: "Explora cuevas misteriosas y descubre su belleza oculta en un tour guiado.",
        icon: "../img/Iconos-recompensas/Cuevas.svg"
    },
    "Día de rafting": {
        nivel: "epico",
        categoria: "Aventura",
        tipo: "Recreación",
        costo: 220,
        infoExtra: "Vive la aventura en un día de rafting, desafiando las corrientes de un río emocionante.",
        icon: "../img/Iconos-recompensas/Rafting.svg"
    },
    "Tirolesa en un parque de aventura": {
        nivel: "raro",
        categoria: "Aventura",
        tipo: "Recreación",
        costo: 120,
        infoExtra: "Disfruta de la adrenalina mientras te deslizas por una tirolesa en un parque de aventura.",
        icon: "../img/Iconos-recompensas/Tirolesa.svg"
    },
    "Un viaje en globo aerostático": {
        nivel: "legendario",
        categoria: "Aventura",
        tipo: "Experiencias",
        costo: 800,
        infoExtra: "Vuela alto en un globo aerostático y disfruta de vistas impresionantes desde el aire.",
        icon: "../img/Iconos-recompensas/Globo_Aerostatico.svg"
    },
    "Clases de supervivencia al aire libre": {
        nivel: "epico",
        categoria: "Aventura",
        tipo: "Educativos",
        costo: 200,
        infoExtra: "Aprende técnicas de supervivencia esenciales en un entorno natural.",
        icon: "../img/Iconos-recompensas/Supervivencia.svg"
    },

// Recompensas de Creatividad

    "Taller de fotografía": {
        nivel: "raro",
        categoria: "Creatividad",
        tipo: "Educativos",
        costo: 120,
        infoExtra: "Aprende a capturar momentos especiales en un taller de fotografía.",
        icon: "../img/Iconos-recompensas/Fotografia.svg"
    },
    "Clases de pintura o escultura": {
        nivel: "epico",
        categoria: "Creatividad",
        tipo: "Educativos",
        costo: 150,
        infoExtra: "Desarrolla tus habilidades artísticas con clases de pintura o escultura.",
        icon: "../img/Iconos-recompensas/escultura.svg"
    },
    "Material de escritura (ej. cuadernos, plumas)": {
        nivel: "común",
        categoria: "Creatividad",
        tipo: "Personales",
        costo: 15,
        infoExtra: "Consigue material de escritura que incluye cuadernos y plumas para tus ideas y pensamientos.",
        icon: "../img/Iconos-recompensas/Escritura.svg"
    },
    "Accesorios para música (ej. guitarra, teclado)": {
        nivel: "epico",
        categoria: "Creatividad",
        tipo: "Personales",
        costo: 300,
        infoExtra: "Adquiere accesorios para música, como una guitarra o un teclado, y expresa tu creatividad musical.",
        icon: "../img/Iconos-recompensas/Guitarra.svg"
    },
    "Curso de diseño gráfico": {
        nivel: "legendario",
        categoria: "Creatividad",
        tipo: "Educativos",
        costo: 500,
        infoExtra: "Aprende diseño gráfico y desarrolla tus habilidades creativas en un curso especializado.",
        icon: "../img/Iconos-recompensas/Diseño_Grafico.svg"
    },
    "Kit de jardinería": {
        nivel: "raro",
        categoria: "Creatividad",
        tipo: "Personales",
        costo: 70,
        infoExtra: "Cultiva tus propias plantas y flores con un kit de jardinería que incluye todo lo necesario.",
        icon: "../img/Iconos-recompensas/Jardineria.svg"
    },
    "Participación en un club de arte": {
        nivel: "común",
        categoria: "Creatividad",
        tipo: "Sociales",
        costo: 30,
        infoExtra: "Únete a un club de arte y comparte tus intereses creativos con otros entusiastas.",
        icon: "../img/Iconos-recompensas/Club.svg"
    },
    "Materiales para hacer joyas": {
        nivel: "raro",
        categoria: "Creatividad",
        tipo: "Personales",
        costo: 60,
        infoExtra: "Crea tus propias joyas con materiales diseñados específicamente para este propósito.",
        icon: "../img/Iconos-recompensas/Joyas.svg"
    },
    "Experiencias de improvisación teatral": {
        nivel: "epico",
        categoria: "Creatividad",
        tipo: "Educativos",
        costo: 150,
        infoExtra: "Participa en experiencias de improvisación teatral y mejora tus habilidades de actuación.",
        icon: "../img/Iconos-recompensas/Teatral.svg"
    }
};

// Evento para autocompletar los campos al seleccionar un premio preestablecido
document.querySelectorAll('.text-options-nombre-habito').forEach(option => {
    option.addEventListener('click', function () {
        const premioSeleccionado = this.getAttribute('data-value');

        // Si el premio existe en los datos, autocompletar los demás campos
        if (premiosData[premioSeleccionado]) {
            // Autocompletar campos de texto
            document.getElementById('nombreHabito').value = premioSeleccionado;
            document.getElementById('opcionesNivel').value = premiosData[premioSeleccionado].nivel;
            document.getElementById('opcionesCategoria').value = premiosData[premioSeleccionado].categoria;
            document.getElementById('opcionesTipo').value = premiosData[premioSeleccionado].tipo;
            document.getElementById('recompensaActividad').value = premiosData[premioSeleccionado].costo;

            // Autocompletar info extra
            const infoExtra = premiosData[premioSeleccionado].infoExtra;
            document.getElementById('info-extra').value = infoExtra; // Usar value para textarea
            updateCharCount(infoExtra.length); // Actualizar el contador con la longitud de la infoExtra

            // Autocompletar icono y color
            const icono = premiosData[premioSeleccionado].icon; // Obtener el icono


            // Actualizar el ícono seleccionado y el input oculto
            document.getElementById('selectedIcon').src = icono;
            document.getElementById('iconSrcInput').value = icono;
            // Validar después de autocompletar
            validateNombreHabito(); // Validar el nombre del hábito
            validateRecompensa(); // Validar el costo
            validateTipo(); // Validar tipo
            validateTipo1();
            validateTipo2();// Validar categoría
            validateInfoExtra(); // Validar información extra
        }

        // Ocultar las opciones de nombre
        document.getElementById('options-nombre').style.display = 'none';
    });
});

// Mostrar las opciones al enfocar el campo de nombre
function showOptionsNombre() {
    document.getElementById('options-nombre').style.display = 'block';
}

// Filtrar las opciones de nombre según el input
function filterOptionsNombre() {
    const filter = document.getElementById('nombreHabito').value.toLowerCase();
    document.querySelectorAll('.text-options-nombre-habito').forEach(option => {
        if (option.getAttribute('data-value').toLowerCase().includes(filter)) {
            option.style.display = '';
        } else {
            option.style.display = 'none';
        }
    });
}

// Función para actualizar el contador de caracteres
function updateCharCount(cantidad) {
    const limiteCaracteres = 350;
    const contador = document.getElementById("charCount");
    contador.textContent = cantidad + "/" + limiteCaracteres + " caracteres";
}

// Contador de caracteres para "Información Extra"
document.addEventListener("DOMContentLoaded", function () {
    var textarea = document.getElementById("info-extra");
    const infoExtra = textarea.value; // Capturar el valor actual del textarea
    updateCharCount(infoExtra.length); // Actualizar el contador con la longitud inicial

    // Evento para contar caracteres mientras se escribe
    textarea.addEventListener("input", function () {
        var contenido = textarea.value;
        var caracteresEscritos = contenido.length;
        var limiteCaracteres = 350;
        if (caracteresEscritos > limiteCaracteres) {
            textarea.value = textarea.value.substring(0, limiteCaracteres);
            caracteresEscritos = limiteCaracteres;
        }
        updateCharCount(caracteresEscritos); // Actualizar contador al escribir
    });

    // Asegúrate de que el contador se actualice también al seleccionar un premio
    const options = document.querySelectorAll('.text-options-nombre-habito');
    options.forEach(option => {
        option.addEventListener('click', function () {
            const premioSeleccionado = this.getAttribute('data-value');
            if (premiosData[premioSeleccionado]) {
                const infoExtra = premiosData[premioSeleccionado].infoExtra;
                document.getElementById('info-extra').value = infoExtra; // Usar value para textarea
                updateCharCount(infoExtra.length); // Actualizar el contador justo después de seleccionar
            }
        });
    });
});
// Validación final del formulario antes de enviar
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('formulario-nuevo-habito').addEventListener('submit', function (event) {
        let valid = true;

        // Validar campos adicionales
        if (!validateNombreHabito()) {
            valid = false;
        }
        if (!validateIconSrcInput()) {
            valid = false;

        }
        if (!validateRecompensa()) {
            valid = false;
        }
        if (!validateTipo()) {
            valid = false;
        }
        if (!validateTipo1()) {
            valid = false;
        }
        if (!validateTipo2()) {
            valid = false;
        }
        if (!validateInfoExtra()) {
            valid = false;
        }
        if (!valid) {
            event.preventDefault();
        }
    });
});
// Elementos del DOM
var iconDisplay = document.getElementById("iconDisplay");
var iconOptions = document.getElementById("iconOptions");
var selectedIcon = document.getElementById("selectedIcon");
var iconSrcInput = document.getElementById("iconSrcInput"); // Input oculto
var selectedIconName = ""; // Variable para almacenar el nombre del ícono seleccionado



// Mostrar/ocultar los íconos al hacer clic en el área de selección
iconDisplay.onclick = function () {
    // Mostrar/ocultar el menú de íconos
    iconOptions.style.display = iconOptions.style.display === "none" ? "block" : "none";
};


// Seleccionar un ícono y almacenar su nombre en el input oculto
var iconOptionImages = document.querySelectorAll(".icon-option");
iconOptionImages.forEach(function (icon) {
    icon.onclick = function () {
        // Obtener la ruta de la imagen directamente del atributo src
        var iconSrc = this.src;

        // Cambiar la imagen seleccionada
        selectedIcon.src = iconSrc; // Cambiar la imagen visualizada
        iconSrcInput.value = iconSrc; // Guardar la ruta del ícono en el value del input oculto

        // Cerrar el menú de íconos
        iconOptions.style.display = "none";
    };
});

// Evitar que se oculte cuando el mouse está sobre el menú de opciones
iconOptions.addEventListener('mouseenter', function () {
    iconOptions.style.display = 'block';
});
iconOptions.addEventListener('mouseleave', function () {
    iconOptions.style.display = 'none'; // Ocultar si el mouse sale del menú
});
function showToastIconos() {
    const toast = document.getElementById('toast-iconos');
    toast.style.display = 'block';
    setTimeout(() => {
        toast.style.display = 'none';
    }, 7000); // El toast se oculta después de 3 segundos
}

// Función para validar el input oculto
function validateIconSrcInput() {
    const iconSrcInput = document.getElementById('iconSrcInput').value;

    if (iconSrcInput === '') {
        showToastIconos();
        return false;
    }
    return true;
}

// Función para validar el input oculto
function validateColorValue() {
    const iconSrcInput = document.getElementById('selectedColorInput').value;

    if (iconSrcInput === '') {
        showToastIconos();
        return false;
    }
    return true;
}

function showToastPremioExistente() {
    const toast = document.getElementById('toast-premio-existente');
    toast.style.display = 'block'; // Muestra el toast
    console.log("Error: Ya existe un premio con esos datos."); // Mensaje en consola
    setTimeout(() => {
        toast.style.display = 'none'; // Oculta el toast después de 7 segundos
    }, 7000);
}