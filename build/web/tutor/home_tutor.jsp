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
        <link href="../estilos_css/estilos_tutor/css_home_tutor.css" rel="stylesheet" type="text/css"/>
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
            String email = (String) session.getAttribute("email");
            Base bd = new Base();
            boolean tieneHijos = false;

            // Verificar si hay hijos asociados al tutor
            try {
                bd.conectar();
                String query = "SELECT COUNT(*) FROM Kit WHERE codPresa IN (SELECT codPresa FROM Castor WHERE email = ?)";
                PreparedStatement pstmt = bd.getConn().prepareStatement(query);
                pstmt.setString(1, email);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    tieneHijos = true;
                }
                rs.close();
                pstmt.close();
            } catch (SQLException ex) {
                out.println("Error al verificar los hijos: " + ex.getMessage());
            } finally {
                bd.cierraConexion(); // Cerrar la conexión en el bloque finally
            }
        %>
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
                    <a href="#">Bienvenida</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <a href="#"><img src="../img/iconito_notifiNotificacion.svg"></a>
                    <div class="sec-nav-perfil">

                        <%
                            if (session != null && session.getAttribute("email") != null) {
                                try {
                                    bd.conectar();

                                    String strQ = "select * from Castor where email = ?";
                                    PreparedStatement pstmt = bd.getConn().prepareStatement(strQ);
                                    pstmt.setString(1, email);
                                    ResultSet rs = pstmt.executeQuery();

                                    int idCastor = 0;
                                    String codPresa = "";
                                    if (rs.next()) {
                                        idCastor = rs.getInt("idCastor");
                                        codPresa = rs.getString("codPresa");  // Obtener codPresa
                                        session.setAttribute("codPresa", codPresa);
                                    }

                                    String consult = "select * from Castor where idCastor = ?";
                                    PreparedStatement pstmt2 = bd.getConn().prepareStatement(consult);
                                    pstmt2.setInt(1, idCastor);
                                    ResultSet r = pstmt2.executeQuery();

                                    while (r.next()) {
                        %>
                        <a href="#"><%=rs.getString(3)%></a>
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
                        <a href="perfil_tutor.jsp"> <img src="../img/icono_Perfil.svg"></a>
                    </div>
                </div>
            </div>
            <div class="Div-Principal">
                <div class="sec1">
                    <div class="section1">
                        <div class="item2">
                            <div class="item2-3"><p>Accesos</p></div>
                            <div class="item3">

                                <% if (!tieneHijos) { %>

                                <a href="../formularios_sesion/registro_hijo.jsp"><button class="buttoon">Debes registrar un hijo</button></a>
                                <% } else { %>

                                <% }%>
                            </div>
                        </div>

                        <div class="item4"></div>
                        <div class="item5"></div>
                        <div class="Raudy">
                            <div class="item6"><p>Raudy Dice</p></div>
                            <div class="item7"><p>Frases de acuerdo al tipo de usuario(consejos, recomendaciones  motivacion)</p></div>
                            <div class="item7.5">
                                <div class = "contenedor-contenido-abajo">
                                    <div class="container-wrapper" id="container-wrapper">
                                        <div class = "div-container-table-scroll">
                                            <table class="tabla">
                                                <tr>
                                                    <%
                                                        PreparedStatement pstmt7 = null;
                                                        ResultSet rs = null;
                                                        PreparedStatement pstmt8 = null;
                                                        ResultSet rs2 = null;
                                                        PreparedStatement pstmt9 = null;
                                                        ResultSet rs3 = null;

                                                        session = request.getSession(false);
                                                        if (session != null && session.getAttribute("email") != null) {
                                                            pstmt7 = null;
                                                            rs = null;

                                                            try {

                                                                bd.conectar();

                                                                String query = "SELECT * FROM Castor WHERE email = ?";
                                                                pstmt7 = bd.getConn().prepareStatement(query);
                                                                pstmt7.setString(1, email);
                                                                rs = pstmt7.executeQuery();

                                                                int idCastor = 0;

                                                                if (rs.next()) {
                                                                    idCastor = rs.getInt(1);
                                                                }

                                                                int cont = 0;

                                                                boolean comprobar = false;
                                                                session = request.getSession(false);
                                                                if (session == null || session.getAttribute("idKit") == null) {
                                                                    comprobar = true;
                                                                } else {
                                                                    comprobar = false;
                                                                }
                                                                if (comprobar) {
                                                    %>
                                                    <td>
                                                        <div id="container-burbuja-img-text">
                                                            <div class="img-text-container">
                                                                <img src="../img/icono_Perfil.svg" alt="Imagen de iconito" class="icon-img">
                                                            </div>
                                                            <button class="button-overlay" onclick="toggleBurbujas()">
                                                                <img src="../img/icono_cambio_hijo.svg" id="imgCambiarHijos">
                                                            </button>
                                                        </div>
                                                    </td>
                                                    <%
                                                    } else {
                                                        String idKitActualizado = (String) session.getAttribute("idKit");
                                                        int idKitActualizadoInt = Integer.parseInt(idKitActualizado);

                                                        String queryp = "SELECT * FROM Kit WHERE idKit = ?";
                                                        PreparedStatement pstmtp = bd.getConn().prepareStatement(queryp);
                                                        pstmtp.setInt(1, idKitActualizadoInt);
                                                        ResultSet rsp = pstmtp.executeQuery();
                                                        if (rsp.next()) {

                                                    %>
                                                    <td>
                                                        <div id="container-burbuja-img-text">
                                                            <form action="procesa_home_tutor.jsp" method="post" style="display: inline;" id="pruebapaber">
                                                                <input type="text" id="idKit" name="idKit" style="display: none;" value="<%= rsp.getString(1)%>">
                                                                <button type="submit" style="background: none; border: none; padding: 0; cursor: pointer; height: auto; height: auto; display: flex; align-content: center; align-items: center;">
                                                                    <div class="img-text-container">
                                                                        <img src="<%= rsp.getString(9)%>" alt="Imagen de iconito" class="icon-img">
                                                                    </div>
                                                                    <div class="span-text-container">
                                                                        <span id="span-nombre-burbuja"><%= rsp.getString(4)%></span>
                                                                    </div>
                                                                </button>
                                                            </form>
                                                            <button class="button-overlay" onclick="toggleBurbujas()">
                                                                <img src="../img/icono_cambio_hijo.svg" id="imgCambiarHijos">
                                                            </button>
                                                        </div>
                                                    </td>
                                                    <%
                                                            }
                                                        }
                                                        String codPresaMandar = null;

                                                        if (idCastor > 0) {
                                                            String query2 = "SELECT * FROM relKitCastor WHERE idCastor = ?";
                                                            pstmt8 = bd.getConn().prepareStatement(query2);
                                                            pstmt8.setInt(1, idCastor);
                                                            rs2 = pstmt8.executeQuery();

                                                            while (rs2.next()) {
                                                                cont++;

                                                                int idKitInt = rs2.getInt(3);
                                                                String idKitString = String.valueOf(idKitInt);

                                                                String query3 = "SELECT * FROM Kit WHERE idKit = ?";
                                                                pstmt9 = bd.getConn().prepareStatement(query3);
                                                                pstmt9.setInt(1, idKitInt);
                                                                rs3 = pstmt9.executeQuery();

                                                                session = request.getSession(false);
                                                                if (!idKitString.equals(session.getAttribute("idKit"))) {

                                                                    if (rs3.next()) {
                                                                        codPresaMandar = rs3.getString(2);

                                                    %>
                                                    <td id = "td-burbujas-escondidas">
                                                        <form action="procesa_home_tutor.jsp" method="post" style="display: inline;" id="pruebapaber2">
                                                            <input type="text" id="idKit" name="idKit" value="<%= rs3.getString(1)%>" style="display: none;">
                                                            <button type="submit" class="icon-button" style="background: none; border: none; padding: 0; cursor: pointer; display: flex; align-items: center;">
                                                                <div class="img-text-container">
                                                                    <img src="<%= rs3.getString(9)%>" alt="Imagen de iconito" class="icon-img">
                                                                </div>
                                                                <div class="span-text-container">
                                                                    <span id="span-nombre-burbuja"><%= rs3.getString(4)%></span>
                                                                </div>
                                                            </button>
                                                        </form>
                                                    </td>
                                                    <%
                                                                }

                                                            }
                                                        }
                                                    %>
                                                    <td id = "td-burbujas-escondidas">
                                                        <div class="burbujas-escondidas" style="display: none;">
                                                            <div class="act_tit" id="hijoadd-div">
                                                                <div class="contenedor-button-add-actividad">
                                                                    <a style="text-decoration: none;" href="../formularios_sesion/registro_hijo.jsp?returnUrl=<%= request.getRequestURL()%>&codPresa=<%= codPresaMandar != null ? codPresaMandar : ""%>">       
                                                                        <button class="agregarHijo" id="agregarHijo"><img src="../img/icon_add.svg"/></button>

                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <%
                                                                    rs2.close(); // cerrar rs2
                                                                    pstmt8.close(); // cerrar pstmt2
                                                                    rs3.close(); // cerrar rs3
                                                                    pstmt7.close(); // cerrar pstmt3
                                                                }

                                                            } catch (Exception e) {
                                                                e.printStackTrace();
                                                            } finally {
                                                                if (rs != null) try {
                                                                    rs.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                if (pstmt7 != null) try {
                                                                    pstmt7.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                if (rs2 != null) try {
                                                                    rs2.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                if (pstmt8 != null) try {
                                                                    pstmt8.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                if (rs3 != null) try {
                                                                    rs3.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                if (pstmt9 != null) try {
                                                                    pstmt9.close();
                                                                } catch (SQLException e) {
                                                                    e.printStackTrace();
                                                                }
                                                                // Cerrar conexión si es necesario
                                                            }
                                                        }
                                                    %>

                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div></div>
                            <div class="item8"><img src="../img/Castor.svg"></div>
                        </div>
                    </div></div>

                <div class="linea"></div>
                <div class="sec2">
                    <div class="section2">
                        <div class="obj-4">
                            <div class="hijos">Mis hijos</div>
                            <div id="contenedor-hijos">
                                <%
                                    if (tieneHijos) {
                                        try {
                                            bd.conectar();
                                            String queryHijos = "SELECT * FROM Kit WHERE codPresa IN (SELECT codPresa FROM Castor WHERE email = ?)";
                                            PreparedStatement pstmtHijos = bd.getConn().prepareStatement(queryHijos);
                                            pstmtHijos.setString(1, email);
                                            ResultSet rsHijos = pstmtHijos.executeQuery();

                                            while (rsHijos.next()) {
                                                String nombreHijo = rsHijos.getString("nombre");
                                                String imagenPerfilHijo = rsHijos.getString("imagenPerfil");
                                %>
                                <div><div id="hijo">
                                        <div class="image12"><img src="<%= imagenPerfilHijo%>" alt="Imagen de <%= nombreHijo%>" class="imagenHijo"></div>
                                        <div class="infoHijo">
                                            <p class="nomHij"><%= nombreHijo%></p>
                                            <p class="chat">texto chat</p>
                                        </div>

                                    </div>
                                </div>


                                <%
                                            }
                                            rsHijos.close();
                                            pstmtHijos.close();
                                        } catch (SQLException e) {
                                            out.println("Error al obtener los hijos: " + e.getMessage());
                                        } finally {
                                            bd.cierraConexion(); // Cerrar la conexión en el bloque finally
                                        }
                                    } else {

                                    }
                                %>
                                <%if (tieneHijos) {%>
                            </div> <div class="Mas"> <a href="../formularios_sesion/registro_hijo.jsp" class="ButtonMas"><div class="imagencita">
                                        <img src="../img/MasHijo.svg" class="IMGMas"></div>
                                </a>
                            </div>
                            <%} else {%>
                            <div class="Mas" style="height: 7vw; min-height: 5vw; background-color: white; border-radius: 1.5rem;">

                            </div><%}%>


                        </div>
                        <div class="obj-5">
                            <div class="stats">Estadisticas</div>
                            <div class="estadisticas"><img src="../img/Stats.svg"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script src="../codigo_js/codigo_javascript_tutor/js_home_tutor.js" type="text/javascript"></script>
        <script>
                                                                window.onload = function () {
                                                                    // Obtener el contenedor de los hijos
                                                                    var contenedorHijos = document.getElementById("contenedor-hijos");

                                                                    // Contar el número de hijos dentro del contenedor
                                                                    var hijos = contenedorHijos.children.length;

                                                                    // Si hay 2 hijos o más, mostrar la barra de desplazamiento vertical
                                                                    if (hijos >= 2) {
                                                                        contenedorHijos.style.overflowY = 'scroll';  // Activa el scroll vertical
                                                                    }
                                                                };
        </script>
        <%
            // Iniciar sesión
            session = request.getSession(false);
            if (session != null && session.getAttribute("email") != null) {

                PreparedStatement pstmt1 = null;
                PreparedStatement pstmt2 = null;
                ResultSet rs9 = null;
                ResultSet rs8 = null;

                try {
                    bd.conectar();

                    // Paso 1: Obtener idCastor donde el email coincide
                    String query = "SELECT * FROM Castor WHERE email = ?";
                    pstmt1 = bd.getConn().prepareStatement(query);
                    pstmt1.setString(1, email);
                    rs9 = pstmt1.executeQuery();

                    int idCastor = 0; // Variable para almacenar el idCastor

                    if (rs9.next()) {
                        idCastor = rs9.getInt(1); // Obtener idCastor
                    }

                    // Paso 2: Verificar si hay registros en relKitCastor con el idCastor obtenido
                    // Dentro del bloque donde verificas si hay hijos
                    if (idCastor > 0) {
                        String query2 = "SELECT * FROM relKitCastor WHERE idCastor = ?";
                        pstmt2 = bd.getConn().prepareStatement(query2);
                        pstmt2.setInt(1, idCastor); // Usar el idCastor obtenido
                        rs8 = pstmt2.executeQuery();

                        int count = 0;

                        while (rs8.next()) {
                            count += 1;
                        }

                        // Si no tiene hijos registrados, mostrar el modal
                        if (count == 0) {
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById("noChildModal").style.display = "block"; // Mostrar modal
                document.getElementById("noChildModal").style.display = "flex";
            });
        </script>
        <%
        } else {
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById("noChildModal").style.display = "none"; // Ocultar modal
            });
        </script>
        <%
                        }
                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                }
            } else {
            }
        %>


        <!-- Modal -->
        <!-- Modal -->
        <%            String codPresaMandar = "hola";
            String emailModal = "email";
            session = request.getSession(false);
            if (session != null && session.getAttribute("email") != null) {
                emailModal = (String) session.getAttribute("email");
            }
            Base bdModalFormu = new Base();
            try {
                bdModalFormu.conectar();
                String sqlModal = "SELECT * FROM Castor WHERE email = ?";

                PreparedStatement psConectionModal = bdModalFormu.getConn().prepareStatement(sqlModal);
                psConectionModal.setString(1, emailModal);
                ResultSet rsModal = psConectionModal.executeQuery();
                if (rsModal.next()) {
                    codPresaMandar = rsModal.getString(2);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        <div id="noChildModal" class="modal">
            <div class="modal-content">
                <span style="
                      font-family: 'Dongle', sans-serif;
                      font-weight: 400;
                      font-style: normal;
                      font-size: 3.5rem;"
                      >Registro de Hijo (a)</span>

                <br>

                <span style="
                      font-family: 'Gayathri', system-ui;
                      font-weight: 700;
                      font-style: normal;
                      font-size: 1.2rem;"
                      >No tienes ningún hijo (a) registrado (a). Por favor, registra a tu hijo (a) para continuar.</span>
                <div>
                    <img src="../img/perfil_niño_globo.svg" style="height: 15rem; width: 15rem;">
                </div>
                <div style="margin-top: 20px;">
                    <a style="text-decoration: none;" href="../formularios_sesion/registro_hijo.jsp?returnUrl=<%= request.getRequestURL()%>&codPresa=<%= codPresaMandar != null ? codPresaMandar : ""%>" class="button">
                        <button class="agregar-hijo-modal-button">
                            Registrar Hijo
                        </button>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>