/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener('DOMContentLoaded', function () {
    const selectElement = document.getElementById('privacidad_nota');
    if (selectElement) {
        selectElement.addEventListener('change', () => {
            console.log(`Nueva opción seleccionada: ${selectElement.value}`);
        });
    }

    document.getElementById('tituloError').style.display = 'none';
    document.getElementById('infoError').style.display = 'none';

    document.getElementById('subir_nota').addEventListener('submit', function (event) {
        console.log('Validación activada');
        let valid = true;

        const tituloNota = document.getElementById('titulo-nota').value.trim();
        const infoNota = document.getElementById('infoNota').value.trim();
        const titutloRegexSoloNumeros = /^\d+$/;

        // Validación del título
        if (tituloNota.length < 2) {
            document.getElementById('tituloError').textContent = 'El título es demasiado corto.';
            document.getElementById('tituloError').style.display = 'block';
            valid = false;
        } else if (titutloRegexSoloNumeros.test(tituloNota)) {
            document.getElementById('tituloError').textContent = 'El título no debe contener únicamente números.';
            document.getElementById('tituloError').style.display = 'block';
            valid = false;
        } else {
            document.getElementById('tituloError').style.display = 'none';
        }

        // Validación de la información de la nota
        
        if (infoNota.length < 2) {
            document.getElementById('infoError').textContent = 'Texto inválido, pocos caracteres.';
            document.getElementById('infoError').style.display = 'block';
            valid = false;
        } else {
            document.getElementById('infoError').style.display = 'none';
        }

        if (!valid) {
            event.preventDefault();
        }
    });

    document.getElementById('boton-privado').addEventListener('click', cambiarPrivacidad);
    document.getElementById('boton-publico').addEventListener('click', cambiarPrivacidad);
});

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('tituloError').style.display = 'none';
    document.getElementById('infoError').style.display = 'none';


    document.getElementById('boton-privado').addEventListener('click', cambiarPrivacidad);
    document.getElementById('boton-publico').addEventListener('click', cambiarPrivacidad);
});


document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('tituloError').style.display = 'none';
    document.getElementById('infoError').style.display = 'none';

    const itemPrivacidad = document.getElementById('item-EdoNot-privacidad');
    itemPrivacidad.addEventListener('click', cambiarPrivacidad);
});

function cambiarPrivacidad() {
    const estadoPrivacidad = document.getElementById('estado-privacidad');
    const valorPrivacidad = document.getElementById('valor-privacidad');
    const imagenPrivacidad = document.getElementById('privacidad-nota'); // Imagen del candado

    if (estadoPrivacidad.textContent === "Privado") {
        estadoPrivacidad.textContent = "Público";
        if (valorPrivacidad) valorPrivacidad.value = "0";

        // Cambiar imagen a candado abierto
        if (imagenPrivacidad) imagenPrivacidad.src = "../img/candado_abierto.svg";
    } else {
        estadoPrivacidad.textContent = "Privado";
        if (valorPrivacidad) valorPrivacidad.value = "1";

        // Cambiar imagen a candado cerrado
        if (imagenPrivacidad) imagenPrivacidad.src = "../img/candado_cerrado.svg";
    }
}