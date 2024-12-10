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
        <link href="../estilos_css/estilos_hijo/css_chat_hijo.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">
        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Chat - CastorWay</title>
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
            } else {
                try {
                    int idKit = 0;
                    Base bd = new Base();
                    bd.conectar();

                    String nombreUsuario = (String) session.getAttribute("usuario");
                    String query = "SELECT * FROM Kit WHERE nombreUsuario = ?";
                    PreparedStatement pstmt7 = bd.getConn().prepareStatement(query);
                    pstmt7.setString(1, nombreUsuario);
                    ResultSet rs = pstmt7.executeQuery();

                    if (rs.next()) {
                        idKit = rs.getInt(1);
                        String idKitSting = String.valueOf(idKit);
                        session.setAttribute("idKit", idKitSting);
                    }
                } catch (Exception e) {
                }

            }
        %>
        <nav class="sidebar">
            <div class="logo-section menu-item" id = "logoNavbar">
                <img src="../img/logo_letras_castorway.svg" alt="Logo" class="icon" id = "iconoNavLogo">
            </div>
            <div class="icon-section">
                <div class="menu-item">
                    <a href="home_hijo.jsp" class = "a_nav"> 
                        <img class="icon icon1" src="../img/icono_casita.svg">
                        <span class="textNav">Inicio</span>
                    </a>
                </div>
                <div class="menu-item" id = "div_nav_home">
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
                    <a style="display: flex; padding-bottom: 0;" id="text-tit-act-sec-nav">Actividades</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <%
                        session = request.getSession(false);

                        if (session == null || session.getAttribute("usuario") == null) {
                            String nombreUsuario = (String) session.getAttribute("usuario");
                    %>
                    <%                            Base bd = new Base();
                        try {
                            bd.conectar();

                            String consult2 = "select * from Kit where nombreUsuario = ?";
                            PreparedStatement pstmt5 = bd.getConn().prepareStatement(consult2);
                            pstmt5.setString(1, nombreUsuario);
                            ResultSet r2 = pstmt5.executeQuery();
                            while (r2.next()) {
                    %>
                    <div style="display: flex;">
                        <img src="../img/hojaCongelada.svg">
                        <p class = "second-nav-hojas-congeladas"><%=r2.getString("hojasCongeladas")%></p>
                    </div>
                    <div style="display: flex;">
                        <img src="../img/icono_ramita.svg">
                        <p class = "second-nav-ramitas"><%=r2.getString("ramitas")%></p>
                    </div>
                    <%
                        }
                    %>
                    <%
                        } catch (Exception e) {
                        }
                    %>
                    <%} else {
                    %>
                    <div style="display: flex;">
                        <img src="../img/hojaCongelada.svg" style="flex: 1;">
                        <p id="texto-hojas-cong-secondary-nav" class = "second-nav-hojas-congeladas"style="flex: 1;">0</p>
                    </div>
                    <div style="display: flex;">
                        <img src="../img/icono_ramita.svg"style="flex: 1;">
                        <p id="texto-ramitas-secondary-nav" class = "second-nav-ramitas" style="flex: 1;">0</p>
                    </div>
                    <%
                        }
                    %>
                    <a id="icono-notificaciones-secondary-nav" href="" style="display: flex;"><img src="../img/iconito_notifiNotificacion.svg" class = "imgNavSecondary"></a>
                    <a id="icono-perfil-secondary-nav" href="perfil_hijo.jsp" style="display: flex;"> <img src="../img/icono_Perfil.svg" class = "imgNavSecondary"></a>
                </div>
            </div>
            <div class="cuerpo-actividades">
                <div class="chat-container">
                    <div class="chat-body">
                        <%
                            String nombreUsuario = (String) session.getAttribute("usuario");
                            Base bd = new Base();
                            try {
                                bd.conectar();

                                String consult2 = "select * from Kit where nombreUsuario = ?";
                                PreparedStatement pstmt5 = bd.getConn().prepareStatement(consult2);
                                pstmt5.setString(1, nombreUsuario);
                                ResultSet r2 = pstmt5.executeQuery();

                                String codPresa = "";
                                int idKit = 0;
                                if (r2.next()) {
                                    idKit = r2.getInt("idKit");
                                    codPresa = r2.getString("codPresa");
                                }

                                String consult3 = "select * from Castor where codPresa = ?";
                                PreparedStatement pstmt6 = bd.getConn().prepareStatement(consult3);
                                pstmt6.setString(1, codPresa);
                                ResultSet r3 = pstmt6.executeQuery();

                                int idCastor = 0;
                                String nombre = "";
                                if (r3.next()) {
                                    idCastor = r3.getInt("idCastor");
                                    nombre = r3.getString("nombre");
                                }
                        %>
                        <div class="chat-messages">
                            <div class="contenido-mensajes" id="contenido-mensajes">
                                <p>Chat con: <%= nombre%></p>
                                <%

                                    try {
                                        bd.conectar();

                                        String consultaMensajes = "SELECT * FROM chat WHERE (idKit = ? AND idCastor = ?) ORDER BY fechaEnvio ASC";
                                        PreparedStatement pstmtMensajes = bd.getConn().prepareStatement(consultaMensajes);
                                        pstmtMensajes.setInt(1, idKit);
                                        pstmtMensajes.setInt(2, idCastor);

                                        ResultSet rsMensajes = pstmtMensajes.executeQuery();
                                        while (rsMensajes.next()) {
                                            String emisor = rsMensajes.getString("emisor");
                                            String mensaje = rsMensajes.getString("contenido");
                                            String claseMensaje = emisor.equals("Kit") ? "mensaje-enviado" : "mensaje-recibido";

                                %>
                                <div class="mensaje <%= claseMensaje%>">
                                    <p><%= mensaje%></p>
                                </div>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.print("Error cargando mensajes: " + e.getMessage());
                                    }
                                %>
                            </div>
                            <div class="chat-input">
                                <%
                                %>
                                <input value="<%= idCastor%>" name="idCastor" type="hidden">
                                <input value="<%= idKit%>" name="idKit" type="hidden">
                                <input value="Kit" name="emisor" type="hidden">
                                <%

                                    } catch (Exception e) {
                                        out.print(e.getMessage());
                                    }
                                %>
                                <textarea name="txtMsj" id="inputMsj" placeholder="Escribe un mensaje..."></textarea>
                                <button type="submit" id="btnEnviarMsj">Enviar</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <script src="../codigo_js/codigo_javascript_hijo/js_chat_hijo.js" type="text/javascript"></script>
    </body>
</html>

