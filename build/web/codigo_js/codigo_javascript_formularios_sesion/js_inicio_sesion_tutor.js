document.getElementById('correoError').style.display = 'none';
document.getElementById('contrasenaError').style.display = 'none';

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('correo').addEventListener('input', function () {
        this.value = this.value.toLowerCase(); 
    });
    document.getElementById('castorForm').addEventListener('submit', function (event) {
        let valid = true;

        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');

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


        if (!valid) {
            event.preventDefault();
        }
    });
});
