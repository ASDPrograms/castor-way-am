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

function toggleNavSection() {
    console.log("Si se está mandando");
    const expandedSection = document.querySelector('.expanded-section');
    const icon = document.getElementById('icon-desplegar-users-chat');

    expandedSection.classList.toggle('expanded');
}

if (usuarioSeleccionado) {
    const socket = new WebSocket('ws://localhost:8080/CastorWay/chat');

    socket.onopen = function (event) {
        console.log("Conexión WebSocket abierta.");
    };

    socket.onmessage = function (event) {
        console.log("Mensaje recibido desde el servidor:", event.data);

        let mensaje;

        try {
            mensaje = JSON.parse(event.data);
            console.log("Mensaje parseado:", mensaje);

            const chatContainer = document.getElementById('contenido-mensajes');


            if (mensaje.emisor === "Tutor") {
                const nuevoMensaje = document.createElement('div');
                nuevoMensaje.classList.add('mensaje');
                nuevoMensaje.classList.add('mensaje-enviado');
                nuevoMensaje.textContent = mensaje.txtMsj;
                chatContainer.appendChild(nuevoMensaje);
                console.log("se hizo");
            } else {
                console.log("se hizox2");
                const nuevoMensaje = document.createElement('div');
                nuevoMensaje.classList.add('mensaje');
                nuevoMensaje.classList.add('mensaje-recibido');
                nuevoMensaje.textContent = mensaje.txtMsj;
                chatContainer.appendChild(nuevoMensaje);
            }

            chatContainer.scrollTop = chatContainer.scrollHeight;

        } catch (e) {
            console.log("Error al parsear el mensaje:", e);
        }


    };


    socket.onerror = function (event) {
        console.error("Error en la conexión WebSocket:", event);
    };

    socket.onclose = function (event) {
        console.log("Conexión WebSocket cerrada.");
    };
    const botonEnviar = document.getElementById('btnEnviarMsj');
    if (botonEnviar) {
        botonEnviar.addEventListener('click', function (event) {
            event.preventDefault();
            const idCastor = document.getElementById('idCastorInputMsj').value;
            const idKit = document.getElementById('idKitInputMsj').value;
            const emisor = document.getElementById('idEmisorInputMsj').value;
            const txtMsj = document.getElementById('idMsjInputMsj').value;


            if (!txtMsj.trim()) {
                alert("No puedes enviar un mensaje vacío");
                return;
            }

            const mensaje = {
                idCastor: idCastor,
                idKit: idKit,
                emisor: emisor,
                txtMsj: txtMsj
            };

            console.log("Mensaje enviado:", JSON.stringify(mensaje));
            socket.send(JSON.stringify(mensaje));

            document.querySelector('textarea[name="txtMsj"]').value = "";
        });
    }
    console.log("ta actualizao");

}