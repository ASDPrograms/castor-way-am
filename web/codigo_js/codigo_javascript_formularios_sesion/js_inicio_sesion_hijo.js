document.getElementById('usuarioError').style.display = 'none';

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('castorForm').addEventListener('submit', function (event) {
        let valid = true;

        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(error => error.textContent = '');

        const usuario = document.getElementById('usuario').value.trim();
        if (usuario.length < 2) {
            document.getElementById('usuarioError').textContent = 'Usuario inválido, muy pocos carácteres.';
            document.getElementById('usuarioError').style.display = 'block';
            valid = false;
        }
        if (!valid) {
            event.preventDefault();
        }
    });
});
