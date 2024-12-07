document.getElementById('usuarioError').style.display = 'none';
document.getElementById('nombreError').style.display = 'none';
document.getElementById('apellidosError').style.display = 'none';
document.getElementById('edadError').style.display = 'none';
document.getElementById('codPresaError').style.display = 'none';
document.getElementById('checkboxError').style.display = 'none';

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('castorForm').addEventListener('submit', function (event) {
        console.log('Validación activada');
        let valid = true;

        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');

        const usuario = document.getElementById('usuario').value.trim();
        if (usuario.length < 2) {
            document.getElementById('usuarioError').textContent = 'Usuario inválido, muy pocos carácteres.';
            document.getElementById('usuarioError').style.display = 'block';
            valid = false;
        }

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

        const codPresa = document.getElementById('codPresa').value.trim();
        if (codPresa.length !== 12) {
            document.getElementById('codPresaError').textContent = 'El código debe tener 12 carácteres.';
            document.getElementById('codPresaError').style.display = 'block';
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
