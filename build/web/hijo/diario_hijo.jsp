
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_hijo/css_diario_hijo.css" rel="stylesheet" type="text/css"/>
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
      
            <div class="body-notes">
                <div class="primero">
                    <img src="../img/fondo_perfil.svg" class="imgFondoPerfil">
                    <div class="privacidad">
                        <div class="tipo-nota">
                            <p>Notas privadas</p>
                        </div>
                        <div class="tipo-nota">
                            <div class="tipo-nota-img rigt"> 
                                <img src="../img/flecha_desplazamiento.svg" class="img-flecha-des rigt"  
                                     onclick="window.location.href = 'diario_hijo.jsp';">
                            </div>
                            <div class="tipo-nota-img left"> 
                                <img src="../img/Flecha_dezplazamientoRight.svg" class="img-flecha-des left"  
                                     onclick="window.location.href = 'diario_notasPublic.jsp';">
                            </div> 
                        </div>
                    </div>
                </div>
                <div class="segundo">
                    <a href="nueva_nota_hijo.jsp"> 
                        <img src="../img/MasHijo.svg" class="imgMas">
                    </a>
                </div>
                <div class="tercero">
                    <div class="seccion-notas" id="seccion-not-this-month"> 

                        <div class="notas-thismonth-sinDesplegar" id="notas-thismonth-sinDesplegar"
                             onclick="desplegar()">
                            <div class="texto-nota-this-month">
                                Este mes
                            </div>
                            <div class="notas-this-mont-flecha">
                                <img src="../img/flechita-abajo.svg" class="imgFlechaDesplegar">
                            </div>
                        </div>
                        <div class="notas-thismonth-Desplegado" id="notas-thismonth-Desplegado" style="display: none;">
                            <%
                              session = request.getSession(false);

                              if (session != null && session.getAttribute("usuario") != null) {
                                  String nombreUsuario = (String) session.getAttribute("usuario");
                                  Base bd = new Base();
            
                                  try {
                                      bd.conectar();

                                           
                                      String queryIdKit = "SELECT idKit FROM Kit WHERE nombreUsuario = ?";
                                      PreparedStatement stmt = bd.getConn().prepareStatement(queryIdKit);
                                      stmt.setString(1, nombreUsuario);
                                      ResultSet rs = stmt.executeQuery();

                                      int idKit = -1;
                                      if (rs.next()) {
                                          idKit = rs.getInt("idKit");
                                      }

                                      if (idKit == -1) {
                                          throw new Exception("El usuario no está registrado.");
                                      }

                                      String queryNotasPrivadas = "SELECT * FROM diario WHERE idKit = ? AND privacidad = 1";
                                      stmt.clearParameters(); 
                                      stmt = bd.getConn().prepareStatement(queryNotasPrivadas);
                                      stmt.setInt(1, idKit);
                                      rs = stmt.executeQuery();

                                            
                                      Calendar calendar = Calendar.getInstance();
                                      int currentMonth = calendar.get(Calendar.MONTH) + 1;  // Mes actual (1-12)
                                      int currentYear = calendar.get(Calendar.YEAR);  // Año actual

                                      // Verifica si se encontraron notas
                                      boolean found = false;
                                      while (rs.next()) {
                    
                                          String titulo = rs.getString("titulo");
                                          String info = rs.getString("info");
                                          String imgPrivacidad = rs.getString("imgPrivacidad");
                                          String imgSentimiento = rs.getString("imgSentimiento");
                                          Timestamp diaCreacion = rs.getTimestamp("diaCreacion");

                                             
                                          Calendar noteCalendar = Calendar.getInstance();
                                          noteCalendar.setTime(diaCreacion);

                                          int noteMonth = noteCalendar.get(Calendar.MONTH) + 1;  
                                          int noteYear = noteCalendar.get(Calendar.YEAR);  

                                          if (noteMonth == currentMonth && noteYear == currentYear) {
                                              found = true;
                                                    
                            %>
                            <div class="contenedor-cada-nota" id="contenedor-cada-nota" 
                                 data-titulo="<%= titulo %>" 
                                 data-info="<%= info %>" 
                                 data-fecha="<%= diaCreacion %>" 
                                 data-sentimiento="<%= imgSentimiento %>">
                                
                                <div class="nota-desplegada-sentimiento-img">
                                    <img id="estado-animo-img"
                                         src="../img/estado_animo_img/<%= imgSentimiento%>.svg" 
                                         class="imgSentimiento">
                                </div>
                                <div class="nota-desplegada-titulo">
                                    <p><%= titulo%></p>
                                </div>
                                <div class="nota-desplegada-fecha">
                                    <p><%= diaCreacion%></p>
                                </div>
                            </div>
                            <hr class="linea-divisoria">
                            <div id="modal-Notas" class="modal-Notas" style="display: none;">
                                <div class="modal-contenido">
                                    <div class="modal-contenido-nota">
                                        <div class="textos-modal-nota">
                                            <div class="titulo-modal-content">
                                                <p id="modal-titulo"></p>
                                            </div>
                                            <div class="date-modal-content">
                                                <p id="modal-fecha"></p>
                                            </div>
                                            <div class="texto-modal-content">
                                                <p id="modal-info"></p>
                                            </div>
                                        </div>
                                        <div class="img-feel-modal-content">
                                            <img id="modal-img-sentimiento" class="imgSentimientoModal">
                                        </div>
                                    </div>
                                    <div class="item-modal-content-oper">
                                        <button type="button" onclick="cerrarModal()" class="btn-cancelar-modal">Cancelar</button>
                                        <a href="editar_nota_hijo.jsp?titulo=<%= titulo %>&fecha=<%= diaCreacion %>&info=<%= info %>&sentimiento=<%= imgSentimiento %>">
            <img class="editar-perfil" src="../img/lapiz_edicion.svg">
        </a>
                                    </div>
                                </div>
                            </div>

                            <%
                                        }
                                    }
                                    // Si no se encontraron notas, mostrar un mensaje
                                    if (!found) {
                                        out.println("<p>No hay notas privadas este mes.</p>");
                                    }
                                } catch (Exception e) {
                                     out.println("Error: " + e.getMessage() + "<br>");
            e.printStackTrace();
                                } finally {
                                    bd.cierraConexion(); 
                                }
                            } else {
                                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
                            }
                            %>
                        </div>
                    </div>

                    <!-- mes pasado -->
                    <div class="seccion-notas" id="seccion-not-ant-month"> 
                        <div id="notas-antmonth-sinDesplegar" onclick="desplegar2()">
                            <div class="texto-nota-ant-month">
                                Mes Anterior
                            </div>
                            <div class="notas-ant-mont-flecha">
                                <img src="../img/flechita-abajo.svg" class="imgFlechaDesplegar2">
                            </div>
                        </div>
                        <div id="notas-antmonth-Desplegado" style="display: none;">
                            <%
session = request.getSession(false);

if (session != null && session.getAttribute("usuario") != null) {
    String nombreUsuario = (String) session.getAttribute("usuario");
    Base bd = new Base();

    try {
        bd.conectar();

        // Obtener el idKit del usuario
        String queryIdKit = "SELECT idKit FROM Kit WHERE nombreUsuario = ?";
        PreparedStatement stmt = bd.getConn().prepareStatement(queryIdKit);
        stmt.setString(1, nombreUsuario);
        ResultSet rs = stmt.executeQuery();

        int idKit = -1;
        if (rs.next()) {
            idKit = rs.getInt("idKit");
        }

        if (idKit == -1) {
            throw new Exception("El usuario no está registrado.");
        }

        // Obtener todas las notas privadas
        String queryNotasPrivadas = "SELECT * FROM diario WHERE idKit = ? AND privacidad = 1";
        stmt = bd.getConn().prepareStatement(queryNotasPrivadas);
        stmt.setInt(1, idKit);
        rs = stmt.executeQuery();

        // Calcular el mes y año anterior
        Calendar calendar = Calendar.getInstance();
        int mesActual = calendar.get(Calendar.MONTH) + 1; // Mes actual (1-12)
        int yearActual = calendar.get(Calendar.YEAR);     // Año actual

        int mesAnterior = mesActual - 1;
        int yearAnterior = yearActual;

        if (mesAnterior == 0) {
            mesAnterior = 12; // Si estamos en enero, mes anterior es diciembre
            yearAnterior -= 1; // Año anterior
        }

        // Filtrar las notas en Java
        boolean found = false;
        while (rs.next()) {
            String titulo = rs.getString("titulo");
            String info = rs.getString("info");
            String imgPrivacidad = rs.getString("imgPrivacidad");
            String imgSentimiento = rs.getString("imgSentimiento");
            Timestamp diaCreacion = rs.getTimestamp("diaCreacion");

            // Convertir la fecha de la nota
            Calendar noteCalendar = Calendar.getInstance();
            noteCalendar.setTime(diaCreacion);

            int noteMonth = noteCalendar.get(Calendar.MONTH) + 1; // Mes de la nota
            int noteYear = noteCalendar.get(Calendar.YEAR);       // Año de la nota

            // Comparar con el mes y año anterior
            if (noteMonth == mesAnterior && noteYear == yearAnterior) {
                found = true;
                            %>

                            <div class="contenedor-cada-nota" 
                                 data-titulo="<%= titulo %>" 
                                 data-info="<%= info %>" 
                                 data-fecha="<%= diaCreacion %>" 
                                 data-sentimiento="<%= imgSentimiento %>">
                                <div class="nota-desplegada-sentimiento-img">
                                    <img id="estado-animo-img"
                                         src="../img/estado_animo_img/<%= imgSentimiento%>.svg" 
                                         class="imgSentimiento">
                                </div>
                                <div class="nota-desplegada-titulo">
                                    <p><%= titulo%></p>
                                </div>
                                <div class="nota-desplegada-fecha">
                                    <p><%= diaCreacion%></p>
                                </div>
                            </div>
                            <hr class="linea-divisoria">
                            <div id="modal-Notas" class="modal-Notas" style="display: none;">
                                <div class="modal-contenido">
                                    <div class="modal-contenido-nota">
                                        <div class="textos-modal-nota">
                                            <div class="titulo-modal-content">
                                                <p id="modal-titulo"></p>
                                            </div>
                                            <div class="date-modal-content">
                                                <p id="modal-fecha"></p>
                                            </div>
                                            <div class="texto-modal-content">
                                                <p id="modal-info"></p>
                                            </div>
                                        </div>
                                        <div class="img-feel-modal-content">
                                            <img id="modal-img-sentimiento" class="imgSentimientoModal">
                                        </div>
                                    </div>
                                    <div class="item-modal-content-oper">
                                        <button type="button" onclick="cerrarModal()" class="btn-cancelar-modal">Cancelar</button>
                                        <a href="editar_nota_hijo.jsp?titulo=<%= titulo %>&fecha=<%= diaCreacion %>&info=<%= info %>&sentimiento=<%= imgSentimiento %>">
            <img class="editar-perfil" src="../img/lapiz_edicion.svg">
        </a>
                                    </div>
                                </div>
                            </div>
                            <%
                                        }
                                    }
                                    // Si no se encontraron notas, mostrar un mensaje
                                    if (!found) {
                                        out.println("<p>No hay notas privadas del mes anterior.</p>");
                                    }
                                } catch (Exception e) {
                                     out.println("Error: " + e.getMessage() + "<br>");
            e.printStackTrace();
                                } finally {
                                    bd.cierraConexion(); // Cerrar la conexión con la base de datos
                                }
                            } else {
                                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
                            }
                            %>
                        </div>
                    </div>
                    <!-- meses anteriores  -->
                    <div class="seccion-notas" id="seccion-not-antS-month"> 
                        <div id="notas-antSmonth-sinDesplegar" onclick="desplegar3()">
                            <div class="texto-nota-antS-month">
                                Meses Anteriores
                            </div>
                            <div class="notas-antS-mont-flecha">
                                <img src="../img/flechita-abajo.svg" class="imgFlechaDesplegar2">
                            </div>
                        </div>
                        <div id="notas-antSmonth-Desplegado" style="display: none;">
                            <%
session = request.getSession(false);

if (session != null && session.getAttribute("usuario") != null) {
    String nombreUsuario = (String) session.getAttribute("usuario");
    Base bd = new Base();

    try {
        bd.conectar();

        // Obtener el idKit del usuario
        String queryIdKit = "SELECT idKit FROM Kit WHERE nombreUsuario = ?";
        PreparedStatement stmt = bd.getConn().prepareStatement(queryIdKit);
        stmt.setString(1, nombreUsuario);
        ResultSet rs = stmt.executeQuery();

        int idKit = -1;
        if (rs.next()) {
            idKit = rs.getInt("idKit");
        }

        if (idKit == -1) {
            throw new Exception("El usuario no está registrado.");
        }

        // Obtener todas las notas privadas
        String queryNotasPrivadas = "SELECT * FROM diario WHERE idKit = ? AND privacidad = 1";
        stmt = bd.getConn().prepareStatement(queryNotasPrivadas);
        stmt.setInt(1, idKit);
        rs = stmt.executeQuery();

        // Calcular el mes y año anterior
        Calendar calendar = Calendar.getInstance();
        int mesActual = calendar.get(Calendar.MONTH) + 1; // Mes actual (1-12)
        int yearActual = calendar.get(Calendar.YEAR);     // Año actual

        int mesAnterior = mesActual - 2;
        int yearAnterior = yearActual;

        if (mesAnterior == -1) {
            mesAnterior = 11; // Si estamos en enero, mes anterior es diciembre
            yearAnterior -= 1; // Año anterior
        }

        boolean found = false;
        while (rs.next()) {
            String titulo = rs.getString("titulo");
            String info = rs.getString("info");
            String imgPrivacidad = rs.getString("imgPrivacidad");
            String imgSentimiento = rs.getString("imgSentimiento");
            Timestamp diaCreacion = rs.getTimestamp("diaCreacion");

            Calendar noteCalendar = Calendar.getInstance();
            noteCalendar.setTime(diaCreacion);

            int noteMonth = noteCalendar.get(Calendar.MONTH) + 1; 
            int noteYear = noteCalendar.get(Calendar.YEAR);       

            if (noteMonth == mesAnterior && noteYear == yearAnterior) {
                found = true;
                            %>

                            <div class="contenedor-cada-nota" 
                                 data-titulo="<%= titulo %>" 
                                 data-info="<%= info %>" 
                                 data-fecha="<%= diaCreacion %>" 
                                 data-sentimiento="<%= imgSentimiento %>">
                                <div class="nota-desplegada-sentimiento-img">
                                    <img id="estado-animo-img"
                                         src="../img/estado_animo_img/<%= imgSentimiento%>.svg" 
                                         class="imgSentimiento">
                                </div>
                                <div class="nota-desplegada-titulo">
                                    <p><%= titulo%></p>
                                </div>
                                <div class="nota-desplegada-fecha">
                                    <p><%= diaCreacion%></p>
                                </div>
                            </div>
                            <hr class="linea-divisoria">
                            
                            <div id="modal-Notas" class="modal-Notas" style="display: none;">
                                <div class="modal-contenido">
                                    <div class="modal-contenido-nota">
                                        <div class="textos-modal-nota">
                                            <div class="titulo-modal-content">
                                                <p id="modal-titulo"></p>
                                            </div>
                                            <div class="date-modal-content">
                                                <p id="modal-fecha"></p>
                                            </div>
                                            <div class="texto-modal-content">
                                                <p id="modal-info"></p>
                                            </div>
                                        </div>
                                        <div class="img-feel-modal-content">
                                            <img id="modal-img-sentimiento" class="imgSentimientoModal">
                                        </div>
                                    </div>
                                    <div class="item-modal-content-oper">
                                        <button type="button" onclick="cerrarModal()" class="btn-cancelar-modal">Cancelar</button>
                                        <a href="editar_nota_hijo.jsp?titulo=<%= titulo %>&fecha=<%= diaCreacion %>&info=<%= info %>&sentimiento=<%= imgSentimiento %>">
            <img class="editar-perfil" src="../img/lapiz_edicion.svg">
        </a>
                                    </div>
                                </div>
                            <%
                                        }
                                    }
                                    // Si no se encontraron notas, mostrar un mensaje
                                    if (!found) {
                                        out.println("<p>No hay notas privadas de los meses anteriores.</p>");
                                    }
                                } catch (Exception e) {
                                     out.println("Error: " + e.getMessage() + "<br>");
            e.printStackTrace();
                                } finally {
                                    bd.cierraConexion(); 
                                }
                            } else {
                                response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
                            }
                            %>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script src="../codigo_js/codigo_javascript_hijo/js_diario_hijo.js" type="text/javascript"></script>
    </body>
</html>