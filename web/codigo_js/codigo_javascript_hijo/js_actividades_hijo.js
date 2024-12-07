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