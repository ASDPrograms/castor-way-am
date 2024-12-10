
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
        <link href="../estilos_css/estilos_tutor/css_diario_tutor.css" rel="stylesheet" type="text/css"/>
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
            <div class="icon-section">
                <div class="menu-item">
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
                <div class="menu-item" id = "div_nav_home">
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
                    <a href="#">Diario</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <a href="#"><img src="../img/iconito_notifiNotificacion.svg" class = "imgNavSecondary"></a>
                    <div class="sec-nav-perfil">
                        <%
                            session = request.getSession(false);

                            if (session != null && session.getAttribute("email") != null) {
                                String email = (String) session.getAttribute("email");

                        %>
                        <%                            Base bd = new Base();
                            try {
                                bd.conectar();

                                String strQ = "select * from Castor where email = ?";
                                PreparedStatement pstmt3 = bd.getConn().prepareStatement(strQ);
                                pstmt3.setString(1, email);
                                ResultSet rs = pstmt3.executeQuery();

                                int idCastor = 0;
                                if (rs.next()) {
                                    idCastor = rs.getInt("idCastor");
                                }

                                String consult = "select * from Castor where idCastor = ?";
                                PreparedStatement pstmt4 = bd.getConn().prepareStatement(consult);
                                pstmt4.setInt(1, idCastor);
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
                        <a href="perfil_tutor.jsp"> 
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
                            <p>Notas publicas</p>
                        </div>
                    </div>
                </div>
                
                <div class="tercero">
                    <div class="seccion-notas" id="seccion-not-this-month"> 

                        <div class="notas-thismonth-sinDesplegar" id="notas-thismonth-sinDesplegar" onclick="desplegar()">
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

if (session != null && session.getAttribute("email") != null) {
    String email = (String) session.getAttribute("email");
    Base bd = new Base();

    try {
        bd.conectar();
        System.out.println("Conexión a la base de datos establecida.");
        System.out.println("Email recibido: " + email);

        String queryCastor = "SELECT idCastor FROM Castor WHERE email = ?";
        PreparedStatement stmt = bd.getConn().prepareStatement(queryCastor);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        int idCastor = -1;
        if (rs.next()) {
            idCastor = rs.getInt("idCastor");
            System.out.println("idCastor encontrado: " + idCastor);
        } else {
            System.out.println("No se encontró idCastor para el email proporcionado.");
        }

        if (idCastor == -1) {
            throw new Exception("El tutor no está registrado.");
        }

        String queryIdKits = "SELECT idKit FROM relDiario WHERE idCastor = ?";
        stmt = bd.getConn().prepareStatement(queryIdKits);
        stmt.setInt(1, idCastor);
        rs = stmt.executeQuery();

        boolean found = false;
        System.out.println("Buscando idKit relacionados con idCastor: " + idCastor);

        while (rs.next()) {
            int idKit = rs.getInt("idKit");
            System.out.println("idKit encontrado: " + idKit);

          
            String queryNotasRelDiario =
                "SELECT d.titulo, d.info, d.imgPrivacidad, d.imgSentimiento, d.diaCreacion " +
                "FROM diario d " +
                "WHERE d.idKit = ? AND d.privacidad = 0 " +
                "AND MONTH(d.diaCreacion) = MONTH(CURRENT_DATE()) " +
                "AND YEAR(d.diaCreacion) = YEAR(CURRENT_DATE())";

            PreparedStatement stmtNotas = bd.getConn().prepareStatement(queryNotasRelDiario);
            stmtNotas.setInt(1, idKit);
            
            ResultSet rsNotas = stmtNotas.executeQuery();

            // Depuración: Validar si hay resultados
            boolean hayNotas = false;
           
            while (rsNotas.next()) {
                try {
                    
                    hayNotas = true;
                    found = true;
                    
                    String titulo = rsNotas.getString("titulo");
                    String info = rsNotas.getString("info");
                    String imgPrivacidad = rsNotas.getString("imgPrivacidad");
                    String imgSentimiento = rsNotas.getString("imgSentimiento");
                    Timestamp diaCreacion = rsNotas.getTimestamp("diaCreacion");

                    System.out.println("Nota encontrada: Título=" + titulo);
                            %>
                            <div class="contenedor-cada-nota" 
                                 data-titulo="<%= titulo %>" 
                                 data-info="<%= info %>" 
                                 data-fecha="<%= diaCreacion %>" 
                                 data-sentimiento="<%= imgSentimiento %>">
                                <div class="nota-desplegada-sentimiento-img">
                                    <img id="estado-animo-img"
                                         src="../img/estado_animo_img/<%= imgSentimiento %>.svg" 
                                         class="imgSentimiento">
                                </div>
                                <div class="nota-desplegada-titulo">
                                    <p><%= titulo %></p>
                                </div>
                                <div class="nota-desplegada-fecha">
                                    <p><%= diaCreacion %></p>
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
                                        
                                    </div>
                                </div>
                            </div>
                            <%
                                            } catch (Exception e) {
                                                System.err.println("Error al procesar los datos de la nota: " + e.getMessage());
                                                e.printStackTrace();
                                            }
                                        }

                                        if (!hayNotas) {
                                            System.out.println("No se encontraron notas para idKit: " + idKit);
                                        }
                                    }

                                    if (!found) {
                            %>
                            <p>No se encontraron notas de tu Kit públicas en este mes.</p>
                            <%
                                    }

                                } catch (Exception e) {
                                    System.err.println("Error general: " + e.getMessage());
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

if (session != null && session.getAttribute("email") != null) {
    String email = (String) session.getAttribute("email");
    Base bd = new Base();

    try {
        bd.conectar();
        System.out.println("Conexión a la base de datos establecida.");
        System.out.println("Email recibido: " + email);

        String queryCastor = "SELECT idCastor FROM Castor WHERE email = ?";
        PreparedStatement stmt = bd.getConn().prepareStatement(queryCastor);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        int idCastor = -1;
        if (rs.next()) {
            idCastor = rs.getInt("idCastor");
            System.out.println("idCastor encontrado: " + idCastor);
        } else {
            System.out.println("No se encontró idCastor para el email proporcionado.");
        }

        if (idCastor == -1) {
            throw new Exception("El tutor no está registrado.");
        }

        String queryIdKits = "SELECT idKit FROM relDiario WHERE idCastor = ?";
        stmt = bd.getConn().prepareStatement(queryIdKits);
        stmt.setInt(1, idCastor);
        rs = stmt.executeQuery();

        boolean found = false;
        System.out.println("Buscando idKit relacionados con idCastor: " + idCastor);

        while (rs.next()) {
            int idKit = rs.getInt("idKit");
            System.out.println("idKit encontrado: " + idKit);

          
          String queryNotasRelDiarioMesAnterior =
                "SELECT d.titulo, d.info, d.imgPrivacidad, d.imgSentimiento, d.diaCreacion " +
                "FROM diario d " +
                "WHERE d.idKit = ? AND d.privacidad = 0 " +
                "AND MONTH(d.diaCreacion) = MONTH(CURRENT_DATE() - INTERVAL 1 MONTH) " +
                "AND YEAR(d.diaCreacion) = YEAR(CURRENT_DATE() - INTERVAL 1 MONTH)";

PreparedStatement stmtNotas = bd.getConn().prepareStatement(queryNotasRelDiarioMesAnterior);
stmtNotas.setInt(1, idKit);
            ResultSet rsNotas = stmtNotas.executeQuery();

            // Depuración: Validar si hay resultados
            boolean hayNotas = false;
           
            while (rsNotas.next()) {
                try {
                    
                    hayNotas = true;
                    found = true;
                    
                    String titulo = rsNotas.getString("titulo");
                    String info = rsNotas.getString("info");
                    String imgPrivacidad = rsNotas.getString("imgPrivacidad");
                    String imgSentimiento = rsNotas.getString("imgSentimiento");
                    Timestamp diaCreacion = rsNotas.getTimestamp("diaCreacion");

                    System.out.println("Nota encontrada: Título=" + titulo);
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
                                       
        
                                    </div>
                                </div>
                            </div>
                          <%
                                            } catch (Exception e) {
                                                System.err.println("Error al procesar los datos de la nota: " + e.getMessage());
                                                e.printStackTrace();
                                            }
                                        }

                                        if (!hayNotas) {
                                            System.out.println("No se encontraron notas para idKit: " + idKit);
                                        }
                                    }

                                    if (!found) {
                            %>
                            <p>No se encontraron notas de tu Kit públicas del mes anterior.</p>
                            <%
                                    }

                                } catch (Exception e) {
                                    System.err.println("Error general: " + e.getMessage());
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
                        <div class="seccion-notas" id="seccion-not-ant-month"> 
                        <div id="notas-antmonth-sinDesplegar" onclick="desplegar3()">
                            <div class="texto-nota-ant-month">
                                Meses Anteriores
                            </div>
                            <div class="notas-ant-mont-flecha">
                                <img src="../img/flechita-abajo.svg" class="imgFlechaDesplegar2">
                            </div>
                        </div>
                        <div id="notas-antSmonth-Desplegado" style="display: none;">
                           <%
session = request.getSession(false);

if (session != null && session.getAttribute("email") != null) {
    String email = (String) session.getAttribute("email");
    Base bd = new Base();

    try {
        bd.conectar();
        System.out.println("Conexión a la base de datos establecida.");
        System.out.println("Email recibido: " + email);

        String queryCastor = "SELECT idCastor FROM Castor WHERE email = ?";
        PreparedStatement stmt = bd.getConn().prepareStatement(queryCastor);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        int idCastor = -1;
        if (rs.next()) {
            idCastor = rs.getInt("idCastor");
            System.out.println("idCastor encontrado: " + idCastor);
        } else {
            System.out.println("No se encontró idCastor para el email proporcionado.");
        }

        if (idCastor == -1) {
            throw new Exception("El tutor no está registrado.");
        }

        String queryIdKits = "SELECT idKit FROM relDiario WHERE idCastor = ?";
        stmt = bd.getConn().prepareStatement(queryIdKits);
        stmt.setInt(1, idCastor);
        rs = stmt.executeQuery();

        boolean found = false;
        System.out.println("Buscando idKit relacionados con idCastor: " + idCastor);

        while (rs.next()) {
            int idKit = rs.getInt("idKit");
            System.out.println("idKit encontrado: " + idKit);

          
            String queryNotasRelDiarioMesesAnterior =
                "SELECT d.titulo, d.info, d.imgPrivacidad, d.imgSentimiento, d.diaCreacion " +
                "FROM diario d " +
                "WHERE d.idKit = ? AND d.privacidad = 0 " +
                "AND MONTH(d.diaCreacion) = MONTH(CURRENT_DATE() - INTERVAL 2 MONTH) " +
                "AND YEAR(d.diaCreacion) = YEAR(CURRENT_DATE() - INTERVAL 2 MONTH)";

PreparedStatement stmtNotas = bd.getConn().prepareStatement(queryNotasRelDiarioMesesAnterior);
stmtNotas.setInt(1, idKit);
            
            ResultSet rsNotas = stmtNotas.executeQuery();

            // Depuración: Validar si hay resultados
            boolean hayNotas = false;
           
            while (rsNotas.next()) {
                try {
                    
                    hayNotas = true;
                    found = true;
                    
                    String titulo = rsNotas.getString("titulo");
                    String info = rsNotas.getString("info");
                    String imgPrivacidad = rsNotas.getString("imgPrivacidad");
                    String imgSentimiento = rsNotas.getString("imgSentimiento");
                    Timestamp diaCreacion = rsNotas.getTimestamp("diaCreacion");

                    System.out.println("Nota encontrada: Título=" + titulo);
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
                                      
                                    </div>
                                </div>
                            </div>
                          <%
                                            } catch (Exception e) {
                                                System.err.println("Error al procesar los datos de la nota: " + e.getMessage());
                                                e.printStackTrace();
                                            }
                                        }

                                        if (!hayNotas) {
                                            System.out.println("No se encontraron notas para idKit: " + idKit);
                                        }
                                    }

                                    if (!found) {
                            %>
                            <p>No se encontraron notas de tu Kit públicas de los meses anteriores.</p>
                            <%
                                    }

                                } catch (Exception e) {
                                    System.err.println("Error general: " + e.getMessage());
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
                   
 <script src="../codigo_js/codigo_javascript_tutor/js_diario_tutor.js" type="text/javascript"></script>
</body>
</html>