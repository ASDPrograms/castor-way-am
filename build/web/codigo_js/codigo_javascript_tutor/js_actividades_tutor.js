const toggleButton = document.querySelector('.toggle');
const sidebar = document.querySelector('.sidebar');
const logo = document.getElementById('iconoNavLogo');

toggleButton.addEventListener('click', () => {
    sidebar.classList.toggle('collapsed');
    if (sidebar.classList.contains('collapsed')) {
        logo.src = '../img/icono_azul_logo.svg';
    } else {
        logo.src = '../img/logo_letras_castorway.svg';
    }

});


function abrirModal() {
    sessionStorage.setItem("modalEstado", "abierto");
    console.log("Abriendo");
    document.getElementById("modalActividadSeleccionadaInfo").style.display = "flex";
}

function cerrarModal() {
    sessionStorage.setItem("modalEstado", "cerrado");
    document.getElementById("modalActividadSeleccionadaInfo").style.display = "none";
}
console.log("Estado guardado en sessionStorage: " + sessionStorage.getItem("modalEstado"));
console.log(sessionStorage.getItem("modalEstado") === "abierto");

document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("modalActividadSeleccionadaInfo");
    if (sessionStorage.getItem("modalEstado") === "abierto") {
        console.log("Abriendo modal desde sessionStorage");
        modal.style.display = "flex";
    } else {
        console.log("cerrando modal desde sessionStorage");
        modal.style.display = "none";
    }
});




const activeFilters = new Set();
const opcionesMenu = document.querySelector('.opciones-menu');

function openMenu() {
    document.getElementById("opciones-menu").style.display = "block";
}

function closeMenu() {
    document.getElementById("opciones-menu").style.display = "none";
}

function clearFilters() {
    const checkboxes = document.querySelectorAll('.checkbox-group input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = false;
    });

    const numInput = document.getElementById('recompensaActividadFilt');
    if (numInput) {
        numInput.value = '';
    }

    const dateInputs = document.querySelectorAll('#opciones-menu input[type="date"]');
    dateInputs.forEach(input => {
        input.value = '';
    });

    const selectElements = document.querySelectorAll('#filtros-lista select');
    selectElements.forEach(select => {
        select.selectedIndex = 0;
    });

    activeFilters.clear();

    const filtrosLista = document.getElementById('filtros-lista');

    buscarActividades();
    filtrarPorTipo();
    filtrarPorNumRamitas();
}


function updateFilters(filtro, checkbox) {
    if (checkbox.checked) {
        activeFilters.add(filtro);
    } else {
        activeFilters.delete(filtro);
    }
}

function saveFilters() {
    const filtrosLista = document.getElementById('filtros-lista');
    filtrosLista.innerHTML = '';

    activeFilters.forEach(filtro => {
        const nuevoFiltro = document.createElement('li');
        nuevoFiltro.textContent = filtro;
        filtrosLista.appendChild(nuevoFiltro);
    });
}

function selectSubfilters(checkbox, sublist) {
    const subCheckboxes = sublist.querySelectorAll('input[type="checkbox"]');
    subCheckboxes.forEach(subCheckbox => {
        subCheckbox.checked = checkbox.checked;
        updateFilters(subCheckbox.nextElementSibling.textContent, subCheckbox);
    });
}

document.querySelectorAll('.checkbox-group input[type="checkbox"]').forEach(checkbox => {
    checkbox.addEventListener('click', function (event) {
        event.stopPropagation();
        if (this.nextElementSibling && this.nextElementSibling.classList.contains('sublist')) {
            selectSubfilters(this, this.nextElementSibling);
        }
    });
});

function desplegarBurbujas() {
    var contenedor = document.getElementById("burbujasDesp");
    if (contenedor.style.display === "none" || contenedor.style.display === "") {
        contenedor.style.display = "block";
        contenedor.style.opacity = "0";
        setTimeout(function () {
            contenedor.style.opacity = "1";
        }, 10);
    } else {
        contenedor.style.opacity = "0";
        setTimeout(function () {
            contenedor.style.display = "none";
        }, 300);
    }
}


function addNewDiv() {
    var container = document.querySelector('.container');
    var clone = container.cloneNode(true);

    var button = clone.querySelector('.button-overlay');
    if (button) {
        button.remove();
    }

    var containerWrapper = document.getElementById('container-wrapper');
    containerWrapper.appendChild(clone);
}


function openModal() {
    document.getElementById("noChildModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("noChildModal").style.display = "none";
}


function toggleBurbujas() {
    var burbujasEscondidas = document.querySelectorAll(".burbujas-escondidas");

    burbujasEscondidas.forEach(function (burbuja) {
        if (burbuja.style.display === "none" || burbuja.style.display === "") {
            burbuja.style.display = "flex";
        } else {
            burbuja.style.display = "none";
        }
    });

    var burbujasEscondidasTd = document.querySelectorAll("td#td-burbujas-escondidas");

    burbujasEscondidasTd.forEach(function (burbujaTd) {
        if (burbujaTd.style.display === "none" || burbujaTd.style.display === "") {
            burbujaTd.style.display = "table-cell";
        } else {
            burbujaTd.style.display = "none";
        }
    });
}


function cambiarUsuario(idKit) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "procesa_tutor_actividades.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById("seccion-habitos").innerHTML = xhr.responseText;
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
        formulario.action = "formulario_procesa_tutor_actividades.jsp";
        btnMandarFormuActi.textContent = "Crear";
        tituloModal.textContent = "Nuevo hábito";
        formulario.reset();
        modalCrearActividad.style.display = "block";
        modalCrearActividad.style.display = "flex";
        modalCrearActividad.style.backgroundColor = "#F7B9A2";

        imagen.src = "../img/iconos_formularios/icono_selector_iconos.svg";
    };
}

if (btnEditarAct !== null) {
    btnEditarAct.onclick = function () {
        formulario.action = "formulario_actualiza_tutor_actividades.jsp";

        tituloModal.textContent = "Editar hábito";
        btnMandarFormuActi.textContent = "Editar";

        document.getElementById("nombreHabito").value = document.getElementById("nombreHabitoDisplay").innerText;
        document.getElementById("nombreHabito").value = document.getElementById("nombreHabitoDisplay").innerText;
        imagen.src = document.getElementById("rutaImagenHabitoDisplay").innerText;
        document.getElementById("iconSrcInput").value = document.getElementById("rutaImagenHabitoDisplay").innerText;
        var color = document.getElementById("colorDisplayDesplegadoInfo").innerText;
        var colorCod = "azul";

        if (color === "azul") {
            colorCod = "#1982C4";
        } else if (color === "rojo") {
            colorCod = "#FF595E";
        } else if (color === "amarillo") {
            colorCod = "#FFCA3A";
        } else if (color === "verde") {
            colorCod = "#8AC926";
        } else if (color === "morado") {
            colorCod = "#6A4C93";
        }
        document.getElementById("selectedColorInput").value = color;
        document.getElementById("colorDisplay").style.backgroundColor = colorCod;
        document.getElementById("recompensaActividad").value = document.getElementById("numRamitasDisplay").innerText;
        document.getElementById("opciones").value = document.getElementById("tipoHabitoDisplay").innerText;
        document.getElementById("main-input").value = document.getElementById("repeticionesDisplay").innerText;
        console.log("horaFinHabitoDisplay:", document.getElementById("horaFinHabitoDisplay"));
        console.log("Texto en horaFinHabitoDisplay:", document.getElementById("horaFinHabitoDisplay").innerText);
        console.log("Texto en horaFinHabitoDisplay:", document.getElementById("horaFinHabitoDisplay").textContent);




        var horaInicioDisplay = document.getElementById("horaInicioHabitoDisplay").innerText;
        var horaInicioInput = document.getElementById("hora-inicio");
        if (horaInicioDisplay) {
            var [horas, minutos] = horaInicioDisplay.split(':').slice(0);
            horaInicioInput.value = `${horas}:${minutos}`;

        } else {
            console.log("El elemento horaInicioHabitoDisplay no tiene un valor válido.");
        }

        var horaFinDisplay = document.getElementById("horaFinHabitoDisplay").innerText;
        var horaFinInput = document.getElementById("hora-final");
        if (horaFinDisplay) {
            var [horas, minutos] = horaFinDisplay.split(':').slice(0);
            horaFinInput.value = `${horas}:${minutos}`;

        } else {
            console.log("El elemento horaFinHabitoDisplay no tiene un valor válido.");
        }

        document.getElementById('mi-calendario-inicial').value = document.getElementById('diaInicioHabitoDisplay').innerText;
        document.getElementById('mi-calendario-final').value = document.getElementById('diaMetaHabitoDisplay').innerText;
        document.getElementById('info-extra').value = document.getElementById('infoExtraHabitoDisplay').innerText;


        modalCrearActividad.style.display = "block";
        modalCrearActividad.style.display = "flex";
        modalCrearActividad.style.backgroundColor = "#FFDF9B";

        var estadoTexto = document.getElementById("estadoTextoSpan").innerText;
        var estadoDiv = document.getElementById("estadoActividadDiv");

        if (estadoTexto === "2") {
            estadoTexto.value = "Completado";
        } else if (estadoTexto === "0") {
            estadoTexto.value = "En proceso";
        } else if (estadoTexto === "1") {
            estadoTexto.value = "Sin terminar";
        } else {
            estadoTexto.value = "Estado desconocido";
        }
        document.getElementById('estadoTextoSpan').innerText = estadoTexto;

        document.getElementById('idActividadEditarActividad').value = document.getElementById('idActividadDisplay').innerText;
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


var iconDisplay = document.getElementById("iconDisplay");
var iconOptions = document.getElementById("iconOptions");
var selectedIcon = document.getElementById("selectedIcon");
var iconOptionImages = document.querySelectorAll(".icon-option");
var iconSrcInput = document.getElementById("iconSrcInput");

iconDisplay.onclick = function () {
    iconOptions.style.display = iconOptions.style.display === "none" ? "block" : "none";
};

iconOptionImages.forEach(function (icon) {
    icon.onclick = function () {
        var iconSrc = this.getAttribute("data-icon");
        selectedIcon.src = iconSrc;
        iconSrcInput.value = iconSrc;
        iconOptions.style.display = "none";
    };
});








var iconDisplay = document.getElementById("iconDisplay");
var iconOptions = document.getElementById("iconOptions");
var selectedIcon = document.getElementById("selectedIcon");
var iconSrcInput = document.getElementById("iconSrcInput");
var colorDisplay = document.getElementById("colorDisplay");
var colorOptions = document.getElementById("colorOptions");
var colorOptionElements = document.querySelectorAll(".color-option");

var selectedIconName = "";
var selectedColor = document.getElementById("selectedColorInput").value;
updateColorChangeAbility();

iconDisplay.onclick = function () {
    iconOptions.style.display = iconOptions.style.display === "none" ? "block" : "none";
};

var iconOptionImages = document.querySelectorAll(".icon-option");
iconOptionImages.forEach(function (icon) {
    icon.onclick = function () {
        selectedIconName = this.getAttribute("data-icon");

        var iconSrc = "";
        selectedColor = document.getElementById("selectedColorInput").value;
        if (selectedColor === "" || selectedColor === "black") {
            iconSrc = `../img/iconos_formularios/${selectedIconName}.png`;
        } else {
            iconSrc = `../img/iconos_formularios/${selectedIconName}-${selectedColor}.png`;
        }

        selectedIcon.src = iconSrc;
        iconSrcInput.value = iconSrc;
        updateColorChangeAbility();

        iconOptions.style.display = "none";
    };
});

colorDisplay.onclick = function () {
    if (selectedIcon.src.includes("icono_selector_iconos.svg")) {
        console.log("Menú de colores no se abre, ícono por defecto seleccionado.");
    } else {
        colorOptions.style.display = colorOptions.style.display === "none" ? "grid" : "none";
    }
};

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

let isClearInputExecuted = false;
let isUpdatingDate = false;
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
    console.log("Limpiando el input");
}



function toggleDaySelection(day, element) {
    const input = document.getElementById('main-input');

    clearInputIfContains(['Cada', 'Repetir cada 2', 'Repetir cada 3', 'Repetir cada 4', 'Repetir cada 5', 'Repetir cada 6', 'Repetir cada 7']);

    const currentText = input.value;
    const daysArray = currentText ? currentText.split(',') : [];
    let dayFound = false;

    console.log("Días actuales:", daysArray);

    for (let i = 0; i < daysArray.length; i++) {
        daysArray[i] = daysArray[i].trim();
        if (daysArray[i] === day) {
            daysArray.splice(i, 1);
            dayFound = true;
            console.log(`Día encontrado y eliminado: ${day}`);
            break;
        }
    }

    if (!dayFound) {
        daysArray.push(day);
        console.log(`Día agregado: ${day}`);
    }

    let filteredDays = [];
    for (let i = 0; i < daysArray.length; i++) {
        if (daysArray[i]) {
            filteredDays.push(daysArray[i]);
        }
    }

    if (filteredDays.length > 0) {
        input.value = filteredDays.join(', ');
        console.log("Días filtrados:", filteredDays);
    } else {
        input.value = '';
        console.log("No hay días seleccionados, input vacío.");
    }

    if (dayFound) {
        element.style.backgroundColor = '';
    } else {
        element.style.backgroundColor = '#879FD4';
    }

    if (!isUpdatingDate) {
        isUpdatingDate = true; // Establecer el estado de actualización
        actualizarFechaFinalDiasSemana();
        isUpdatingDate = false; // Restablecer el estado de actualización
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

    if (input.value.trim()) {
        actualizarFechaFinalDiasMes();
    }

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
    if (input.value.trim()) {
        actualizarFechaFinal();
    }

}
function mostrarSubmenu(submenuId) {
    const submenu = document.getElementById(submenuId);
    submenu.style.display = submenu.style.display === 'none' ? 'block' : 'none';
}

document.addEventListener('click', function (event) {
    const dropdown = document.getElementById('dropdown-menu-dia');
    const mainInput = document.getElementById('main-input');

    if (!mainInput.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.classList.remove('show');

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

function validateTime() {
    const horaInicio = document.getElementById("hora-inicio").value;
    const horaFinal = document.getElementById("hora-final").value;

    if (horaInicio && horaFinal) {
        const [startHours, startMinutes] = horaInicio.split(':').map(Number);
        const [endHours, endMinutes] = horaFinal.split(':').map(Number);

        const startTimeInMinutes = startHours * 60 + startMinutes;
        const endTimeInMinutes = endHours * 60 + endMinutes;

        if (endTimeInMinutes <= startTimeInMinutes) {
            showToast();
            document.getElementById("hora-inicio").value = '';
            document.getElementById("hora-final").value = '';
        }
    }
}

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






document.addEventListener('click', function (event) {

    var textarea = document.getElementById("info-extra");
    var contador = document.getElementById("charCount");
    var limiteCaracteres = 400;

    if (textarea && contador) {
        var contenido = textarea.value;
        var caracteresEscritos = contenido.length;

        if (caracteresEscritos > limiteCaracteres) {
            textarea.value = contenido.substring(0, limiteCaracteres);
            caracteresEscritos = limiteCaracteres;
        }

        contador.textContent = `${caracteresEscritos}/${limiteCaracteres} caracteres`;
    }
});



function ocultarMenus() {
    const dropdownMenu = document.getElementById('dropdown-menu-dia');
    const submenuMensual = document.getElementById('submenu-mensual');
    const submenuIntervalos = document.getElementById('submenu-intervalos');

    dropdownMenu.style.display = 'none';
    submenuMensual.style.display = 'none';
    submenuIntervalos.style.display = 'none';
}

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
        inputNombreHabito.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputNombreHabito.classList.remove('input-error');
        return true;
    }
}

document.getElementById('nombreHabito').addEventListener('input', validateNombreHabito);


function validateRecompensa() {
    const inputRecompensa = document.getElementById('recompensaActividad');
    const errorSpan = document.getElementById('errorRecompensa');

    const recompensaNumero = parseInt(inputRecompensa.value, 10);

    if (isNaN(recompensaNumero) || recompensaNumero > 100 || recompensaNumero <= 0) {
        errorSpan.style.display = 'block';
        inputRecompensa.classList.add('input-error');
        return false;
    } else {
        errorSpan.style.display = 'none';
        inputRecompensa.classList.remove('input-error');
        return true;
    }
}

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
    optionsDiv.style.display = 'block';
});

optionsDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none';
});

containerDiv.addEventListener('mouseleave', function () {
    optionsDiv.style.display = 'none';
});

window.addEventListener('click', function (event) {
    if (!containerDiv.contains(event.target)) {
        optionsDiv.style.display = 'none';
    }
});

function actualizarFechaFinalDiasMes() {
    let fechaInicial = document.getElementById('mi-calendario-inicial').value;
    const diasMesSeleccionadosRaw = document.getElementById('main-input').value.trim();
    const diasMesSeleccionados = [];

    if (diasMesSeleccionadosRaw) {
        const diasArray = diasMesSeleccionadosRaw.split(',');
        for (let i = 0; i < diasArray.length; i++) {
            const partes = diasArray[i].trim().split(' ');
            const dia = parseInt(partes[partes.length - 1]);
            if (!isNaN(dia)) {
                diasMesSeleccionados.push(dia);
            }
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
        let diasValidos = [];

        for (let i = 0; i < diasMesSeleccionados.length; i++) {
            const day = diasMesSeleccionados[i];
            const fechaComprobacion = new Date(fechaFinal.getFullYear(), mesActual, day);

            if (fechaComprobacion.getMonth() === mesActual && fechaComprobacion >= fechaInicialDate) {
                diasValidos.push(fechaComprobacion);
            }
        }

        diasValidos.sort((a, b) => a - b);

        for (let validDate of diasValidos) {
            if (diasTotales < 21) {
                diasTotales++;
                fechaFinal = validDate;
            }
        }

        if (diasValidos.length === 0 || diasTotales < 21) {
            fechaFinal.setMonth(fechaFinal.getMonth() + 1);
            fechaFinal.setDate(1);
        }
    }

    const fechaFinalFormato = fechaFinal.toISOString().split('T')[0];
    document.getElementById('mi-calendario-final').value = fechaFinalFormato;
    document.getElementById('mi-calendario-final').setAttribute('min', fechaFinalFormato);
}

document.addEventListener('DOMContentLoaded', function () {
    const calendarioInicial = document.getElementById('mi-calendario-inicial');
    const inputIntervalos = document.getElementById('main-input');

    calendarioInicial.addEventListener('change', function () {
        const inputIntervalosValue = inputIntervalos.value.trim();
        console.log("Cambio en el calendario inicial. Valor actual:", inputIntervalosValue);

        if (inputIntervalosValue !== "") {
            actualizarFechaFinalDiasSemana();
        }
    });
});


function actualizarFechaFinalDiasSemana() {
    let fechaInicial = document.getElementById('mi-calendario-inicial').value;
    const diasSeleccionadosRaw = document.getElementById('main-input').value.split(',');
    const diasSeleccionados = [];

    for (let i = 0; i < diasSeleccionadosRaw.length; i++) {
        const dia = diasSeleccionadosRaw[i].trim();
        if (dia !== "") {
            diasSeleccionados.push(dia);
        }
    }
    console.log("Días seleccionados:", diasSeleccionados);

    if (!fechaInicial) {
        const hoy = new Date();
        fechaInicial = hoy.toISOString().split('T')[0];
        document.getElementById('mi-calendario-inicial').value = fechaInicial;
        console.log("Fecha inicial no proporcionada. Usando hoy:", fechaInicial);
    }

    const fechaInicialDate = new Date(fechaInicial);
    const diasDeLaSemana = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];
    let diasTotales = 0;
    let fechaFinal = new Date(fechaInicialDate);

    if (diasSeleccionados.length === 0) {
        console.warn("No hay días seleccionados para calcular la fecha final.");
        return;
    }
    while (diasTotales <= 20) {
        console.log(fechaFinal.toISOString().split('T')[0]);
        const diaActual = diasDeLaSemana[fechaFinal.getDay()];
        console.log("Día actual:", diaActual);
        if (diasSeleccionados.includes(diaActual)) {
            diasTotales++;
            console.log(diasTotales);
            console.log("Día seleccionado encontrado:", diaActual);
        }
        if (diasTotales !== 21) {
            fechaFinal.setDate(fechaFinal.getDate() + 1);
        }

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
        const hoy = new Date();
        fechaInicial = hoy.toISOString().split('T')[0];
        document.getElementById('mi-calendario-inicial').value = fechaInicial;
    }
    console.log();
    const fechaInicialDate = new Date(fechaInicial);
    let diasTotales;

    switch (intervaloSeleccionado) {
        case 'Diariamente':
            diasTotales = 20;
            break;
        case 'Repetir cada 2':
            diasTotales = (20 * 2);
            break;
        case 'Repetir cada 3':
            diasTotales = (20 * 3);
            break;
        case 'Repetir cada 4':
            diasTotales = (20 * 4);
            break;
        case 'Repetir cada 5':
            diasTotales = (20 * 5);
            break;
        case 'Repetir cada 7':
            diasTotales = (20 * 7);
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


//Corregir esto
document.getElementById('mi-calendario-inicial').addEventListener('change', function () {
    var inputIntervalos = document.getElementById('main-input').value.trim();

    if (inputIntervalos) {
        if (inputIntervalos.includes('Lunes') || inputIntervalos.includes('Martes') || inputIntervalos.includes('Miércoles') || inputIntervalos.includes('Jueves') || inputIntervalos.includes('Viernes') || inputIntervalos.includes('Sábado') || inputIntervalos.includes('Domingo')) {
            actualizarFechaFinal();
        } else if (inputIntervalos.includes('Cada mes')) {
            actualizarFechaFinalDiasSemana();
        } else if (inputIntervalos.includes('Repetir')) {
            actualizarFechaFinalDiasMes();
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




// Función para llenar el formulario (ayuda, ya no puedo más)
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
    }, 7000);
}

function validateIconSrcInput() {
    const iconSrcInput = document.getElementById('iconSrcInput').value;

    if (iconSrcInput === '') {
        showToastIconos();
        return false;
    }
    return true;
}

function validateColorValue() {
    const iconSrcInput = document.getElementById('selectedColorInput').value;

    if (iconSrcInput === '') {
        showToastIconos();
        return false;
    }
    return true;
}

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
















function toggleContentActividades() {
    const content = document.getElementById('div-esta-semana-act-abajo');
    const flecha = document.getElementById('img-flechita');

    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
        flecha.src = '../img/flechita_arriba.svg';
        flecha.classList.add('icon-down');
    } else {
        content.style.display = 'none';
        flecha.src = '../img/flechita-abajo.svg';
        flecha.classList.remove('icon-down');
    }
}

function toggleContentActividades2() {
    const content = document.getElementById('div-siguiente-semana-act-abajo');
    const flecha = document.getElementById('img-flechita2');

    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
        flecha.src = '../img/flechita_arriba.svg';
        flecha.classList.add('icon-down');
    } else {
        content.style.display = 'none';
        flecha.src = '../img/flechita-abajo.svg';
        flecha.classList.remove('icon-down');
    }
}

function toggleContentActividades3() {
    const content = document.getElementById('div-mas-tarde-act-abajo');
    const flecha = document.getElementById('img-flechita3');

    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
        flecha.src = '../img/flechita_arriba.svg';
        flecha.classList.add('icon-down');
    } else {
        content.style.display = 'none';
        flecha.src = '../img/flechita-abajo.svg';
        flecha.classList.remove('icon-down');
    }
}







function editarActividad() {
    document.getElementById('modalCrearActividad').style.display = 'block';
    document.getElementById('modalCrearActividad').style.display = 'flex';


}

function cerrarModalActualizar() {
    document.getElementById('modalActualizarActividad').style.display = 'none';
}




function buscarActividades() {
    const input = document.getElementById('inputBuscador');
    const filter = input.value.toLowerCase();
    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });

    if (filter.length > 0) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";

        actividades.forEach(actividad => {

            const nombreActividad = actividad.querySelector('.text-nombre-habit-desplegado');
            if (nombreActividad) {
                actividad.style.display = "block";
                const text = nombreActividad.textContent || nombreActividad.innerText;

                if (text.toLowerCase().includes(filter)) {
                    actividad.style.display = "flex";
                    hayCoincidencias = true;
                } else {
                    actividad.style.display = "none";

                }
            } else {

            }
        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}

function filtrarPorTipo() {
    const checkboxesCategorias = document.querySelectorAll('input[name="categoria"]:checked');
    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });

    if (checkboxesCategorias.length > 0) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";


        var verifiTipoSelected = false;

        actividades.forEach(actividad => {
            var tipoActividad = actividad.querySelector('.text-tipo-act-habit-desplegado');
            const tipoAct = tipoActividad.textContent || tipoActividad.innerText;

            verifiTipoSelected = false;
            var cont = 0;
            checkboxesCategorias.forEach(checkbox => {
                cont = cont + 1;
                if (checkbox.value === tipoAct) {
                    console.log(checkbox.value);
                    verifiTipoSelected = true;
                }
            });

            if (verifiTipoSelected === true) {
                actividad.style.display = "block";
                actividad.style.display = "flex";
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}


function filtrarPorNumRamitas() {
    const actividadNumRamitasFiltroInput = document.getElementById('recompensaActividadFilt');
    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });

    const filtroValor = parseInt(actividadNumRamitasFiltroInput.value, 10);


    if (!isNaN(filtroValor) && filtroValor > 0 && filtroValor <= 100) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";

        actividades.forEach(actividad => {
            const actividadNumRamitasActiDesplegada = actividad.querySelector('#text-num-ramitas-despl-acti');
            const numRamitasFilt = parseInt(actividadNumRamitasActiDesplegada.textContent, 10);


            if (numRamitasFilt === filtroValor) {
                actividad.style.display = "block";
                actividad.style.display = "flex";
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}

function filtrarPorFrecuenciaRep() {
    const checkboxesFrecuenciasRep = document.querySelectorAll('input[name="frecuencia"]:checked');

    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });


    if (checkboxesFrecuenciasRep.length > 0) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";


        var verifiFrecuenciaSelected = false;

        actividades.forEach(actividad => {
            var frecuenciaRepeti = actividad.querySelector('.text-frecuencia-rep-habit-desplegado');
            const frecuenciaRep = frecuenciaRepeti.textContent || frecuenciaRepeti.innerText;

            verifiFrecuenciaSelected = false;
            var cont = 0;
            checkboxesFrecuenciasRep.forEach(checkbox => {
                cont = cont + 1;
                if (checkbox.value === "semanal" && (frecuenciaRep.includes("Lunes") || frecuenciaRep.includes("Martes") || frecuenciaRep.includes("Miércoles") || frecuenciaRep.includes("Jueves") || frecuenciaRep.includes("Viernes") || frecuenciaRep.includes("Sábado") || frecuenciaRep.includes("Domingo"))) {
                    console.log(checkbox.value);
                    console.log(frecuenciaRep);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "mensual" && frecuenciaRep.includes("mes")) {
                    console.log(checkbox.value);
                    console.log(frecuenciaRep);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "intervalo" && frecuenciaRep.includes("Repetir")) {
                    console.log(checkbox.value);
                    console.log(frecuenciaRep);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
            });

            if (verifiFrecuenciaSelected === true) {
                actividad.style.display = "block";
                actividad.style.display = "flex";
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}

function filtrarPorIntervalosDeFechas() {
    const miCalendarioInicialFiltro = document.getElementById('mi-calendario-inicial-filtro');
    const miCalendarioFinalFiltro = document.getElementById('mi-calendario-final-filtro');

    const fechaInicial = miCalendarioInicialFiltro.value;
    const fechaFinal = miCalendarioFinalFiltro.value;

    if (!fechaInicial || !fechaFinal) {
        console.log('Por favor, completa ambas fechas.');
        return;
    }

    const fechaInicialDate = new Date(fechaInicial);
    const fechaFinalDate = new Date(fechaFinal);

    if (isNaN(fechaInicialDate.getTime()) || isNaN(fechaFinalDate.getTime())) {
        console.log('Por favor, ingresa fechas válidas.');
        return;
    }

    const dateInicial = fechaInicialDate.toISOString().split('T')[0];
    const dateFinal = fechaFinalDate.toISOString().split('T')[0];

    console.log('Fecha Inicial:', dateInicial);
    console.log('Fecha Final:', dateFinal);


    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });


    if (dateInicial !== null && dateFinal !== null) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";



        actividades.forEach(actividad => {
            const dateInicioOculto = actividad.querySelector('.text-date-ini-habit-desplegado');
            const dateInicio = new Date(dateInicioOculto.textContent || dateInicioOculto.innerText);

            const dateFinOculto = actividad.querySelector('.text-date-fin-habit-desplegado');
            const dateFin = new Date(dateFinOculto.textContent || dateFinOculto.innerText);

            console.log("Fecha inicio actividad: ", dateInicio);
            console.log("Fecha fin actividad: ", dateFin);




            if (dateInicio <= fechaFinalDate && dateFin >= fechaInicialDate) {
                actividad.style.display = "flex";
                console.log("Desplegando actividad:", actividad);
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}


function filtrarPorEstadoActividad() {
    const checkboxesEstadoActividad = document.querySelectorAll('input[name="estado"]:checked');

    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });


    if (checkboxesEstadoActividad.length > 0) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";


        var verifiFrecuenciaSelected = false;

        actividades.forEach(actividad => {
            var estadoActividad = actividad.querySelector('.text-estado-act-habit-desplegado');
            const estadoActividadText = estadoActividad.textContent || estadoActividad.innerText;

            verifiFrecuenciaSelected = false;
            var cont = 0;
            checkboxesEstadoActividad.forEach(checkbox => {
                cont = cont + 1;
                if (checkbox.value === "completada" && estadoActividadText === "2") {
                    console.log(checkbox.value);
                    console.log(estadoActividadText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "en-progreso" && estadoActividadText === "0") {
                    console.log(checkbox.value);
                    console.log(estadoActividadText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "no-iniciada" && estadoActividadText === "1") {
                    console.log(checkbox.value);
                    console.log(estadoActividadText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
            });

            if (verifiFrecuenciaSelected === true) {
                actividad.style.display = "block";
                actividad.style.display = "flex";
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}



function filtrarPorColor() {
    const checkboxesColorActi = document.querySelectorAll('input[name="color"]:checked');

    const actividadesContainer = document.querySelector('.medio');
    const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
    const secciones = actividadesContainer.querySelectorAll('.seccion');
    const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
    const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
    const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');

    const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
    const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
    const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');

    let hayCoincidencias = false;

    secciones.forEach(seccion => {
        seccion.style.display = "block";
    });


    if (checkboxesColorActi.length > 0) {
        estaSemanaContActi.style.display = "none";
        siguienteSemanaContActi.style.display = "none";
        masTardeContActi.style.display = "none";

        divEstaSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "block";


        var verifiFrecuenciaSelected = false;

        actividades.forEach(actividad => {
            var colorActi = actividad.querySelector('.text-color-act-habit-desplegado');
            const colorActiText = colorActi.textContent || colorActi.innerText;

            verifiFrecuenciaSelected = false;
            var cont = 0;
            checkboxesColorActi.forEach(checkbox => {
                cont = cont + 1;
                if (checkbox.value === "rojo" && colorActiText === "rojo") {
                    console.log(checkbox.value);
                    console.log(colorActiText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "verde" && colorActiText === "verde") {
                    console.log(checkbox.value);
                    console.log(colorActiText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "azul" && colorActiText === "azul") {
                    console.log(checkbox.value);
                    console.log(colorActiText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "amarillo" && colorActiText === "amarillo") {
                    console.log(checkbox.value);
                    console.log(colorActiText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
                if (checkbox.value === "morado" && colorActiText === "morado") {
                    console.log(checkbox.value);
                    console.log(colorActiText);
                    actividad.style.display = "block";
                    actividad.style.display = "flex";
                    verifiFrecuenciaSelected = true;
                }
            });

            if (verifiFrecuenciaSelected === true) {
                actividad.style.display = "block";
                actividad.style.display = "flex";
                hayCoincidencias = true;
            } else {
                actividad.style.display = "none";
            }

        });
    } else {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "block";
        divEstaSemanaActAbajo.style.display = "flex";
        divSiguienteSemanaActAbajo.style.display = "block";
        divSiguienteSemanaActAbajo.style.display = "flex";
        divMasTardeActAbajo.style.display = "block";
        divMasTardeActAbajo.style.display = "flex";

        actividades.forEach(actividad => {
            actividad.style.display = "block";
            actividad.style.display = "flex";
        });

    }

    if (!hayCoincidencias) {
        estaSemanaContActi.style.display = "block";
        estaSemanaContActi.style.display = "flex";
        siguienteSemanaContActi.style.display = "block";
        siguienteSemanaContActi.style.display = "flex";
        masTardeContActi.style.display = "block";
        masTardeContActi.style.display = "flex";

        divEstaSemanaActAbajo.style.display = "none";
        divSiguienteSemanaActAbajo.style.display = "none";
        divMasTardeActAbajo.style.display = "none";
    }
}

/*
 
 function filtrarActividades() {
 //barra de navegación: 
 
 const input = document.getElementById('inputBuscador');
 const filter = input.value.toLowerCase();
 
 //por categorías
 const checkboxesCategorias = document.querySelectorAll('input[name="categoria"]:checked');
 
 //por ramitas
 const actividadNumRamitasFiltroInput = document.getElementById('recompensaActividadFilt');
 const filtroValor = parseInt(actividadNumRamitasFiltroInput.value, 10);
 
 //por Intervalos De Fechas
 const miCalendarioInicialFiltro = document.getElementById('mi-calendario-inicial-filtro');
 const miCalendarioFinalFiltro = document.getElementById('mi-calendario-final-filtro');
 
 const fechaInicial = miCalendarioInicialFiltro.value;
 const fechaFinal = miCalendarioFinalFiltro.value;
 
 if (!fechaInicial || !fechaFinal) {
 console.log('Por favor, completa ambas fechas.');
 return;
 }
 
 const fechaInicialDate = new Date(fechaInicial);
 const fechaFinalDate = new Date(fechaFinal);
 
 if (isNaN(fechaInicialDate.getTime()) || isNaN(fechaFinalDate.getTime())) {
 console.log('Por favor, ingresa fechas válidas.');
 return;
 }
 
 const dateInicial = fechaInicialDate.toISOString().split('T')[0];
 const dateFinal = fechaFinalDate.toISOString().split('T')[0];
 
 console.log('Fecha Inicial:', dateInicial);
 console.log('Fecha Final:', dateFinal);
 
 //por repeticiones
 const checkboxesFrecuenciasRep = document.querySelectorAll('input[name="frecuencia"]:checked');
 
 //por estado Actividad
 const checkboxesEstadoActividad = document.querySelectorAll('input[name="estado"]:checked');
 
 //por colores
 const checkboxesColorActi = document.querySelectorAll('input[name="color"]:checked');
 
 
 //lo demás xd
 const actividadesContainer = document.querySelector('.medio');
 const actividades = actividadesContainer.querySelectorAll('.contenedor-cada-actividad');
 const secciones = actividadesContainer.querySelectorAll('.seccion');
 const estaSemanaContActi = document.getElementById('div-esta-semana-act-arriba');
 const siguienteSemanaContActi = document.getElementById('div-siguiente-semana-act-arriba');
 const masTardeContActi = document.getElementById('div-mas-tarde-act-arriba');
 
 const divEstaSemanaActAbajo = document.getElementById('div-esta-semana-act-abajo');
 const divSiguienteSemanaActAbajo = document.getElementById('div-siguiente-semana-act-abajo');
 const divMasTardeActAbajo = document.getElementById('div-mas-tarde-act-abajo');
 
 let hayCoincidencias = false;
 
 secciones.forEach(seccion => {
 seccion.style.display = "block";
 });
 
 
 if (filter.length > 0 || checkboxesCategorias.length > 0 || (!isNaN(filtroValor) && filtroValor > 0 && filtroValor <= 100) || (dateInicial !== null && dateFinal !== null) || checkboxesFrecuenciasRep.length > 0 || checkboxesEstadoActividad.length > 0 || checkboxesColorActi.length > 0) {
 estaSemanaContActi.style.display = "none";
 siguienteSemanaContActi.style.display = "none";
 masTardeContActi.style.display = "none";
 
 divEstaSemanaActAbajo.style.display = "block";
 divSiguienteSemanaActAbajo.style.display = "block";
 divMasTardeActAbajo.style.display = "block";
 
 var verifiTipoSelected = false;
 var verifiFrecuenciaSelected = false;
 var verifiEstadoActividad = false;
 var verifiColores = false;
 
 actividades.forEach(actividad => {
 
 //barra de navegación:
 const nombreActividad = actividad.querySelector('.text-nombre-habit-desplegado');
 
 //por tipo: 
 var tipoActividad = actividad.querySelector('.text-tipo-act-habit-desplegado');
 const tipoAct = tipoActividad.textContent || tipoActividad.innerText;
 verifiTipoSelected = false;
 checkboxesCategorias.forEach(checkboxCateg => {
 if (checkboxCateg.value === tipoAct) {
 console.log(checkboxCateg.value);
 verifiTipoSelected = true;
 
 }
 });
 
 if (verifiTipoSelected === true) {
 hayCoincidencias = true;
 }
 
 //por ramitas:
 const actividadNumRamitasActiDesplegada = actividad.querySelector('#text-num-ramitas-despl-acti');
 const numRamitasFilt = parseInt(actividadNumRamitasActiDesplegada.textContent, 10);
 
 //por Intervalos De Fechas
 const dateInicioOculto = actividad.querySelector('.text-date-ini-habit-desplegado');
 const dateInicio = new Date(dateInicioOculto.textContent || dateInicioOculto.innerText);
 
 const dateFinOculto = actividad.querySelector('.text-date-fin-habit-desplegado');
 const dateFin = new Date(dateFinOculto.textContent || dateFinOculto.innerText);
 
 console.log("Fecha inicio actividad: ", dateInicio);
 console.log("Fecha fin actividad: ", dateFin);
 
 //por repeticiones
 var frecuenciaRepeti = actividad.querySelector('.text-frecuencia-rep-habit-desplegado');
 const frecuenciaRep = frecuenciaRepeti.textContent || frecuenciaRepeti.innerText;
 
 verifiFrecuenciaSelected = false;
 checkboxesFrecuenciasRep.forEach(checkboxFrec => {
 if (checkboxFrec.value === "semanal" && (frecuenciaRep.includes("Lunes") || frecuenciaRep.includes("Martes") || frecuenciaRep.includes("Miércoles") || frecuenciaRep.includes("Jueves") || frecuenciaRep.includes("Viernes") || frecuenciaRep.includes("Sábado") || frecuenciaRep.includes("Domingo"))) {
 console.log(checkboxFrec.value);
 console.log(frecuenciaRep);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiFrecuenciaSelected = true;
 }
 if (checkboxFrec.value === "mensual" && frecuenciaRep.includes("mes")) {
 console.log(checkboxFrec.value);
 console.log(frecuenciaRep);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiFrecuenciaSelected = true;
 }
 if (checkboxFrec.value === "intervalo" && frecuenciaRep.includes("Repetir")) {
 console.log(checkboxFrec.value);
 console.log(frecuenciaRep);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiFrecuenciaSelected = true;
 }
 });
 
 //por estado de actividad
 var estadoActividad = actividad.querySelector('.text-estado-act-habit-desplegado');
 const estadoActividadText = estadoActividad.textContent || estadoActividad.innerText;
 
 verifiEstadoActividad = false;
 checkboxesEstadoActividad.forEach(checkboxActEstad => {
 if (checkboxActEstad.value === "completada" && estadoActividadText === "2") {
 console.log(checkboxActEstad.value);
 console.log(estadoActividadText);
 verifiEstadoActividad = true;
 }
 if (checkboxActEstad.value === "en-progreso" && estadoActividadText === "0") {
 console.log(checkboxActEstad.value);
 console.log(estadoActividadText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiEstadoActividad = true;
 }
 if (checkboxActEstad.value === "no-iniciada" && estadoActividadText === "1") {
 console.log(checkboxActEstad.value);
 console.log(estadoActividadText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiEstadoActividad = true;
 }
 });
 
 //por colores
 var colorActi = actividad.querySelector('.text-color-act-habit-desplegado');
 const colorActiText = colorActi.textContent || colorActi.innerText;
 
 verifiFrecuenciaSelected = false;
 checkboxesColorActi.forEach(checkboxColor => {
 if (checkboxColor.value === "rojo" && colorActiText === "rojo") {
 console.log(checkboxColor.value);
 console.log(colorActiText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiColores = true;
 }
 if (checkboxColor.value === "verde" && colorActiText === "verde") {
 console.log(checkboxColor.value);
 console.log(colorActiText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiColores = true;
 }
 if (checkboxColor.value === "azul" && colorActiText === "azul") {
 console.log(checkboxColor.value);
 console.log(colorActiText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiColores = true;
 }
 if (checkboxColor.value === "amarillo" && colorActiText === "amarillo") {
 console.log(checkboxColor.value);
 console.log(colorActiText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiColores = true;
 }
 if (checkboxColor.value === "morado" && colorActiText === "morado") {
 console.log(checkboxColor.value);
 console.log(colorActiText);
 actividad.style.display = "block";
 actividad.style.display = "flex";
 verifiColores = true;
 }
 });
 
 
 const text = nombreActividad.textContent || nombreActividad.innerText;
 
 if (text.toLowerCase().includes(filter) || verifiTipoSelected === true || numRamitasFilt === filtroValor || (dateInicio <= fechaFinalDate && dateFin >= fechaInicialDate) || verifiFrecuenciaSelected === true || verifiEstadoActividad === true || verifiColores === true) {
 actividad.style.display = "block";
 actividad.style.display = "flex";
 hayCoincidencias = true;
 } else {
 actividad.style.display = "none";
 }
 
 
 });
 } else {
 estaSemanaContActi.style.display = "block";
 estaSemanaContActi.style.display = "flex";
 siguienteSemanaContActi.style.display = "block";
 siguienteSemanaContActi.style.display = "flex";
 masTardeContActi.style.display = "block";
 masTardeContActi.style.display = "flex";
 
 divEstaSemanaActAbajo.style.display = "block";
 divEstaSemanaActAbajo.style.display = "flex";
 divSiguienteSemanaActAbajo.style.display = "block";
 divSiguienteSemanaActAbajo.style.display = "flex";
 divMasTardeActAbajo.style.display = "block";
 divMasTardeActAbajo.style.display = "flex";
 
 actividades.forEach(actividad => {
 actividad.style.display = "block";
 actividad.style.display = "flex";
 });
 
 }
 
 if (!hayCoincidencias) {
 estaSemanaContActi.style.display = "block";
 estaSemanaContActi.style.display = "flex";
 siguienteSemanaContActi.style.display = "block";
 siguienteSemanaContActi.style.display = "flex";
 masTardeContActi.style.display = "block";
 masTardeContActi.style.display = "flex";
 
 divEstaSemanaActAbajo.style.display = "none";
 divSiguienteSemanaActAbajo.style.display = "none";
 divMasTardeActAbajo.style.display = "none";
 }
 }
 
 */


/*document.addEventListener('click', () => {
 console.log('Se andan ejecutando las funciones de filtrado:)');
 buscarActividades();
 filterOptionsNombre();
 filtrarPorColor();
 filtrarPorEstadoActividad();
 filtrarPorFrecuenciaRep();
 filtrarPorIntervalosDeFechas();
 filtrarPorNumRamitas();
 filtrarPorTipo();
 });*/

function showEstadoActiCorrect() {
    var toast = document.getElementById('toast-validar-informacion-formulario-correct');
    console.log("Estado del Toast: " + toast.style.display);
    if (toast.style.display === 'block') {
        setTimeout(function () {
            console.log("Ocultando Toast...");
            toast.style.display = 'none';
        }, 5000);
    }
}


function showEstadoActi() {
    var toast = document.getElementById('toast-validar-informacion-formulario');
    console.log("Estado del Toast: " + toast.style.display);
    if (toast.style.display === 'block') {
        setTimeout(function () {
            console.log("Ocultando Toast...");
            toast.style.display = 'none';
        }, 5000);
    }
}
window.onload = function () {
    showEstadoActi();
    showEstadoActiCorrect();
};



function abrirCompletarActividadModal(){
    const modal = document.getElementById("modalActividadSeleccionadaInfo");
}