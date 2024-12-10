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
    form.action = "calendario_hijo.jsp";

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