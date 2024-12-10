<%-- 
    Document   : perfil_tutor
    Created on : 15 oct. 2024, 07:51:00
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
        <link href="../estilos_css/estilos_tutor/css_perfil_tutor.css" rel="stylesheet" type="text/css"/>
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

                        if (session != null && session.getAttribute("email") != null)
                    %>
                    <%
                            session = request.getSession(false);

                        if (session != null && session.getAttribute("email") != null) {
                            String email = (String) session.getAttribute("email");
                            String codPresa = null;
                            String nombre = null;
                            String apellidos = null;
                            int edad = 0;
                            String fechaRegistro = null;
                            String contraseña = null;
                            int ramitas = 0;
                            int idCastor = 0;

                            Base bd = new Base();
                            try {
                                bd.conectar();

                                String strQ = "SELECT email, contraseña, ramitas, codPresa,"
                                        + " nombre, idCastor, apellidos, edad, fechaRegistro  FROM Castor WHERE email = ?";
                                PreparedStatement pstmt = bd.getConn().prepareStatement(strQ);
                                pstmt.setString(1, email);
                                ResultSet rs = pstmt.executeQuery();

                                if (rs.next()) {
                                    email = rs.getString("email");
                                    contraseña = rs.getString("contraseña");
                                    ramitas = rs.getInt("ramitas");
                                    codPresa = rs.getString("codPresa");
                                    nombre = rs.getString("nombre");
                                    apellidos = rs.getString("apellidos");
                                    edad = rs.getInt("edad");
                                    fechaRegistro = rs.getString("fechaRegistro");
                                    idCastor = rs.getInt("idCastor");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                    %>
                    <p class="nombre"><%= nombre != null ? nombre : "No disponible"%> <%= apellidos != null ? apellidos : "No disponible"%></p>
                    <p class="texto-user"><%= email != null ? email : "No disponible"%></p>
                </div>
                <div class="item-codigo">
                    <p class="texto-codigo">Codigo présa:<br>
                        <span id="codigoPresa"><%= codPresa != null ? codPresa : "No disponible"%></span>

                    </p>
                    <div class="img-copiarCodigo" onclick="copiarCodigo(event)">
                        <img id="copiarIcon" class="Copiar" src="../img/icono_copiar.svg" alt="Copiar código">
                    </div>
                    <div id="modalExito" style="display: none;">
                        <div class="modal-contenido">
                            <p>Texto copiado</p>
                            <button onclick="cerrarModal()">Cerrar</button>
                        </div>

                    </div>
                </div>
                        <div> 
                <p class="texto-union">Se unió el <%= fechaRegistro != null ? fechaRegistro : "No disponible"%></p>
                        </div>
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
                <div class="info-item">
                    <p>Contraseña: <%= contraseña != null ? contraseña : "No disponible"%></p>
                </div>
                <div class="info-item izquierda">
                    <p>Ramitas: <%= ramitas >= 0 ? ramitas : "No disponible"%></p>
                </div>
                <div class="info-item">
                    <p><%= (edad >= 0 ? edad + " años" : "No disponible")%></p>
                </div>
                <div class="info-item izquierda">
                    <img id="editarBoton" class="editarBoton" src="../img/editar_boton.svg" alt="Editar Información " ">
                </div>
            </div>

            <div id="modalPremio" class="modal">
                <div class="modal-content">
                    <p class="titulo-modal-content">Editar información</p>
                    <form action="editar_informacion_perfil_tutor.jsp" method="POST" id="info_actualizada">
                        <input type="hidden" name="idCastor" value="<%= idCastor%>">
                        <div class="item-modal-content">                      
                            <label>Nombre</label>
                            <input type="text" name="nombre-acutalizado" value="<%= nombre%>" id="nombre-acutalizado">
                            <span class = "error" id = "nombreError"></span>
                        </div>
                        <div class="item-modal-content">
                            <label>Apellidos</label>
                            <input type="text" name="apellidos-actualizado"  value="<%= apellidos%>" id="apellidos-actualizado">
                            <span class = "error" id = "apellidosError"></span>
                        </div>
                        <div class="item-modal-content">
                            <label>Correo Electronico</label>
                            <input type="email" name="email-actualizado" value="<%= email%>" id="email-actualizado"> 
                            <span class = "error" id = "correoError"></span>
                        </div>
                        <div class="item-modal-content">
                            <label>Contraseña</label>
                            <input type="text" name="contrasena-actualizada" value="<%= contraseña%>" id="contrasena-actualizada" >
                            <span class = "error" id = "contrasenaError"></span>
                        </div>

                        <div class="item-modal-content">
                            <label>Edad</label>
                            <input type="number" name="edad-actualizado" min="1" value="<%= edad%>" id="edad-actualizado">
                            <span class = "error" id = "edadError"></span>
                        </div>


                        <div class="item-modal-content-oper">
                            <button type="button" onclick="cerrarModal()" class="btn-cancelar-modal" >Cancelar</button>
                            <button type="submit" class="btn-crear-modal">Actualizar</button>
                        </div>
                    </form>
                </div>
                <%
                    } else {
                        response.sendRedirect("../formularios_sesion/inicio_sesion_tutor.jsp");
                    }
                %>
            </DIV>

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
                <div class="item-racha-no">
                    <div class="obj-4">

                        <div class="hijos">Mis hijos</div>
                        <div id="contenedor-hijos">
                            <%
                                session = request.getSession(false);
                                String email = (String) session.getAttribute("email");
                                Base bd = new Base();
                                boolean tieneHijos = false;
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
                                    bd.cierraConexion();
                                }
                            %>
                            <%
                                if (tieneHijos) {
                                    try {
                                        bd.conectar();
                                        String queryHijos = "SELECT * FROM Kit WHERE codPresa IN (SELECT codPresa FROM Castor WHERE email = ?)";
                                        PreparedStatement pstmtHijos = bd.getConn().prepareStatement(queryHijos);
                                        pstmtHijos.setString(1, email);
                                        ResultSet rsHijos = pstmtHijos.executeQuery();

                                        while (rsHijos.next()) {
                                            String nombreHijo = rsHijos.getString("nombreUsuario");
                                            String imagenPerfilHijo = rsHijos.getString("imagenPerfil");
                            %>
                            <div>
                                <div id="hijo">
                                    <div class="image12"><img src="<%= imagenPerfilHijo%>" alt="Imagen de <%= nombreHijo%>" 
                                                              class="imagenHijo"></div>
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
                                        bd.cierraConexion();
                                    }
                                } else {

                                }
                            %>
                        </div> 
                        <div class="Mas"> 
                            <a href="../formularios_sesion/registro_hijo.jsp" class="ButtonMas">
                                <div class="imagencita">
                                    <img src="../img/MasHijo.svg" class="IMGMas">
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="../codigo_js/codigo_javascript_tutor/js_perfil_tutor.js" type="text/javascript"></script>
    </body>
</html>