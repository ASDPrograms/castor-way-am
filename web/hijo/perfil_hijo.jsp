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
                    <a href="home_tutor.jsp" class = "a_nav"> 
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
                    <a class="a_nav" href="diario_tutor.jsp">
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

                        <a href="perfil_tutor.jsp"> 
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

            <div class="grid-container">
                <div class="item">
                    <%
                        session = request.getSession(false);

                        if (session != null && session.getAttribute("nombreUsuario") != null) {
                            String nombreUsuario = (String) session.getAttribute("nombreUsuario");
                            String codPresa = null;
                            String nombre = null;
                            String apellidos = null;
                            int edad = 0;
                            String etapaVida = null;
                            int ramitas = 0;
                            String imagenPerfil = null;
                            String fechaRegistro = null;

                            Base bd = new Base();
                            try {
                                bd.conectar();

                                // Consulta para obtener información del Kit usando el nombre de usuario
                                String strQ = "SELECT * FROM Kit WHERE nombreUsuario = ?";
                                PreparedStatement pstmt = bd.getConn().prepareStatement(strQ);
                                pstmt.setString(1, nombreUsuario);
                                ResultSet rs = pstmt.executeQuery();

                                if (rs.next()) {
                                    codPresa = rs.getString("codPresa");
                                    nombre = rs.getString("nombre");
                                    apellidos = rs.getString("apellidos");
                                    edad = rs.getInt("edad");
                                    etapaVida = rs.getString("etapaVida");
                                    ramitas = rs.getInt("ramitas");
                                    imagenPerfil = rs.getString("imagenPerfil");
                                    fechaRegistro = rs.getString("fechaRegistro");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                    %>

                    <p class="nombre"><%= nombre != null ? nombre : "No disponible"%> <%= apellidos != null ? apellidos : "No disponible"%></p>

                </div>
                <div class="item-codigo">
                    <p class="texto-codigo">Codigo présa:<br>
                        <span id="codigoPresa"><%= codPresa != null ? codPresa : "No disponible"%></span>

                    </p>
                    <div class="img-copiarCodigo" onclick="copiarCodigo(event)">
                        <img id="copiarIcon" class="Copiar" src="../img/icono_copiar.svg" alt="Copiar código">
                    </div>
                </div>
                <p class="texto-union">Se unió el <%= fechaRegistro != null ? fechaRegistro : "No disponible"%></p>

                <div class="item-codigo">
                    <div >
                        <p class ="texto-personal">Ver informacion personal<p> 
                    </div>
                    <div class="img-copiarCodigo" onclick="toggleVisibility()">
                        <img id="verIcon" class="Ver" src="../img/ojo.svg" alt="Ver informacion" ">
                    </div>     
                </div>
            </div>

            <div class="infoAdicional"  id="infoAdicional">

                <div class="info-item izquierda">
                    <p>Ramitas: <%= ramitas >= 0 ? ramitas : "No disponible"%></p>
                </div>
                <div class="info-item">
                    <p><%= (edad >= 0 ? edad + " años" : "No disponible")%></p>
                </div>
                <div class="info-item izquierda">
                    <img id="editarBoton" class="editarBoton" src="../img/editar_boton.svg" alt="Editar Información " ">
                </div>
            </div> <div class="line">
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

            </div>
        </div>
    </div>
    <script src="../codigo_js/codigo_javascript_hijo/js_perfil_hijo.js" type="text/javascript"></script>
</body>
</html>

