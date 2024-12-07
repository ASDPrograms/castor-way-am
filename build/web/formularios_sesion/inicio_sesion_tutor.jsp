
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../estilos_css/estilos_formularios_sesion/css_inicio_sesion_tutor.css" rel="stylesheet" type="text/css"/>
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
                // Limpia el mensaje de error de la sesión después de mostrarlo
                session.removeAttribute("error");
            }
        %>

        <section class="content">
            <div class="container">
                <div class = "derecha">
                    <div class = "divLogito">
                        <a href="../formularios_sesion/eleccion_perfil_registro.html" class="nav__logo">
                            <img src="../img/icono_completo_cafe_azul.svg" >
                        </a>
                    </div>
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
                            <p>¡Estás cada vez más cerca de regresar a CastorWay!</p>
                        </div>
                    </div>
                </div>
                <div class = "izquierda">
                    <div class="izquierda_cont">
                        <div class = "izquierda_tit">
                            <div class="Texto_1">
                                <div>
                                    <span class="PagPri">Inicio de sesión de <span class="titColorcito">Castor</span></span>
                                </div>
                            </div>
                            <p>Ingresa tus datos como tutor</p>
                        </div>
                        <div class = "izquierda_forms">
                            <form id="castorForm" action="procesa_inicio_sesion_tutor.jsp" method="post" class="castor_form">
                                <label for="correo">Correo Electrónico:</label>
                                <input type="email" id="correo" name="correo" value="<%= (session.getAttribute("correoGuardado") != null) ? session.getAttribute("correoGuardado") : ""%>">
                                <span class = "error" id = "correoError"></span>

                                <label for="contrasena">Contraseña:</label>
                                <input type="password" id="contrasena" name="contrasena" >
                                <span class = "error" id = "contrasenaError"></span>

                                <div class = "izquierda_tit">
                                    <div class="Texto_2">
                                        <div>
                                            <span class="PagPri2">¿No tienes una cuenta? - <a href="registro_tutor.jsp" style="color: var(--cafe)"><span class="textYaTienesCuenta">Regístrate ahora</span></a></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="item_3_1">
                                    <button class="Comienza" type="submit">¡Ingresa ahora!</button>
                                </div>
                            </form>
                        </div> 
                    </div>

                </div>
            </div>
        </section>
        <%
            String errorMsg = (String) session.getAttribute("error");
            if (errorMsg != null) {
                out.println("<p style='color:red;'>" + errorMsg + "</p>");
                session.removeAttribute("error");
                session.removeAttribute("correoGuardado");
            }
        %>

        <script src="../codigo_js/codigo_javascript_formularios_sesion/js_inicio_sesion_tutor.js" type="text/javascript"></script>
    </body>
</html>
