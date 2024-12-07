
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../estilos_css/estilos_formularios_sesion/css_registro_tutor.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>  
        <div id="toast">
            <span id="toastMessage"></span>
        </div>

        <%
            String mensajeError = (String) session.getAttribute("error");
            if (mensajeError != null) {
        %>
        <script>
            const toast = document.getElementById('toast');
            toast.textContent = "<%= mensajeError%>";
            toast.style.display = 'block';
            setTimeout(() => {
                toast.style.display = 'none';
            }, 7000);
        </script>
        <%
                session.removeAttribute("error");
            }
        %>

        <section class="content">
            <div class="container">
                <div class = "izquierda">
                    <div class = "divLogito">
                        <a href="../formularios_sesion/eleccion_perfil_registro.html" class="nav__logo">
                            <img src="../img/icono_completo_cafe_azul.svg" >
                        </a>
                    </div>
                    <div class="izquierda_cont">
                        <div class = "izquierda_tit">
                            <div class="Texto_1">
                                <div>
                                    <span class="PagPri">Registro de <span class="titColorcito">Castor</span></span>
                                </div>
                            </div>
                            <p>Ingresa tus datos como tutor</p>
                        </div>
                        <div class = "izquierda_forms">
                            <form id="castorForm" action="procesa_registro_tutor.jsp" method="post" class="castor_form">
                                <label for="nombre">Nombre/s:</label>
                                <input type="text" id="nombre" name="nombre" >
                                <span class = "error" id = "nombreError"></span>

                                <label for="apellidos">Apellidos:</label>
                                <input type="text" id="apellidos" name="apellidos" >
                                <span class = "error" id = "apellidosError"></span>

                                <label for="edad">Edad:</label>
                                <input type="number" id="edad" name="edad" >
                                <span class = "error" id = "edadError"></span>

                                <label for="correo">Correo Electrónico:</label>
                                <input type="email" id="correo" name="correo" >
                                <span class = "error" id = "correoError"></span>

                                <label for="contrasena">Contraseña:</label>
                                <input type="password" id="contrasena" name="contrasena" >
                                <span class = "error" id = "contrasenaError"></span>

                                <div class="checkbox-container">
                                    <input type="checkbox" id="cbox1" value="first_checkbox" /> 
                                    <label for="cbox1">
                                        <p><u>Acepto los términos y condiciones de uso</u></p>
                                    </label>
                                </div>
                                <span class = "error" id = "checkboxError"></span>
                                <div class = "izquierda_tit">
                                    <div class="Texto_2">
                                        <div>
                                            <span class="PagPri2">¿Ya tienes una cuenta? - <a href="inicio_sesion_tutor.jsp" style="color: var(--cafe)"><span class="textYaTienesCuenta">Inicia sesión ahora</span></a></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="item_3_1">
                                    <button class="Comienza" type="submit">¡Comienza ya!</button>
                                </div>
                            </form>
                        </div> 
                    </div>

                </div>
                <div class = "derecha">
                    <div class = "derecha_tit">
                        <div class="Texto_1">
                            <div>
                                <span class="PagPri">Bienvenido a Castor<span class="titColorcito2">Way</span></span>
                            </div>
                        </div>
                    </div>
                    <div class = "divImg">
                        <img src="../img/Castor.svg" id = "imgCastor">
                    </div>
                    <div class = "derecha_tit">
                        <div class="Texto_1" id = "textDerecha">
                            <p>¡Estás cada vez más cerca de unirte a CastorWay!</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="../codigo_js/codigo_javascript_formularios_sesion/js_registro_tutor.js" type="text/javascript"></script>
    </body>
</html>
