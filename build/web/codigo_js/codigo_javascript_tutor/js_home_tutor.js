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
function openModal() {
    document.getElementById("noChildModal").style.display = "flex";  // Muestra el modal
}

function closeModal() {
    document.getElementById("noChildModal").style.display = "none";  // Oculta el modal
}

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
    xhr.open("POST", "procesa_home_tutor.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Aquí puedes actualizar la sección de la página donde se muestran los hábitos
            document.getElementById("recom").innerHTML = xhr.responseText;
        }
    };
    xhr.send("idKit=" + idKit);
}
