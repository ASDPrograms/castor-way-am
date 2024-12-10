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

function buscarSemana(primerDia) {
    console.log("Día a buscar: " + primerDia);

    const form = document.createElement("form");
    form.method = "POST";
    form.action = "calendario_semanal_hijo.jsp";

    const inputFecha = document.createElement("input");
    inputFecha.type = "hidden";
    inputFecha.name = "semanaConsulta";
    inputFecha.value = primerDia;

    form.appendChild(inputFecha);
    document.body.appendChild(form);

    sessionStorage.setItem("buscandoSemana", "true");
    form.submit();
}

function formatoFecha(fecha) {
    const año = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, '0');
    const dia = String(fecha.getDate()).padStart(2, '0');
    return `${año}-${mes}-${dia}`;
}

const fechaGuardadaSesion = sessionStorage.getItem("fechaGuardada");
let fechaGuardada;
let fechaAct = new Date();
let buscandoSemana = sessionStorage.getItem("buscandoSemana");


if (fechaGuardadaSesion) {
    fechaAct = new Date(fechaGuardadaSesion);
    fechaGuardada = new Date(fechaGuardadaSesion);
} else {
    fechaAct = new Date();
    fechaAct.setDate(fechaAct.getDate() - fechaAct.getDay());
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
}

function escribirFechas() {
    console.log("Estado de búsqueda: " + buscandoSemana);

    if (fechaGuardada) {
        fechaAct = new Date(fechaGuardada);
    }

    fechasCont.innerHTML = "";
    const primerDia = new Date(fechaAct);
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

    diasSemana.forEach((dia) => dia.classList.remove("dia-actual"));
    if (fechaHoy >= primerDia && fechaHoy <= ultimoDia) {
        diasSemana.forEach((dia, index) => {
            if (index === fechaHoy.getDay())
                dia.classList.add("dia-actual");
        });
    }

    for (let i = 0; i < 7; i++) {
        const divDia = document.createElement("div");
        const diaActual = new Date(fechaAct);
        diaActual.setDate(fechaAct.getDate() + i);
        diaActual.setHours(0, 0, 0, 0);

        divDia.className = "fecha";
        const buttonDia = document.createElement("div");
        buttonDia.className = "Btnfecha";
        buttonDia.textContent = diaActual.getDate();

        if (diaActual.getTime() === fechaHoy.getTime()) {
            divDia.classList.add("fecha-actual");
            buttonDia.classList.add("Btnfecha-actual");
        }

        divDia.appendChild(buttonDia);
        fechasCont.appendChild(divDia);
    }

    if (!buscandoSemana) {
        buscandoSemana = true;
        sessionStorage.setItem("buscandoSemana", "true");
        console.log("Voy a buscar semana para: " + formatoFecha(primerDia));
        buscarSemana(formatoFecha(primerDia));
    } else {
        console.log("Ya ta haciendo algo pera.");
    }

}

btnPrevio.addEventListener("click", () => {
    fechaAct.setDate(fechaAct.getDate() - 7);
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    buscandoSemana = false;
    sessionStorage.setItem("buscandoSemana", "false");
    escribirFechas();
});

btnSig.addEventListener("click", () => {
    fechaAct.setDate(fechaAct.getDate() + 7);
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    buscandoSemana = false;
    sessionStorage.setItem("buscandoSemana", "false");
    escribirFechas();
});

btnHoy.addEventListener("click", () => {
    fechaAct = new Date();
    fechaAct.setDate(fechaAct.getDate() - fechaAct.getDay());
    fechaGuardada = new Date(fechaAct);
    sessionStorage.setItem("fechaGuardada", fechaGuardada.toISOString());
    buscandoSemana = false;
    sessionStorage.setItem("buscandoSemana", "false");
    escribirFechas();
});

window.addEventListener('resize', escribirFechas);
escribirFechas();




function mostrarInfo(idActividad) {
    const actividad = actividades[idActividad];


    console.log(actividad);
    if (actividad) {
        const infoActContent = document.getElementById("info-seleccionada");
        infoActContent.classList.add('info-actContent-mostrando');
        infoActContent.innerHTML = `
            <img src="${actividad.imagen}" class="imgIconoActividad">
            <h3>${actividad.nombre}</h3>
            <div class="actividad-despleada-ramitas">
                <div class="cont-img-icono-ramita-num-ramitas">
                    <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                </div>
                <div>
                    <label id="text-num-ramitas-despl-acti">${actividad.ramitas} Ramitas</label>
                </div>
            </div>
            <div class="descAct">
            <p>${actividad.infoExtra}</p>
            </div>
        `;
    } else {

    }
}