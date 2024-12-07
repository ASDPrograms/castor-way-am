/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.getElementById('nombreError').style.display = 'none';
document.getElementById('apellidosError').style.display = 'none';
document.getElementById('edadError').style.display = 'none';
document.getElementById('correoError').style.display = 'none';
document.getElementById('contrasenaError').style.display = 'none';
document.getElementById('checkboxError').style.display = 'none';

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('castorForm').addEventListener('submit', function (event) {
        let valid = true;

        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');

        const nombre = document.getElementById('nombre').value.trim();
        if (nombre.length < 2) {
            document.getElementById('nombreError').textContent = 'Nombre inválido, muy pocos carácteres.';
            document.getElementById('nombreError').style.display = 'block';
            valid = false;
        }

        const apellidos = document.getElementById('apellidos').value.trim();
        if (apellidos.length < 2) {
            document.getElementById('apellidosError').textContent = 'Apellido inválido, muy pocos carácteres.';
            document.getElementById('apellidosError').style.display = 'block';
            valid = false;
        }

        const edad = parseInt(document.getElementById('edad').value);
        if (isNaN(edad) || edad <= 0 || edad > 120) {
            document.getElementById('edadError').textContent = 'Edad inválida.';
            document.getElementById('edadError').style.display = 'block';
            valid = false;
        }

        const correo = document.getElementById('correo').value.trim();
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(correo)) {
            document.getElementById('correoError').textContent = 'Correo electrónico inválido.';
            document.getElementById('correoError').style.display = 'block';

            valid = false;
        }

        const contrasena = document.getElementById('contrasena').value;
        if (contrasena.length < 6) {
            document.getElementById('contrasenaError').textContent = 'La contraseña debe tener al menos 6 caracteres.';
            document.getElementById('contrasenaError').style.display = 'block';
            valid = false;
        }

        const checkbox = document.getElementById('cbox1').checked;
        if (!checkbox) {
            document.getElementById('checkboxError').textContent = 'Debes aceptar los términos y condiciones.';
            document.getElementById('checkboxError').style.display = 'block';
            valid = false;
        }

        if (!valid) {
            event.preventDefault();
        }
    });
});