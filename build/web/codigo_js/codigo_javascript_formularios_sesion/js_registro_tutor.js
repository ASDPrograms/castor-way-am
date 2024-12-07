document.getElementById('nombreError').style.display = 'none';
document.getElementById('apellidosError').style.display = 'none';
document.getElementById('edadError').style.display = 'none';
document.getElementById('correoError').style.display = 'none';
document.getElementById('contrasenaError').style.display = 'none';
document.getElementById('checkboxError').style.display = 'none';

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('correo').addEventListener('input', function () {
        this.value = this.value.toLowerCase(); 
    });
    document.getElementById('castorForm').addEventListener('submit', function (event) {
        let valid = true;

        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');

        const nombre = document.getElementById('nombre').value.trim();
        const nombreRegexNumeros = /\d/;
        if (nombre.length < 2) {
            document.getElementById('nombreError').textContent = 'Nombre inválido, muy pocos caracteres.';
            document.getElementById('nombreError').style.display = 'block';
            valid = false;
        } else if (nombreRegexNumeros.test(nombre)) {
            document.getElementById('nombreError').textContent = 'El nombre no debe contener números.';
            document.getElementById('nombreError').style.display = 'block';
            valid = false;
        }

        const apellidos = document.getElementById('apellidos').value.trim();
        const apellidosRegexNumeros = /\d/; 
        if (apellidos.length < 2) {
            document.getElementById('apellidosError').textContent = 'Apellido inválido, muy pocos caracteres.';
            document.getElementById('apellidosError').style.display = 'block';
            valid = false;
        } else if (apellidosRegexNumeros.test(apellidos)) {
            document.getElementById('apellidosError').textContent = 'Los apellidos no deben contener números.';
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
