<%-- 
    Document   : perfil_hijo
    Created on : 22 oct. 2024, 07:15:58
    Author     : Usuario
--%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_hijo/css_perfil_hijo.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">

        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Incio - CastorWay</title>
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
            <div class="perfil">
                <img class="perfil-fondo" src="../img/fondo_perfil.svg">
                <div class="perfil_miniatura">
                    <img class="perfil-miniatura" src="../img/icono_Perfil.svg">
                    <div class="editar-perfil-miniatura">
                        <img class="editar-perfil" src="../img/lapiz_edicion.svg">
                    </div>
                </div>
            </div> 
            <div class="content1">
                <div class="item">
                    <%
                        session = request.getSession(false);

                        if (session != null && session.getAttribute("usuario") != null) {
                            String nombreUsuario = (String) session.getAttribute("usuario");

                    %>
                    <%                        
                        String nombre = null;
                        String apellidos = null;
                        int edad = 0;
                        String fechaRegistro = null;
                        int ramitas = 0;
                        int idKit = 0;

                        Base bd = new Base();
                        try {
                            bd.conectar();

                            String strQ = "SELECT *  FROM Kit WHERE nombreUsuario = ?";
                            PreparedStatement pstmt = bd.getConn().prepareStatement(strQ);
                            pstmt.setString(1, nombreUsuario);
                            ResultSet rs = pstmt.executeQuery();

                            if (rs.next()) {
                                ramitas = rs.getInt("ramitas");
                                nombre = rs.getString("nombre");
                                apellidos = rs.getString("apellidos");
                                edad = rs.getInt("edad");
                                fechaRegistro = rs.getString("fechaRegistro");

                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    <p class="nombre"><%= nombre != null ? nombre : "No disponible"%> <%= apellidos != null ? apellidos : "No disponible"%></p>
                    <p class="texto-user"><%= nombreUsuario != null ? nombreUsuario : "No disponible"%></p>
                </div>
                <div class="row-info">
                    <p class="texto-union">Se unió el <%= fechaRegistro != null ? fechaRegistro : "No disponible"%></p>
                    <div class="item-codigo">
                        <div>
                            <p class="texto-personal">Ver informacion personal</p> 
                        </div>
                        <div class="img-copiarCodigo" onclick="toggleVisibility()">
                            <img id="verIcon" class="Ver" src="../img/ojo.svg" alt="Ver informacion" />
                        </div>
                    </div>
                </div>
                 <div class="infoAdicional"  id="infoAdicional">
                <div class="info-item">
                    <p>Ramitas: <%= ramitas >= 0 ? ramitas : "No disponible"%></p>
                </div>
                <div class="info-item-izquierda">
                    
                    <p><%= (edad >= 0 ? edad + " años " : "No disponible")%></p>
                </div>
                <div></div>
                <div class="info-item-izquierda">
                    <img id="editarBoton" class="editarBoton" src="../img/editar_boton.svg" alt="Editar Información ">
                </div>
            </div>
            <div id="modalPremio" class="modal">
                <div class="modal-content">
                    <p class="titulo-modal-content">Editar información</p>
                    <form action="editar_informacion_perfil_hijo.jsp" method="POST" id="info_actualizada">
                        <input type="hidden" name="idCastor" value="<%= idKit%>">
                        <div class="item-modal-content">                      
                            <label>Nombre de usuario</label>
                            <input type="text" name="nombreUsuario-acutalizado" value="<%= nombreUsuario%>" id="nombreUsuario-acutalizado">
                            <span class = "error" id = "nombreError"></span>
                        </div>

                        <div class="item-modal-content-oper">
                            <button type="button" onclick="cerrarModal()" class="btn-cancelar-modal" >Cancelar</button>
                            <button type="submit" class="btn-crear-modal">Actualizar</button>
                        </div>
                    </form>
                </div>

            </DIV>
            </div>
           <div class="line">
                <hr>
            </div>
            <div class="estadisticas-container">
                <div class="tit">
                    <p class="estadistica"> Estadísticas<p>
                </div>
                <div class="estadisticas">
                    <div class="dezplazamiento left" id="flecha-izquierda" >
                        <img class="img-dezplazameinto" src="../img/flecha_desplazamiento.svg"  >
                    </div>
                    <div class="card-container" id="card-container">
                        <div class="card">
                            <div class="item-card">
                            </div>
                            <p class="texto-racha">Días de racha</p>
                            <p class="numero">30</p>
                        </div>
                        <div class="card">
                            <div class="item-card">
                            </div>
                            <p class="texto-racha">Tareas Completadas</p>
                            <p class="numero">20</p>
                        </div>
                        <div class="card">
                            <div class="item-card">
                            </div>
                            <p class="texto-racha">Mejor Habito</p>
                            <p class="numero">Lavar</p>
                        </div>
                        <div class="card">
                            <div class="item-card">
                            </div>
                            <p class="texto-racha">Recompensa más cercana </p>
                            <p class="numero">Play 5</p>
                        </div>
                        <div class="dezplazamiento right" id="flecha-derecha">
                            <img class="img-dezplazameinto" src="../img/Flecha_dezplazamientoRight.svg">
                        </div>
                    </div>
                </div>
            </div>
            <div class="tit">
                <p class="estadistica"> Insignias<p>
            </div>   
            <div class="insignias">
                <div class="dezplazamiento left" id="flecha-izquierda-insignia" >
                    <img class="img-dezplazameinto" src="../img/flecha_desplazamiento.svg"  >
                </div>
                <div class="card-container-insignia" id="card-container-insignia">

                    <div class="card-insignia">
                        <img class="img-insignia-arbol" src="../img/insignia-arbol.svg">
                    </div>
                    <div class="card-insignia">
                        <img class="img-insignia-plateada" src="../img/insignia-plata.svg">
                    </div>
                    <div class="card-insignia">
                        <img class="img-insignia-racha" src="../img/insignia-racha.svg">
                    </div>
                    <div class="card-insignia">
                        <img class="img-insignia-simple" src="../img/insignia-simple.svg">
                    </div>
                    <div class="dezplazamiento right" id="flecha-derecha-insignia">
                        <img class="img-dezplazameinto" src="../img/Flecha_dezplazamientoRight.svg">
                    </div>
                </div>
            </div>  
            <div class="tit">
                <p class="estadistica"> Racha<p>
            </div>
            <div class ="container-racha">
                <div class="item-racha">
                    <div class="item-racha-left">
                        <img class="img-estadistica" src="../img/estadistica.svg">
                    </div>
                    <div class="item-racha-left">
                        <img class="img-estadistica-ramita" src="../img/ramita_estadistica.svg">
                    </div>
                </div>
            <%
            } else {
                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
            }
            %>
        </div>

        <script src="../codigo_js/codigo_javascript_hijo/js_perfil_hijo.js" type="text/javascript"></script>
    </body>
</html>