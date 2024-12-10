<%-- 
    Document   : nueva_nota_hijo
    Created on : 27 nov. 2024, 11:02:21
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_hijo/css_nueva_nota_hijo.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">
        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Diario - CastorWay</title>
    </head>
    <body>
        <nav class="sidebar">
            <div class="logo-section menu-item" id = "logoNavbar">
                <img src="../img/logo_letras_castorway.svg" alt="Logo" class="icon" id = "iconoNavLogo">
            </div>
            <div class="icon-section" id = "div_icon_section">
                <div class="menu-item" id = "div_nav_home">
                    <a href="home_hijo.jsp" class = "a_nav"> 
                        <img class="icon icon1" src="../img/icono_casita.svg">
                        <span class="textNav">Inicio</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="actividades_tutor.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="calendario_tutor.jsp">
                        <img class="icon icon1" src="../img/icono_calendario.svg">
                        <span class="textNav">Calendario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="diario_hijo.jsp">
                        <img class="icon icon1" src="../img/icono_diario.svg">
                        <span class="textNav">Diario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="chat_tutor.jsp">
                        <img class="icon icon1" src="../img/icono_chat.svg">
                        <span class="textNav">Chat</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="recompensas_tutor.jsp" class="a_nav">
                        <img class="icon icon1" src="../img/icono_recompensa.svg">
                        <span class="textNav">Recompensas</span>
                    </a>
                </div>
            </div>
            <div class="bottom-section">
                <div class="menu-item toggle">
                    <img class="icon icon1" src="../img/icono_MenuDesplegable.svg">
                </div>
                <div class="menu-item toggle">
                    <img class="icon icon1" src="../img/icono_setings.svg">
                </div>
            </div>
        </nav>
        <div class="content">
            <div class="secondary-nav">
                <div class = "izquierda-secondary-nav">
                    <a href="#">Información de tu kit </a>
                </div>
                <div class = "derecha-secondary-nav">
                    <a href="#"><img src="../img/iconito_notifiNotificacion.svg" class = "imgNavSecondary"></a>
                    <div class="sec-nav-perfil">
                        <%
                            session = request.getSession(false);

                            if (session != null && session.getAttribute("usuario") != null) {
                                String nombreUsuario = (String) session.getAttribute("usuario");

                        %>
                        <%                            Base bd = new Base();
                            try {
                                bd.conectar();

                                String strQ = "select * from Kit where nombreUsuario = ?";
                                PreparedStatement pstmt3 = bd.getConn().prepareStatement(strQ);
                                pstmt3.setString(1, nombreUsuario);
                                ResultSet rs = pstmt3.executeQuery();

                                int idKit = 0;
                                if (rs.next()) {
                                    idKit = rs.getInt("idKit");
                                }

                                String consult = "select * from Kit where idKit = ?";
                                PreparedStatement pstmt4 = bd.getConn().prepareStatement(consult);
                                pstmt4.setInt(1, idKit);
                                ResultSet r = pstmt4.executeQuery();

                                while (r.next()) {
                        %>
                        <p class = "second-nav-nombre"><%=rs.getString(3)%></p>
                        <%
                                }
                            } catch (Exception e) {
                            }
                        %>
                        <%
                            } else {
                                // Si no hay sesión o no hay correo electrónico en la sesión, redirigir al usuario a la página de inicio de sesión
                                response.sendRedirect("../formularios_sesion/inicio_sesion_tutor.jsp");
                            }
                        %>
                        <a href="perfil_hijo.jsp"> 
                            <img src="../img/icono_Perfil.svg" class="imgNavSecondary">
                        </a>
                    </div>
                </div>
            </div>
            <div class="container">
                <form action="procesa_nota_hijo.jsp" method="POST" id="subir_nota">
                    <div class="form-content">
                        <div class="diario">
                            <div class="div-diario tit">

                                <input type="text" name="titulo-nota" placeholder="Titulo" id="titulo-nota">
                                <span class="error" id="tituloError"></span>
                            </div>

                            <div class="div-diario info">
                                <textarea name="infoNota-nota" id="infoNota" placeholder="Escribe aquí..."></textarea>
                                <span class="error" id="infoError"></span>
                            </div>

                        </div>
                        <div class="estado-nota">
                            <div class="item-EdoNot-privacidad" style="cursor: pointer;" id="item-EdoNot-privacidad">
                                <div class="img-nota-priv">
                                    <img src="../img/candado_cerrado.svg" class="candado_privacidad_nota" alt="Candado" id="privacidad-nota">
                                </div>
                                <div class="boton-nota-priv">
                                    <span id="estado-privacidad">Privado</span>
                                </div>
                                <input type="hidden" id="valor-privacidad" name="privacidad_nota" value="1">
                            </div>
                            <div class="item-EdoNot">
                                <div class="item-animo-img">
                                    <img id="estado-animo-img" src="../img/estado_animo_img/normal.svg" class="castor_normal">
                                </div>
                                <div class="item-animo-animo">
                                    <select id="feel_nota" class="feel_nota" name="feel_nota">
                                        <option value="" disabled selected>Estado</option>
                                        <option value="poderoso">Poderoso</option>
                                        <option value="normal">Normal</option>
                                        <option value="asustado">Asustado</option>
                                        <option value="paniqueado">Paniqueado</option>
                                        <option value="confundido">Confundido</option>
                                        <option value="apenado">Apenado</option>
                                        <option value="ansioso">Ansioso</option>
                                        <option value="enfermo">Enfermo</option>
                                        <option value="entusiasmado">Entusiasmado</option>
                                        <option value="llorando">Llorando</option>
                                        <option value="lleno_de_odio">Lleno de Odio</option>
                                        <option value="Cansado">Cansado</option>
                                        <option value="aburrido">Aburrido</option>
                                        <option value="aceptado">Aceptado</option>
                                        <option value="agresivo">Agresivo</option>
                                        <option value="alegre">Alegre</option>
                                        <option value="angelical">Angelical</option>
                                        <option value="apatico">Apatico</option>

                                        <option value="asqueado">Asqueado</option>
                                        <option value="bromista">Bromista</option>
                                        <option value="cool">Cool</option>
                                        <option value="divertido">Divertido</option>
                                        <option value="enamorado">Enamorado</option>
                                        <option value="herido">Herido</option>
                                        <option value="inseguro">Inseguro</option>

                                        <option value="intelectual">Intelectual</option>
                                        <option value="mareado">Mareado</option>
                                        <option value="pensativo">Pensativo</option>
                                        <option value="rechazado">Rechazado</option>
                                        <option value="solo">Solo</option>
                                    </select>
                                </div>
                            </div>

                            <div class="div-diario btn">
                                <button type="submit" class="btn-crear-nota">Crear</button>
                            </div>
                        </div>

                    </div>

                </form>
            </div>

        </div>
        <script>
            document.getElementById('feel_nota').addEventListener('change', function () {
                const selectedValue = this.value;
                const image = document.getElementById('estado-animo-img');

                console.log('Valor seleccionado:', selectedValue);

                if (selectedValue === 'poderoso') {
                    image.src = '../img/estado_animo_img/poderoso.svg';
                } else if (selectedValue === 'paniqueado') {
                    image.src = '../img/estado_animo_img/paniqueado.svg';
                } else if (selectedValue === 'normal') {
                    image.src = '../img/estado_animo_img/normal.svg';
                } else if (selectedValue === 'llorando') {
                    image.src = '../img/estado_animo_img/llorando.svg';
                } else if (selectedValue === 'lleno_de_odio') {
                    image.src = '../img/estado_animo_img/lleno_de_odio.svg';
                } else if (selectedValue === 'entusiasmado') {
                    image.src = '../img/estado_animo_img/entusiasmado.svg';
                } else if (selectedValue === 'enfermo') {
                    image.src = '../img/estado_animo_img/enfermo.svg';
                } else if (selectedValue === 'confundido') {
                    image.src = '../img/estado_animo_img/confundido.svg';
                } else if (selectedValue === 'asustado') {
                    image.src = '../img/estado_animo_img/asustado.svg';
                } else if (selectedValue === 'apenado') {
                    image.src = '../img/estado_animo_img/apenado.svg';
                } else if (selectedValue === 'ansioso') {
                    image.src = '../img/estado_animo_img/ansioso.svg';
                } else if (selectedValue === 'agresivo') {
                    image.src = '../img/estado_animo_img/agresivo.svg';
                } else if (selectedValue === 'Cansado') {
                    image.src = '../img/estado_animo_img/Cansado.svg';
                } else if (selectedValue === 'aburrido') {
                    image.src = '../img/estado_animo_img/aburrido.svg';
                } else if (selectedValue === 'aceptado') {
                    image.src = '../img/estado_animo_img/aceptado.svg';
                } else if (selectedValue === 'alegre') {
                    image.src = '../img/estado_animo_img/alegre.svg';
                } else if (selectedValue === 'angelical') {
                    image.src = '../img/estado_animo_img/angelical.svg';
                } else if (selectedValue === 'apatico') {
                    image.src = '../img/estado_animo_img/apatico.svg';
                } else if (selectedValue === 'asqueado') {
                    image.src = '../img/estado_animo_img/asqueado.svg';
                } else if (selectedValue === 'bromista') {
                    image.src = '../img/estado_animo_img/bromista.svg';
                } else if (selectedValue === 'cool') {
                    image.src = '../img/estado_animo_img/cool.svg';
                } else if (selectedValue === 'divertido') {
                    image.src = '../img/estado_animo_img/divertido.svg';
                } else if (selectedValue === 'enamorado') {
                    image.src = '../img/estado_animo_img/enamorado.svg';
                } else if (selectedValue === 'herido') {
                    image.src = '../img/estado_animo_img/herido.svg';
                } else if (selectedValue === 'inseguro') {
                    image.src = '../img/estado_animo_img/inseguro.svg';
                } else if (selectedValue === 'intelectual') {
                    image.src = '../img/estado_animo_img/intelectual.svg';
                } else if (selectedValue === 'mareado') {
                    image.src = '../img/estado_animo_img/mareado.svg';
                } else if (selectedValue === 'pensativo') {
                    image.src = '../img/estado_animo_img/pensativo.svg';
                } else if (selectedValue === 'rechazado') {
                    image.src = '../img/estado_animo_img/rechazado.svg';
                } else if (selectedValue === 'solo') {
                    image.src = '../img/estado_animo_img/solo.svg';
                }
            });

        </script>
        <script src="../codigo_js/codigo_javascript_hijo/js_nueva_nota_hijo.js" type="text/javascript"></script>
    </body>
</html>