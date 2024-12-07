
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../estilos_css/estilos_formularios_sesion/css_inicio_sesion_hijo.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <title>Inicio de Sesión</title>
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
                                    <span class="PagPri">Inicio de sesión de <span class="titColorcito">Kit</span></span>
                                </div>
                            </div>
                            <p>Sino recuerdas algún dato, tu tutor los tiene en el apartado de "Información de mi Kit"<br>¡Sólo ingresa los siguientes campos y podrás estar de vuelta en CastorWay!</p>
                        </div>
                        <div class = "izquierda_forms">
                            <form id="castorForm" action="procesa_inicio_sesion_hijo.jsp" method="post" class="castor_form">
                                <label for="usuario">Nombre de usuario:</label>
                                <input type="text" id="usuario" name="usuario" value="<%= (session.getAttribute("usuarioGuardado") != null) ? session.getAttribute("usuarioGuardado") : ""%>">
                                <span class = "error" id = "usuarioError"></span>

                                <label for="contrasena">Código de Presa</label>
                                <input type="text" id="codPresa" name="codPresa">
                                <span class = "error" id = "codPresaError"></span>
                                <div class = "izquierda_tit">
                                    <div class="Texto_2">
                                        <div>
                                            <span class="PagPri2">¿No tienes una cuenta? - <a href="registro_hijo.jsp" style="color: var(--cafe)"><span class="textYaTienesCuenta">Regístrate ahora</span></a></span>
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
                <div class = "derecha">
                    <div class = "derecha_tit">
                        <div class="Texto_1">
                            <div>
                                <span class="PagPri">Bienvenido de vuelta a Castor<span class="titColorcito2">Way</span></span>
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
            </div>
        </section>
        <%
            String errorMsg = (String) session.getAttribute("error");
            if (errorMsg != null) {
                out.println("<p style='color:red;'>" + errorMsg + "</p>");
                session.removeAttribute("error");
                session.removeAttribute("usuarioGuardado");
            }
        %>

        <script src="../codigo_js/codigo_javascript_formularios_sesion/js_inicio_sesion_hijo.js" type="text/javascript"></script>
    </body>
</html>

