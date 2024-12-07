<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_hijo/css_home_hijo.css" rel="stylesheet" type="text/css"/>
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
    
        <%
    session = request.getSession(false);
    String usuario = (String) session.getAttribute("usuario");

    if (session == null || usuario == null) {
        response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
        return; // Stop further processing
    }
%>
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
                    <a href="actividades_hijo.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="calendario_hijo.jsp">
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
                    <a class="a_nav" href="chat_hijo.jsp">
                        <img class="icon icon1" src="../img/icono_chat.svg">
                        <span class="textNav">Chat</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="recompensas_hijo.jsp" class="a_nav">
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
                    <a href="#">Bienvenida</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <a href="#"><img src="../img/iconito_notifiNotificacion.svg"></a>
                    <div class="sec-nav-perfil">
                        <a href="#"><%=usuario%></a>
                        <a href=""> <img src="../img/icono_Perfil.svg"></a>
                    </div>
                </div>
            </div>
            <div class="Div-Principal">
                <div class="sec1">
                    <div class="section1">
                        <div class="item2">
                            <div class="item2-3"><p>Accesos</p></div>
                        </div>
                        <div class="item4"></div>
                        <div class="item5"></div>
                        <div class="Raudy">
                            <div class="item6"><p>Raudy Dice</p></div>
                            <div class="item7"><p>Frases de acuerdo al tipo de usuario(consejos, recomendaciones  motivacion)</p></div>
                            <div class="item8"><img src="../img/Castor.svg"></div>
                        </div>
                    </div></div>
                <div class="linea"></div>
                <div class="sec2">
                    <div class="section2">
                        <div class="obj-4">
                            <div class="hijos">Acceso Chat</div>

                        </div>
                        <div class="obj-5">
                            <div class="stats">Estadisticas</div>
                            <div class="estadisticas"><img src="../img/Stats.svg"></div>
                        </div>
                    </div></div></div>
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
                        <%                           
                            Base bd = new Base();
                            try {
                                bd.conectar();

                                String consult = "select * from Kit where nombreUsuario = ?";
                                PreparedStatement pstmt4 = bd.getConn().prepareStatement(consult);
                                pstmt4.setString(1, nombreUsuario);
                                ResultSet r = pstmt4.executeQuery();

                                while (r.next()) {
                        %>
                        <p class = "second-nav-nombre"><%=r.getString("nombreUsuario")%></p>
                        <%
                                }
                            } catch (Exception e) {
                            }
                        %>
                        <%
                            } else {
                                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
                            }
                        %>
                        <a href="perfil_hijo.jsp"> 
                            <img src="../img/icono_Perfil.svg" class="imgNavSecondary">
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../codigo_js/codigo_javascript_hijo/js_home_hijo.js" type="text/javascript"></script>
</body>
</html>
