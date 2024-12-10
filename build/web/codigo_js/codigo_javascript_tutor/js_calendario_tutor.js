const toggleButton = document.querySelector('.toggle');
const sidebar = document.querySelector('.sidebar');
const logo = document.getElementById('iconoNavLogo');
const rango = document.getElementById("rango-fecha");
const fechasCont = document.getElementById("fechas-cont");
const btnPrevio = document.getElementById("btn-previo");
const btnSig = document.getElementById("btn-siguiente");
const btnHoy = document.getElementById("btnHoy");
const diasSemana = document.querySelectorAll('.dia');

// Agregar evento de clic al botón de toggle
toggleButton.addEventListener('click', () => {
    sidebar.classList.toggle('collapsed');
    if (sidebar.classList.contains('collapsed')) {
        logo.src = '../img/icono_azul_logo.svg'; // Logo cuando está contraído
    } else {
        logo.src = '../img/logo_letras_castorway.svg'; // Logo original
    }

});

const fechaGuardadaSesion = sessionStorage.getItem("fechaGuardada");
const fechaSeleccionadaSesion = sessionStorage.getItem("fechaSeleccionada");

let fechaGuardada;
let fechaAct = new Date();


if (fechaGuardadaSesion) {
    // Recuperar fecha desde sessionStorage
    fechaAct = new Date(fechaGuardadaSesion);
    fechaGuardada = new Date(fechaGuardadaSesion);
} else {
    // Si no hay fecha guardada o se reinició, establece fechaAct al inicio de la semana actual
    fechaAct = new Date();
    fechaAct.setDate(fechaAct.getDate() - fechaAct.getDay()); // Inicio de semana
    fechaGuardada = new Date(fechaAct);
}

function buscarFecha(diaActual) {
    console.log(diaActual); //pruebita para ver si lo manda bn

    const form = document.createElement("form");
    form.method = "POST";
    form.action = "calendario_tutor.jsp";

    const inputFecha = document.createElement("input");
    inputFecha.type = "hidden";
    inputFecha.name = "fechaConsulta";
    inputFecha.value = diaActual;

    form.appendChild(inputFecha);

    document.body.appendChild(form);
    form.submit();

}


function formatoFecha(fecha) {
    const año = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, '0');
    const dia = String(fecha.getDate()).padStart(2, '0');

    return `${año}-${mes}-${dia}`;
}


function escribirFechas() {
    if (fechaGuardada) {
        // Solo actualizar fechaAct si fechaGuardada existe
        fechaAct = new Date(fechaGuardada);
    }

    fechasCont.innerHTML = "";
    const primerDia = new Date(fechaAct);
    console.log("fechaAct: " + fechaAct);//para ver si si sale la primer fecha
    console.log("primer dia del calendario: " + primerDia);
    const ultimoDia = new Date(fechaAct);
    ultimoDia.setDate(primerDia.getDate() + 6);

    const mesInicio = primerDia.toLocaleString("default", {month: "long"});
    const mesFin = ultimoDia.toLocaleString("default", {month: "long"});

    const anioInicio = primerDia.getFullYear();
    const anioFin = ultimoDia.getFullYear();
    const diasSemanaP = document.querySelectorAll('.dia p');
    diasSemanaP.forEach(dia => {
        if (window.innerWidth <= 700) {
            dia.textContent = dia.getAttribute('data-dia').charAt(0).toUpperCase();
        } else {
            dia.textContent = dia.getAttribute('data-dia');
        }
    });

    if (window.innerWidth <= 800) {
        if (mesInicio === mesFin) {
            rango.textContent = `${primerDia.toLocaleString("default", {month: "short"})} ${anioInicio}`;
        } else {
            if (anioFin === anioInicio) {
                rango.textContent = `${primerDia.toLocaleString("default", {month: "short"})} - ${ultimoDia.toLocaleString("default", {month: "short"})} ${anioFin}`;
            } else {
                rango.textContent = `${primerDia.toLocaleString("default", {month: "short"})} ${anioInicio} - ${ultimoDia.toLocaleString("default", {month: "short"})} ${anioFin}`;
            }
        }
    } else {

        if (mesInicio === mesFin) {
            rango.textContent = `${mesInicio} ${primerDia.getDate()} - ${ultimoDia.getDate()}, ${primerDia.getFullYear()}`;
        } else {
            if (anioFin === anioInicio) {
                rango.textContent = `${mesInicio} ${primerDia.getDate()} - ${mesFin} ${ultimoDia.getDate()}, ${primerDia.getFullYear()}`;
            } else {
                rango.textContent = `${mesInicio} ${primerDia.getDate()}, ${anioInicio} - ${mesFin} ${ultimoDia.getDate()}, ${anioFin}`;
            }
        }
    }


    const fechaHoy = new Date();

    fechaHoy.setHours(0, 0, 0, 0);
    primerDia.setHours(0, 0, 0, 0);
    const diaSemanaHoy = fechaHoy.getDay();

    diasSemana.forEach(dia => {
        dia.classList.remove("dia-actual");
    });

    if (fechaHoy >= primerDia && fechaHoy <= ultimoDia) {

        diasSemana.forEach((dia, index) => {
            if (index === diaSemanaHoy) {
                dia.classList.add("dia-actual");
            }
        });
    }
    for (let i = 0; i < 7; i++) {
        const divDia = document.createElement("div");
        const diaActual = new Date(fechaAct);
        diaActual.setDate(fechaAct.getDate() + i);

        diaActual.setHours(0, 0, 0, 0);

        divDia.className = "fecha";
        const buttonDia = document.createElement("button");
        buttonDia.className = "Btnfecha";
        buttonDia.classList.remove('fecha-seleccionada');
        buttonDia.textContent = diaActual.getDate();
        const fechaBusqueda = formatoFecha(diaActual);
        buttonDia.onclick = function () {
            buttonDia.classList.add('fecha-seleccionada');
            sessionStorage.setItem("fechaSeleccionada", fechaBusqueda);
            buscarFecha(fechaBusqueda);
        };

        if (fechaSeleccionadaSesion && fechaBusqueda === fechaSeleccionadaSesion) {
            buttonDia.classList.add('fecha-seleccionada');
        }

        if (
                diaActual.getTime() === fechaHoy.getTime()
                ) {
            divDia.classList.add("fecha-actual");
            buttonDia.classList.add("Btnfecha-actual");
        }
        divDia.appendChild(buttonDia);
        fechasCont.appendChild(divDia);
    }
}

btnPrevio.addEventListener("click", () => {
    fechaAct.setDate(fechaAct.getDate() - 7);
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    escribirFechas();
});

btnSig.addEventListener("click", () => {
    fechaAct.setDate(fechaAct.getDate() + 7);
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    escribirFechas();
});
btnHoy.addEventListener("click", () => {
    diaHoy = new Date();
    console.log(diaHoy);
    fechaAct = new Date();
    fechaAct.setDate(fechaAct.getDate() - fechaAct.getDay());
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    sessionStorage.setItem("fechaSeleccionada", fechaGuardada);
    buscarFecha(formatoFecha(diaHoy));
});
window.addEventListener('resize', escribirFechas);

escribirFechas();



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
    document.getElementById("noChildModal").style.display = "flex";  // Muestra el modal
}

function closeModal() {
    document.getElementById("noChildModal").style.display = "none";  // Oculta el modal
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
    // Realizar la petición AJAX para obtener la información del usuario
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "procesa_tutor_calendario.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Aquí puedes actualizar la sección de la página donde se muestran los hábitos
            document.getElementById("actCont").innerHTML = xhr.responseText;
        }
    };
    xhr.send("idKit=" + idKit);
}


// Obtén el modal
var modalCrearActividad = document.getElementById("modalCrearActividad");

// Obtén el botón que abre el modal
var btnCrearAct = document.getElementById("crearActBtn");

// Obtén el botón dentro del modal que lo cierra
var cerrarModalBtn = document.getElementById("cerrarModalBtn");

// Cuando el usuario hace clic en el botón, se abre el modal
btnCrearAct.onclick = function () {
    modalCrearActividad.style.display = "flex";
};

// Cuando el usuario hace clic en el botón de cerrar dentro del modal, se cierra
cerrarModalBtn.onclick = function () {
    modalCrearActividad.style.display = "none";
};


// Obtén el botón de cerrar
var cerrarModalBtn = document.getElementById("cerrarModalBtn");

// Obtén el modal
var modalCrearActividad = document.getElementById("modalCrearActividad");

// Al hacer clic en el botón de cerrar, evitar que envíe el formulario
cerrarModalBtn.onclick = function (event) {
    event.preventDefault(); // Prevenir que el botón cierre envíe el formulario
    modalCrearActividad.style.display = "none"; // Cerrar el modal
};

// El botón de "Crear" con tipo "submit" ya enviará el formulario al JSP


// Elementos del DOM
var iconDisplay = document.getElementById("iconDisplay");
var iconOptions = document.getElementById("iconOptions");
var selectedIcon = document.getElementById("selectedIcon");
var iconOptionImages = document.querySelectorAll(".icon-option");
var iconSrcInput = document.getElementById("iconSrcInput"); // Input oculto

// Mostrar/ocultar los íconos al hacer clic en el área de selección
iconDisplay.onclick = function () {
    iconOptions.style.display = iconOptions.style.display === "none" ? "block" : "none";
};

// Seleccionar un ícono y almacenar su ruta en el input oculto
iconOptionImages.forEach(function (icon) {
    icon.onclick = function () {
        var iconSrc = this.getAttribute("data-icon");
        selectedIcon.src = iconSrc; // Cambiar la imagen seleccionada
        iconSrcInput.value = iconSrc; // Guardar la ruta del ícono en el value del input oculto
        iconOptions.style.display = "none"; // Cerrar la lista de íconos
    };
});








// Elementos del DOM
var iconDisplay = document.getElementById("iconDisplay");
var iconOptions = document.getElementById("iconOptions");
var selectedIcon = document.getElementById("selectedIcon");
var iconSrcInput = document.getElementById("iconSrcInput"); // Input oculto
var colorDisplay = document.getElementById("colorDisplay"); // Esfera de color
var colorOptions = document.getElementById("colorOptions"); // Opciones de color
var colorOptionElements = document.querySelectorAll(".color-option"); // Elementos de color

var selectedIconName = ""; // Variable para almacenar el nombre del ícono seleccionado
var selectedColor = document.getElementById("selectedColorInput").value; // Variable para almacenar el color seleccionado (vacío por defecto)

// Inicializa el icono por defecto
updateColorChangeAbility();

// Mostrar/ocultar los íconos al hacer clic en el área de selección
iconDisplay.onclick = function () {
    iconOptions.style.display = iconOptions.style.display === "none" ? "block" : "none";
};

// Seleccionar un ícono y almacenar su nombre en el input oculto
var iconOptionImages = document.querySelectorAll(".icon-option");
iconOptionImages.forEach(function (icon) {
    icon.onclick = function () {
        selectedIconName = this.getAttribute("data-icon"); // Guardar el nombre del ícono

        // Construir la ruta del ícono según si hay color seleccionado
        var iconSrc = "";
        selectedColor = document.getElementById("selectedColorInput").value;
        if (selectedColor === "" || selectedColor === "black") {
            iconSrc = `../img/iconos_formularios/${selectedIconName}.png`;
        } else {
            iconSrc = `../img/iconos_formularios/${selectedIconName}-${selectedColor}.png`;
        }

        selectedIcon.src = iconSrc; // Cambiar la imagen seleccionada
        iconSrcInput.value = iconSrc; // Guardar la ruta del ícono en el value del input oculto

        // Habilitar o deshabilitar el cambio de color
        updateColorChangeAbility();

        iconOptions.style.display = "none"; // Cerrar la lista de íconos
    };
});

// Mostrar/ocultar las opciones de color al hacer clic en la esfera
colorDisplay.onclick = function () {
    // Verificar si el src del icono seleccionado es diferente del por defecto
    if (selectedIcon.src.includes("icono_selector_iconos.svg")) {
        // No abrir el menú de colores
        console.log("Menú de colores no se abre, ícono por defecto seleccionado.");
    } else {
        colorOptions.style.display = colorOptions.style.display === "none" ? "grid" : "none";
    }
};

// Cambiar el ícono seleccionado al seleccionar un color
colorOptionElements.forEach(function (colorOption) {
    colorOption.onclick = function () {
        // Verificar si el cambio de color es posible
        if (isColorChangeAllowed()) {
            selectedColor = this.getAttribute("data-color"); // Obtener el color seleccionado
            colorDisplay.style.backgroundColor = this.style.backgroundColor; // Cambiar la esfera de color

            // Construir la nueva ruta del ícono en función del ícono y color seleccionados
            var iconSrc;
            if (selectedColor === "black") {
                iconSrc = `../img/iconos_formularios/${selectedIconName}.png`; // Ruta del ícono sin color
            } else {
                iconSrc = `../img/iconos_formularios/${selectedIconName}-${selectedColor}.png`; // Ruta del ícono con color
            }
            selectedIcon.src = iconSrc;
            iconSrcInput.value = iconSrc;
            colorOptions.style.display = "none";
        }
    };
});

function updateColorChangeAbility() {
    var isDefaultIcon = selectedIcon.src.includes("icono_selector_iconos.svg");
    colorDisplay.style.pointerEvents = isDefaultIcon ? "none" : "auto";
    colorDisplay.style.opacity = isDefaultIcon ? "0.5" : "1";
}

function isColorChangeAllowed() {
    return !selectedIcon.src.includes("icono_selector_iconos.svg");
}




colorOptionElements.forEach(function (colorOption) {
    colorOption.onclick = function () {
        if (isColorChangeAllowed()) {
            selectedColor = this.getAttribute("data-color");
            colorDisplay.style.backgroundColor = this.style.backgroundColor;

            var iconSrc;
            if (selectedColor === "black") {
                iconSrc = `../img/iconos_formularios/${selectedIconName}.png`;
            } else {
                iconSrc = `../img/iconos_formularios/${selectedIconName}-${selectedColor}.png`;
            }
            selectedIcon.src = iconSrc;
            iconSrcInput.value = iconSrc;
            selectedColorInput.value = selectedColor;
            colorOptions.style.display = "none";
        }
    };
});


function toggleDropdown() {
    const dropdown = document.getElementById('dropdown-menu');
    dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
}

document.addEventListener('click', function (event) {
    const inputContainer = document.getElementById('input-container');
    console.log('inputContainer:', inputContainer); // Verifica su valor
    if (inputContainer && !inputContainer.contains(event.target)) {
        document.getElementById('dropdown-menu').style.display = 'none';
        ocultarSubmenus();
    }
});






document.querySelectorAll('.checkbox-group input[type="checkbox"]').forEach(checkbox => {
    checkbox.addEventListener('click', function (event) {
        event.stopPropagation();
        if (this.nextElementSibling && this.nextElementSibling.classList.contains('sublist')) {
            selectSubfilters(this, this.nextElementSibling);
        }
    });
});





function toggleDropdown2() {
    const dropdownMenu = document.getElementById('dropdown-menu-dia');
    dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
}

function toggleSubmenu(submenuId) {
    const submenu = document.getElementById(submenuId);
    if (submenu.style.display === 'block') {
        submenu.style.display = 'none';
    } else {
        const submenus = document.querySelectorAll('#dropdown-menu-dia > div');
        submenus.forEach(s => {
            if (s !== submenu) {
                s.style.display = 'none';
            }
        });
        submenu.style.display = 'block';
    }
}

function ocultarSubmenu(submenuId) {
    const submenu = document.getElementById(submenuId);
    if (submenu) {
        submenu.style.display = 'none';
    }
}


function clearInputIfContains(targetStrings) {
    const input = document.getElementById('main-input');
    const currentText = input.value;

    for (let i = 0; i < targetStrings.length; i++) {
        if (currentText.includes(targetStrings[i])) {
            const links = document.querySelectorAll('#dropdown-menu-dia a');
            for (let i = 0; i < links.length; i++) {
                links[i].style.backgroundColor = '';
            }
            const submenuLinks = document.querySelectorAll('#submenu-dia a');
            for (let i = 0; i < submenuLinks.length; i++) {
                submenuLinks[i].style.backgroundColor = '';
            }
            input.value = '';
            break;
        }
    }
}

function toggleDaySelection(day, element) {
    const input = document.getElementById('main-input');

    clearInputIfContains(['Cada', 'Repetir cada 2', 'Repetir cada 3', 'Repetir cada 4', 'Repetir cada 5', 'Repetir cada 6', 'Repetir cada 7']);
    const currentText = input.value;
    const daysArray = currentText.split(',');
    let dayFound = false;

    for (let i = 0; i < daysArray.length; i++) {
        daysArray[i] = daysArray[i].trim();
        if (daysArray[i] === day) {
            daysArray.splice(i, 1);
            dayFound = true;
            break;
        }
    }

    if (!dayFound) {
        daysArray.push(day);
    }

    let filteredDays = [];
    for (let i = 0; i < daysArray.length; i++) {
        if (daysArray[i]) {
            filteredDays.push(daysArray[i]);
        }
    }

    input.value = filteredDays.join(', ');

    if (dayFound) {
        element.style.backgroundColor = '';
    } else {
        element.style.backgroundColor = '#879FD4';
    }
}

function toggleMonthDaySelection(day, element) {
    const input = document.getElementById('main-input');

    clearInputIfContains(['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo', 'Repetir cada 1', 'Repetir cada 2', 'Repetir cada 3', 'Repetir cada 4', 'Repetir cada 5', 'Repetir cada 6', 'Repetir cada 7']);

    const currentText = input.value;

    const daysArray = currentText.split(',');
    let dayFound = false;

    for (let i = 0; i < daysArray.length; i++) {
        daysArray[i] = daysArray[i].trim();
        if (daysArray[i] === `Cada mes el día ${day}`) {
            daysArray.splice(i, 1);
            dayFound = true;
            break;
        }
    }

    if (!dayFound) {
        daysArray.push(`Cada mes el día ${day}`);
    }

    const filteredDays = [];
    for (let i = 0; i < daysArray.length; i++) {
        if (daysArray[i]) {
            filteredDays.push(daysArray[i]);
        }
    }

    input.value = filteredDays.join(', ');

    if (dayFound) {
        element.style.backgroundColor = '';
    } else {
        element.style.backgroundColor = '#879FD4';
    }

    actualizarFechaFinalDiasMes();

}


function toggleIntervalSelection2(interval, element) {
    const input = document.getElementById('main-input');
    clearInputIfContains(['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo', 'Cada']);

    const links = document.querySelectorAll('#submenu-intervalos a');
    links.forEach(link => {
        link.style.backgroundColor = '';
    });

    input.value = interval;

    element.style.backgroundColor = '#6f85b3';
    actualizarFechaFinal();
}
function mostrarSubmenu(submenuId) {
    const submenu = document.getElementById(submenuId);
    submenu.style.display = submenu.style.display === 'none' ? 'block' : 'none';
}

document.addEventListener('click', function (event) {
    const dropdown = document.getElementById('dropdown-menu-dia');
    const mainInput = document.getElementById('main-input');

    // Verificar si el clic ocurrió fuera del menú o submenús
    if (!mainInput.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.classList.remove('show');

        // Cerrar todos los submenús
        const submenus = document.querySelectorAll('.submenu');
        submenus.forEach(submenu => submenu.classList.remove('show'));
    }
});


function showToast() {
    const toast = document.getElementById("toast");
    toast.style.display = "block";
    setTimeout(() => {
        toast.style.display = "none";
    }, 7000);
}

// Función de validación
function validateTime() {
    const horaInicio = document.getElementById("hora-inicio").value;
    const horaFinal = document.getElementById("hora-final").value;

    // Si ambas horas están seleccionadas
    if (horaInicio && horaFinal) {
        // Convertir horas a minutos para comparación
        const [startHours, startMinutes] = horaInicio.split(':').map(Number);
        const [endHours, endMinutes] = horaFinal.split(':').map(Number);

        const startTimeInMinutes = startHours * 60 + startMinutes;
        const endTimeInMinutes = endHours * 60 + endMinutes;

        // Comparar las horas
        if (endTimeInMinutes <= startTimeInMinutes) {
            showToast(); // Mostrar el toast
            // Limpiar los inputs
            document.getElementById("hora-inicio").value = '';
            document.getElementById("hora-final").value = '';
        }
    }
}

// Añadir los eventos de cambio
document.getElementById("hora-inicio").addEventListener("change", validateTime);
document.getElementById("hora-final").addEventListener("change", validateTime);



window.onload = function () {
    const calendario_inicial = document.getElementById('mi-calendario-inicial');
    const calendario_final = document.getElementById('mi-calendario-final');


    const ayer = new Date();
    ayer.setDate(ayer.getDate() - 1);
    const hoyInicial = ayer.toISOString().split('T')[0];
    const mañana = new Date();
    mañana.setDate(mañana.getDate());

    const hoyFinal = mañana.toISOString().split('T')[0];

    calendario_inicial.setAttribute('min', hoyInicial);
    calendario_final.setAttribute('min', hoyFinal);
    console.log();
};

window.onload = function () {
    const inputFechaInicial = document.getElementById('mi-calendario-inicial');
    const calendario_final = document.getElementById('mi-calendario-final');

    const hoy = new Date();

    const fechaHoy = hoy.toISOString().split('T')[0];
    inputFechaInicial.value = fechaHoy;


    const hoy2 = new Date();
    hoy2.setDate(hoy2.getDate());
    const hoyInicial = hoy2.toISOString().split('T')[0];
    const mañana = new Date();
    mañana.setDate(mañana.getDate());

    const hoyFinal = mañana.toISOString().split('T')[0];

    inputFechaInicial.setAttribute('min', hoyInicial);
    calendario_final.setAttribute('min', hoyFinal);
};



function showToastCalendar() {
    const toast2 = document.getElementById("toast-calendario");
    toast2.style.display = "block";
    setTimeout(() => {
        toast2.style.display = "none";
    }, 7000);
}

function validateDate() {
    const calendario_inicial = document.getElementById('mi-calendario-inicial');
    const calendario_final = document.getElementById('mi-calendario-final');

    if (calendario_inicial.value && calendario_final.value) {
        const fechaInicial = new Date(calendario_inicial.value);
        const fechaFinal = new Date(calendario_final.value);

        if (fechaFinal <= fechaInicial) {
            showToastCalendar();
            calendario_final.value = '';
        }
    }
    console.log();
}

document.getElementById('mi-calendario-inicial').addEventListener('input', validateDate);
document.getElementById('mi-calendario-final').addEventListener('input', validateDate);





document.addEventListener("DOMContentLoaded", function () {
    var textarea = document.getElementById("info-extra");
    var contador = document.getElementById("charCount");

    textarea.addEventListener("input", function () {
        var contenido = textarea.value;
        var caracteresEscritos = contenido.length;
        var limiteCaracteres = 400;
        if (caracteresEscritos >= limiteCaracteres) {
            textarea.value = textarea.value.substring(0, limiteCaracteres);
            caracteresEscritos = limiteCaracteres;
        }
        contador.textContent = caracteresEscritos + "/" + limiteCaracteres + " caracteres";
    });
});





// Función para ocultar los menús y submenús
function ocultarMenus() {
    const dropdownMenu = document.getElementById('dropdown-menu-dia');
    const submenuMensual = document.getElementById('submenu-mensual');
    const submenuIntervalos = document.getElementById('submenu-intervalos');

    dropdownMenu.style.display = 'none';
    submenuMensual.style.display = 'none';
    submenuIntervalos.style.display = 'none';
}

// Verifica si el mouse está sobre alguna de las opciones o submenús
function isMouseOutsideAll(event) {
    const optionDia = document.getElementById('option-dia');
    const optionMensual = document.getElementById('option-mensual');
    const optionIntervalos = document.getElementById('option-intervalos');
    const dropdownMenu = document.getElementById('dropdown-menu-dia');
    const submenuMensual = document.getElementById('submenu-mensual');
    const submenuIntervalos = document.getElementById('submenu-intervalos');

    return !optionDia.contains(event.relatedTarget) &&
            !optionMensual.contains(event.relatedTarget) &&
            !optionIntervalos.contains(event.relatedTarget) &&
            !dropdownMenu.contains(event.relatedTarget) &&
            !submenuMensual.contains(event.relatedTarget) &&
            !submenuIntervalos.contains(event.relatedTarget);
}

// Eventos de mouseenter y mouseleave para las opciones y menús
document.getElementById('option-dia').addEventListener('mouseenter', function () {
    document.getElementById('dropdown-menu-dia').classList.add('show');
});

document.getElementById('option-dia').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});

document.getElementById('option-mensual').addEventListener('mouseenter', function () {
    document.getElementById('submenu-mensual').classList.add('show');
});

document.getElementById('option-mensual').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});

document.getElementById('option-intervalos').addEventListener('mouseenter', function () {
    document.getElementById('submenu-intervalos').classList.add('show');
});

document.getElementById('option-intervalos').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});

document.getElementById('dropdown-menu-dia').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});

document.getElementById('submenu-mensual').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});

document.getElementById('submenu-intervalos').addEventListener('mouseleave', function (event) {
    if (isMouseOutsideAll(event)) {
        ocultarMenus();
    }
});









function validateNombreHabito() {
    const inputNombreHabito = document.getElementById('nombreHabito');
    const errorSpan = document.getElementById('nombreHabitoError');

    const nombreHabito = inputNombreHabito.value.trim();

    if (nombreHabito === "" || nombreHabito.length < 3 || nombreHabito === null) {
        errorSpan.style.display = 'block';
        inputNombreHabito.classList.add('input-error'); // Agregar clase para resaltar el error
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputNombreHabito.classList.remove('input-error'); // Quitar clase de error si existía
        return true;
    }
}

document.getElementById('nombreHabito').addEventListener('input', validateNombreHabito);


function validateRecompensa() {
    const inputRecompensa = document.getElementById('recompensaActividad');
    const errorSpan = document.getElementById('errorRecompensa');

    const recompensaNumero = parseInt(inputRecompensa.value, 10); // Usar .value para obtener el valor del input

    // Validar si el número está fuera del rango
    if (isNaN(recompensaNumero) || recompensaNumero > 100 || recompensaNumero <= 0) {
        errorSpan.style.display = 'block'; // Mostrar el mensaje de error
        inputRecompensa.classList.add('input-error'); // Agregar clase para resaltar el error
        return false;
    } else {
        errorSpan.style.display = 'none'; // Ocultar el mensaje de error
        inputRecompensa.classList.remove('input-error'); // Quitar clase de error si existía
        return true;
    }
}

// Validación en tiempo real mientras el usuario escribe
document.getElementById('recompensaActividad').addEventListener('input', validateRecompensa);



function validateTipo() {
    const inputTipo = document.getElementById('opciones');
    const errorSpan = document.getElementById('errorTipo');

    const textoTipo = inputTipo.value.trim();

    if (inputTipo.selectedIndex === 0) {
        errorSpan.style.display = 'block';
        inputTipo.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputTipo.classList.remove('input-error');
        return true;
    }
}


function validateRepeticiones() {
    const inputRepeticiones = document.getElementById('main-input');
    const errorSpan = document.getElementById('errorIntervalos');

    if (inputRepeticiones === "" || inputRepeticiones === null || inputRepeticiones.value === "") {
        errorSpan.style.display = 'block';
        return false;
    } else {
        errorSpan.style.display = 'none';
        return true;
    }
}

function validateHoraInicial() {
    const inputHora = document.getElementById('hora-inicio');
    const errorSpan = document.getElementById('errorHoraInicio');

    if (inputHora === "" || inputHora === null || inputHora.value === "") {
        errorSpan.style.display = 'block';
        inputHora.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputHora.classList.remove('input-error');
        return true;
    }
}

function validateHoraFinal() {
    const inputHora = document.getElementById('hora-final');
    const errorSpan = document.getElementById('errorHoraFinal');

    if (inputHora === "" || inputHora === null || inputHora.value === "") {
        errorSpan.style.display = 'block';
        inputHora.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputHora.classList.remove('input-error');
        return true;
    }
}

function validateFechaInicial() {
    const inputFecha = document.getElementById('mi-calendario-inicial');
    const errorSpan = document.getElementById('errorFechaInicial');

    if (inputFecha === "" || inputFecha === null || inputFecha.value === "") {
        errorSpan.style.display = 'block';
        inputFecha.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputFecha.classList.remove('input-error');
        return true;
    }
    console.log();
}

function validateFechaFinal() {
    const inputFecha = document.getElementById('mi-calendario-final');
    const errorSpan = document.getElementById('errorFechaFinal');

    if (inputFecha === "" || inputFecha === null || inputFecha.value === "") {
        errorSpan.style.display = 'block';
        inputFecha.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputFecha.classList.remove('input-error');
        return true;
    }
}

function validateInfoExtra() {
    const inputInfoExtra = document.getElementById('info-extra');
    const errorSpan = document.getElementById('errorInfoExtra');

    if (inputInfoExtra === "" || inputInfoExtra === null || inputInfoExtra.value === "") {
        errorSpan.style.display = 'block';
        inputInfoExtra.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputInfoExtra.classList.remove('input-error');
        return true;
    }
}








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
const containerDiv = document.querySelector('.input-nombre-habito-container');

optionsDiv.addEventListener('mouseenter', function () {
    optionsDiv.style.display = 'block'; // Mantener visible al pasar el mouse
});

optionsDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none'; // Ocultar al salir
});

containerDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none'; // Ocultar si el mouse sale del contenedor
});

window.addEventListener('click', function (event) {
    if (!containerDiv.contains(event.target)) {
        optionsDiv.style.display = 'none'; // Ocultar si se hace clic fuera del contenedor
    }
});

function actualizarFechaFinalDiasMes() {
    let fechaInicial = document.getElementById('mi-calendario-inicial').value;
    const diasMesSeleccionadosRaw = document.getElementById('main-input').value;
    const diasMesSeleccionados = [];

    const diasArray = diasMesSeleccionadosRaw.split(',');
    for (let i = 0; i < diasArray.length; i++) {
        const partes = diasArray[i].trim().split(' ');
        const dia = parseInt(partes[partes.length - 1]);
        if (!isNaN(dia)) {
            diasMesSeleccionados.push(dia);
        }
    }

    if (!fechaInicial) {
        const hoy = new Date();
        fechaInicial = hoy.toISOString().split('T')[0];
        document.getElementById('mi-calendario-inicial').value = fechaInicial;
        console.log();
    }

    const fechaInicialDate = new Date(fechaInicial);
    let diasTotales = 0;
    let fechaFinal = new Date(fechaInicialDate);

    while (diasTotales < 21) {
        const mesActual = fechaFinal.getMonth();
        let mesContado = false;
        let diasValidos = [];

        for (let i = 0; i < diasMesSeleccionados.length; i++) {
            const day = diasMesSeleccionados[i];
            const fechaComprobacion = new Date(fechaFinal.getFullYear(), mesActual, day);

            // Solo contar si el día es válido para el mes actual y no es posterior a la fecha inicial
            if (fechaComprobacion.getMonth() === mesActual && fechaComprobacion >= fechaInicialDate) {
                diasValidos.push(fechaComprobacion);
            }
        }

        // Ordenar días válidos en orden ascendente
        diasValidos.sort((a, b) => a - b);

        // Evaluar si se pueden contar hasta 21 días
        for (let validDate of diasValidos) {
            if (diasTotales < 21) {
                diasTotales++;
                fechaFinal = validDate; // Actualizar fechaFinal al día válido
            }
        }

        // Si no contamos días de este mes, avanzar al siguiente mes
        if (diasValidos.length === 0 || diasTotales < 21) {
            fechaFinal.setMonth(fechaFinal.getMonth() + 1);
            fechaFinal.setDate(1); // Reiniciar al primer día del nuevo mes
        }
    }

    const fechaFinalFormato = fechaFinal.toISOString().split('T')[0]; // Formato YYYY-MM-DD
    document.getElementById('mi-calendario-final').value = fechaFinalFormato; // Actualizar el input de fecha final
    document.getElementById('mi-calendario-final').setAttribute('min', fechaFinalFormato);
}

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('mi-calendario-inicial').addEventListener('change', function () {
        const inputIntervalos = document.getElementById('main-input').value;
        if (inputIntervalos) {
            actualizarFechaFinalDiasSemana();
        }
    });
});

function actualizarFechaFinalDiasSemana() {
    let fechaInicial = document.getElementById('mi-calendario-inicial').value;
    const diasSeleccionadosRaw = document.getElementById('main-input').value.split(',');
    const diasSeleccionados = [];

    // Procesar los días seleccionados
    for (let i = 0; i < diasSeleccionadosRaw.length; i++) {
        diasSeleccionados.push(diasSeleccionadosRaw[i].trim());
    }

    if (!fechaInicial) {
        const hoy = new Date();
        fechaInicial = hoy.toISOString().split('T')[0];
        document.getElementById('mi-calendario-inicial').value = fechaInicial;
    }

    const fechaInicialDate = new Date(fechaInicial);
    const diasDeLaSemana = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
    let diasTotales = 0;
    let fechaFinal = new Date(fechaInicialDate);

    while (diasTotales < 20) {
        const diaActual = diasDeLaSemana[fechaFinal.getDay()];

        if (diasSeleccionados.includes(diaActual)) {
            diasTotales++;
        }

        fechaFinal.setDate(fechaFinal.getDate() + 1);
    }

    const nuevaFechaFinal = fechaFinal.toISOString().split('T')[0];
    document.getElementById('mi-calendario-final').value = nuevaFechaFinal;
    document.getElementById('mi-calendario-final').setAttribute('min', nuevaFechaFinal);

    console.log("Fecha final calculada:", nuevaFechaFinal); // Para verificar
}






function actualizarFechaFinal() {
    let fechaInicial = document.getElementById('mi-calendario-inicial').value;
    const intervaloSeleccionado = document.getElementById('main-input').value;

    if (!fechaInicial) {
        // Si no hay fecha inicial, se usa la fecha actual
        const hoy = new Date();
        fechaInicial = hoy.toISOString().split('T')[0];
        document.getElementById('mi-calendario-inicial').value = fechaInicial;
    }
    console.log();
    const fechaInicialDate = new Date(fechaInicial);
    let diasTotales;

    // Calcula los días totales basados en el intervalo seleccionado
    switch (intervaloSeleccionado) {
        case 'Diariamente':
            diasTotales = 20;  // 21 días - 1 para incluir el primer día
            break;
        case 'Repetir cada 2':
            diasTotales = (21 * 2) - 1;
            break;
        case 'Repetir cada 3':
            diasTotales = (21 * 3) - 1;
            break;
        case 'Repetir cada 4':
            diasTotales = (21 * 4) - 1;
            break;
        case 'Repetir cada 5':
            diasTotales = (21 * 5) - 1;
            break;
        case 'Repetir cada 7':
            diasTotales = (21 * 7) - 1;
            break;
        default:
            return;
    }

    fechaInicialDate.setDate(fechaInicialDate.getDate() + diasTotales);
    const nuevaFechaFinal = fechaInicialDate.toISOString().split('T')[0];

    document.getElementById('mi-calendario-final').value = nuevaFechaFinal;

    document.getElementById('mi-calendario-final').setAttribute('min', nuevaFechaFinal);
}

document.querySelectorAll('#submenu-intervalos a').forEach(function (element) {
    element.addEventListener('click', function () {
        document.getElementById('main-input').value = this.innerText;
        document.querySelectorAll('#submenu-intervalos a').forEach(function (link) {
            link.classList.remove('a-seleccionado');
            link.classList.add('a-no-seleccionado');
        });


        this.classList.add('a-seleccionado');
        this.classList.remove('a-no-seleccionado');

        actualizarFechaFinal();
    });
});

document.querySelectorAll('#submenu-dia a').forEach(function (element) {
    element.addEventListener('click', function () {
        actualizarFechaFinalDiasSemana();
    });
});


//Corregir esto
document.getElementById('mi-calendario-inicial').addEventListener('change', function () {
    var inputIntervalos = document.getElementById('main-input').value.trim();

    if (inputIntervalos) {
        // Verifica si la cadena contiene palabras específicas
        if (inputIntervalos.includes('Lunes') || inputIntervalos.includes('Martes') || inputIntervalos.includes('Miércoles') || inputIntervalos.includes('Jueves') || inputIntervalos.includes('Viernes') || inputIntervalos.includes('Sábado') || inputIntervalos.includes('Domingo')) {
            actualizarFechaFinal(); // Llama a la función para 'Diariamente'
        } else if (inputIntervalos.includes('Cada mes')) {
            actualizarFechaFinalDiasSemana(); // Llama a la función para días de la semana
        } else if (inputIntervalos.includes('Repetir')) {
            actualizarFechaFinalDiasMes(); // Llama a la función para el mes
        } else {
            console.log("Intervalo no reconocido: " + inputIntervalos);
        }
    }
});






function toggleIntervalSelection(intervalo, element) {
    const opciones = document.querySelectorAll('#submenu-intervalos a');
    opciones.forEach(opcion => opcion.classList.remove('selected'));
    element.classList.add('selected');

    calcularFechaFinalPorIntervalo(intervalo);
}


//   --rojoIcono:#FF595E;
//    --amarilloIcono:#FFCA3A;
//    --verdeIcono:#8AC926;
//    -azulIcono:#1982C4;
//    --moradoIcono:#6A4C93;


const habitosData = {
    "Comer frutas y verduras": {
        icon: "../img/iconos_formularios/gato-azul.png",
        color: "#1982C4",
        colorInput: "azul",
        recompensas: 30,
        tipo: "Salud",
        repeticiones: "Lunes, Martes, Miércoles, Jueves, Viernes, Sábado, Domingo",
        info: "Recuerda llevar una alimentación saludable incluyendo frutas y verduras, no olvídes que poco a poco lograremos grandes cosas, te quiero mucho."
    }

};

// Función para llenar el formulario
function llenarForm(habito) {
    console.log("Valor de habito:", habito);
    const habitosData = {
        "Comer frutas y verduras": {
            icon: "../img/iconos_formularios/pera-verde.png",
            color: "#8AC926",
            colorInput: "verde",
            recompensas: 30,
            tipo: "Salud",
            repeticiones: "Lunes, Martes, Miércoles, Jueves, Viernes, Sábado, Domingo",
            info: "Recuerda llevar una alimentación saludable incluyendo frutas y verduras, no olvídes que poco a poco lograremos grandes cosas, te quiero mucho."
        },
        "Beber agua": {
            icon: "../img/iconos_formularios/agua-azul.png",
            color: "#1982C4",
            colorInput: "azul",
            recompensas: 20,
            tipo: "Salud",
            repeticiones: "Lunes, Martes, Miércoles, Jueves, Viernes, Sábado, Domingo",
            info: "Recuerda hidratarte constantemente"
        },
        "Hacer ejercicio": {
            icon: "../img/iconos_formularios/pesa-rojo.png",
            color: "#FF595E",
            colorInput: "rojo",
            recompensas: 50,
            tipo: "Salud",
            repeticiones: "Lunes, Miércoles, Viernes, Domingo",
            info: "Hacer ejercicio es una parte importante para tu salud, los ejercicios trata de buscar unos acorde a tu edad, tú puedes."
        }
    };

    const data = habitosData[habito];

    if (!data) {
        console.error(`El hábito "${habito}" no existe en habitosData.`);
        return;
    }

    if (data) {
        document.getElementById('nombreHabito').value = habito;
        document.getElementById('iconSrcInput').value = data.icon;
        document.getElementById('selectedIcon').src = data.icon;
        document.getElementById('selectedColorInput').src = data.icon;
        document.getElementById('colorDisplay').style.backgroundColor = data.color;
        document.getElementById('selectedColorInput').value = data.colorInput;
        document.getElementById('recompensaActividad').value = data.recompensas;
        document.getElementById('opciones').value = data.tipo;
        document.getElementById('main-input').value = data.repeticiones;
        document.getElementById('info-extra').value = data.info;
    }
}

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

let idActividadActual = null;

function actualizarVista(contenido) {
    const modal = document.getElementById("infoModal");
    const modalContent = document.getElementById("info-actContent");
    const infoActContent = document.getElementById("info-seleccionada");

    if (window.innerWidth <= 700) {

        modalContent.innerHTML = contenido;
        modal.style.display = "flex";
        infoActContent.innerHTML = "";
        infoActContent.classList.remove("info-actContent-mostrando");
    } else {
        infoActContent.classList.add("info-actContent-mostrando");
        infoActContent.innerHTML = contenido;
        modal.style.display = "none"; 
    }
}

function mostrarInfo(idActividad) {
    const actividad = actividades[idActividad];
    idActividadActual = idActividad;

    if (actividad) {
        const infoActContent = document.getElementById("info-seleccionada");
        const [horas, minutos] = actividad.horaInicio.split(":");
        const horaInicio = `${horas}:${minutos}`;
        const [horas2, minutos2] = actividad.horaFin.split(":");
        const horaFin = `${horas2}:${minutos2}`;
        
        // Crear el contenido de la información
        const contenido = `
            <img src="${actividad.imagen}" class="imgIconoActividad">
            <h3>${actividad.nombre}</h3>
            <div class="actividad-ramitas-horas">
                <div class="actividad-despleada-ramitas">
                    <div class="cont-img-icono-ramita-num-ramitas">
                        <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                    </div>
                    <div>
                        <label id="text-num-ramitas-despl-acti">${actividad.ramitas} Ramitas</label>
                    </div>
                </div>
                <div class="actividad-desplegada-horas">
                    <p>${horaInicio} - ${horaFin}</p>
                </div>
            </div>
            <div class="descAct">
            <p>${actividad.infoExtra}</p>
            </div>
        `;
        actualizarVista(contenido);
        
    } 
}

const modal = document.getElementById("infoModal");
window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
const btnCerrarInfo = document.getElementById("cerrarModal");
btnCerrarInfo.addEventListener("click", function () {
        modal.style.display = "none";
});

window.addEventListener("resize", function () {
        if (idActividadActual !== null) {
            const actividad = actividades[idActividadActual];
            const contenido = `
                <img src="${actividad.imagen}" class="imgIconoActividad">
                <h3>${actividad.nombre}</h3>
                <div class="actividad-ramitas-horas">
                    <div class="actividad-despleada-ramitas">
                        <div class="cont-img-icono-ramita-num-ramitas">
                            <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                        </div>
                        <div>
                            <label id="text-num-ramitas-despl-acti">${actividad.ramitas} Ramitas</label>
                        </div>
                    </div>
                    <div class="actividad-desplegada-horas">
                        <p>${actividad.horaInicio.split(":").slice(0, 2).join(":")} - ${actividad.horaFin.split(":").slice(0, 2).join(":")}</p>
                    </div>
                </div>
                <div class="descAct">
                <p>${actividad.infoExtra}</p>
                </div>
            `;
            actualizarVista(contenido);
        }
    });

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('formulario-nuevo-habito').addEventListener('submit', function (event) {
        let valid = true;

        if (!validateNombreHabito()) {
            valid = false;
        }

        if (!validateIconSrcInput()) {
            valid = false;
        }

        if (!validateRecompensa()) {
            valid = false;
        }

        if (!validateColorValue()) {
            valid = false;
        }
        if (!validateTipo()) {
            valid = false;
        }
        if (!validateRepeticiones()) {
            valid = false;
        }
        if (!validateHoraInicial()) {
            valid = false;
        }
        if (!validateHoraFinal()) {
            valid = false;
        }
        if (!validateFechaInicial()) {
            valid = false;
        }
        if (!validateFechaFinal()) {
            valid = false;
        }
        if (!validateInfoExtra()) {
            valid = false;
        }
        if (!valid) {
            event.preventDefault();
        }
    });
}
);