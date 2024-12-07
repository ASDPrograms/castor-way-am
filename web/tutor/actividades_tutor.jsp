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
        <link href="../estilos_css/estilos_tutor/css_actividades_tutor.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">
        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Actividades - CastorWay</title>
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("email") == null) {
                response.sendRedirect("../formularios_sesion/inicio_sesion_tutor.jsp");
            } else {
                try {
                    int idCastor = 0;
                    Base bd = new Base();
                    bd.conectar();

                    String email = (String) session.getAttribute("email");
                    String query = "SELECT * FROM Castor WHERE email = ?";
                    PreparedStatement pstmt7 = bd.getConn().prepareStatement(query);
                    pstmt7.setString(1, email);
                    ResultSet rs = pstmt7.executeQuery();

                    if (rs.next()) {
                        idCastor = rs.getInt(1);
                        session.setAttribute("idCastor", idCastor);
                    }
                } catch (Exception e) {
                }

            }
        %>
        <%
            String nombreHabito = (String) session.getAttribute("nombreHabito");
            String tipoHabito = (String) session.getAttribute("tipoHabito");
            String numRamitas = (String) session.getAttribute("numRamitas");
            String repeticiones = (String) session.getAttribute("repeticiones");
            String diaInicioHabito = (String) session.getAttribute("diaInicioHabito");
            String diaMetaHabito = (String) session.getAttribute("diaMetaHabito");
            String horaInicioHabito = (String) session.getAttribute("horaInicioHabito");
            String horaFinHabito = (String) session.getAttribute("horaFinHabito");
            String color = (String) session.getAttribute("color");
            String rutaImagenHabito = (String) session.getAttribute("rutaImagenHabito");
            String infoExtraHabito = (String) session.getAttribute("infoExtraHabito");
            String toastMessage = (String) session.getAttribute("error");

            // Limpiar la sesión después de usar el mensaje
        %>
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
                <div class="menu-item" id = "div_nav_home">
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
                    <a style="display: flex; padding-bottom: 0;" id="text-tit-act-sec-nav">Actividades</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <%                            session = request.getSession(false);

                        if (session != null && session.getAttribute("idKit") != null) {
                            String idKit = (String) session.getAttribute("idKit");
                            int idKitInt = Integer.parseInt(idKit);
                    %>
                    <%                            Base bd = new Base();
                        try {
                            bd.conectar();

                            String consult2 = "select * from Kit where idKit = ?";
                            PreparedStatement pstmt5 = bd.getConn().prepareStatement(consult2);
                            pstmt5.setInt(1, idKitInt);
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
                    <a id="icono-perfil-secondary-nav" href="perfil_tutor.jsp" style="display: flex;"> <img src="../img/icono_Perfil.svg" class = "imgNavSecondary"></a>
                </div>
            </div>
            <div class="cuerpo-actividades">
                <div class="arriba">
                    <div class="izquierda-form-buscador">
                        <div class="InputContainer">
                            <div class = "form-busqueda">
                                <div class = "container-buscador">
                                    <div class = "izquierda-buscador-input">
                                        <input
                                            placeholder="Search"
                                            id="inputBuscador"
                                            class="input"
                                            name="text"
                                            type="text"
                                            oninput="buscarActividades()"
                                            />
                                    </div>
                                    <div class = "derecha-buscador-icono">
                                        <label class="labelforsearch" for="input">
                                            <svg class="searchIcon" viewBox="0 0 512 512">
                                            <path
                                                d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"
                                                ></path>
                                            </svg>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="derecha-derecha-form-filtros">
                        <button title="filter" class="filter toggle" onclick="openMenu()">
                            <div class="button-div">
                                <div class="izquierda-button-span">
                                    <span class="span-filtrar">Filtrar</span>
                                </div>
                                <div class="derecha-button-icono">
                                    <svg viewBox="0 0 512 512" height="1em">
                                    <path
                                        d="M0 416c0 17.7 14.3 32 32 32l54.7 0c12.3 28.3 40.5 48 73.3 48s61-19.7 73.3-48L480 448c17.7 0 32-14.3 32-32s-14.3-32-32-32l-246.7 0c-12.3-28.3-40.5-48-73.3-48s-61 19.7-73.3 48L32 384c-17.7 0-32 14.3-32 32zm128 0a32 32 0 1 1 64 0 32 32 0 1 1 -64 0zM320 256a32 32 0 1 1 64 0 32 32 0 1 1 -64 0zm32-80c-32.8 0-61 19.7-73.3 48L32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l246.7 0c12.3 28.3 40.5 48 73.3 48s61-19.7 73.3-48l54.7 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-54.7 0c-12.3-28.3-40.5-48-73.3-48zM192 128a32 32 0 1 1 0-64 32 32 0 1 1 0 64zm73.3-64C253 35.7 224.8 16 192 16s-61 19.7-73.3 48L32 64C14.3 64 0 78.3 0 96s14.3 32 32 32l86.7 0c12.3 28.3 40.5 48 73.3 48s61-19.7 73.3-48L480 128c17.7 0 32-14.3 32-32s-14.3-32-32-32L265.3 64z"
                                        ></path>
                                    </svg>
                                </div>
                            </div>
                        </button>
                        <div class="opciones-menu" id="opciones-menu" style="display: none;">
                            <button type="button" class="close-button" onclick="closeMenu()">X</button>
                            <button type="button" class="limpiar-filtros" onclick="clearFilters()">Limpiar Filtros</button>

                            <h4>Selecciona los filtros:</h4>
                            <div class="checkbox-group">

                                <h5 class="tit-filtros-elegir">Categoría de la Actividad</h5>
                                <label><input type="checkbox" name="categoria" value="Salud" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos de Salud</label><br>
                                <label><input type="checkbox" name="categoria" value="Productividad" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos de Productividad</label><br>
                                <label><input type="checkbox" name="categoria" value="Personales" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos Personales</label><br>
                                <label><input type="checkbox" name="categoria" value="Sociales" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos Sociales</label><br>
                                <label><input type="checkbox" name="categoria" value="Financieros" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos Financieros</label><br>
                                <label><input type="checkbox" name="categoria" value="Emocionales" class="input-check-box-categorias-filtros" onclick="filtrarPorTipo()"> Hábitos Emocionales</label><br>

                                <h5 class="tit-filtros-elegir">Número de ramitas de recompensa</h5>
                                <div class="input-wrapper">
                                    <input type="number" id="recompensaActividadFilt" name="recompensaFiltro" class="input-nuevo-habito" oninput="filtrarPorNumRamitas()">
                                    <span class="input-icon">
                                        <img src="../img/icono_ramita.svg" alt="icono-recompensa">
                                    </span>
                                </div>
                                <br>
                                <h5 class="tit-filtros-elegir">Frecuencia de Repetición</h5>
                                <label><input type="checkbox" name="frecuencia" value="semanal" class="input-check-box-categorias-filtros" onclick="filtrarPorFrecuenciaRep()"> Días de la Semana</label><br>
                                <label><input type="checkbox" name="frecuencia" value="mensual" class="input-check-box-categorias-filtros" onclick="filtrarPorFrecuenciaRep()"> Días del Mes</label><br>
                                <label><input type="checkbox" name="frecuencia" value="intervalo" class="input-check-box-categorias-filtros" onclick="filtrarPorFrecuenciaRep()"> Intervalos</label><br>

                                <h5 class="tit-filtros-elegir">Rango de Fechas</h5>
                                <label>Desde:</label>
                                <div id="contenedor-input-fecha-inicio-id"  style="display: flex;">
                                    <input type="date" id="mi-calendario-inicial-filtro" class="input-nuevo-habito" name="calendarioInicialFiltro" style="width: 80%;" oninput="filtrarPorIntervalosDeFechas()">
                                </div>
                                <br>
                                <label>Hasta</label>
                                <div id="contenedor-input-fecha-inicio-id"  style="display: flex;">
                                    <input type="date" id="mi-calendario-final-filtro" class="input-nuevo-habito" name="calendarioFinalFiltro" style="width: 80%;" oninput="filtrarPorIntervalosDeFechas()">
                                </div>
                                <br>
                                <h5 class="tit-filtros-elegir">Estado de la Actividad</h5>
                                <label><input type="checkbox" name="estado" value="completada" class="input-check-box-categorias-filtros" onclick="filtrarPorEstadoActividad()"> Completada</label><br>
                                <label><input type="checkbox" name="estado" value="en-progreso" class="input-check-box-categorias-filtros" onclick="filtrarPorEstadoActividad()"> En Progreso</label><br>
                                <label><input type="checkbox" name="estado" value="no-iniciada" class="input-check-box-categorias-filtros" onclick="filtrarPorEstadoActividad()"> Sin terminar</label><br>

                                <h5 class="tit-filtros-elegir">Icono o Color Asociado</h5>
                                <label>
                                    <input type="checkbox" name="color" value="rojo" class="input-check-box-categorias-filtros" onclick="filtrarPorColor()"> 
                                    <div style="background-color: #FF595E; height: 15px; width: 15px; border-radius: 50%; display: inline-block; margin: 0 auto;"></div> 
                                    <span>Rojo</span>
                                </label><br>

                                <label>
                                    <input type="checkbox" name="color" value="amarillo" class="input-check-box-categorias-filtros" onclick="filtrarPorColor()"> 
                                    <div style="background-color: #FFCA3A; height: 15px; width: 15px; border-radius: 50%; display: inline-block; margin: 0 auto;"></div> 
                                    <span>Amarillo</span>
                                </label><br>

                                <label>
                                    <input type="checkbox" name="color" value="azul" class="input-check-box-categorias-filtros" onclick="filtrarPorColor()"> 
                                    <div style="background-color: #1982C4; height: 15px; width: 15px; border-radius: 50%; display: inline-block; margin: 0 auto;"></div> 
                                    <span>Azul</span>
                                </label><br>

                                <label>
                                    <input type="checkbox" name="color" value="verde" class="input-check-box-categorias-filtros" onclick="filtrarPorColor()"> 
                                    <div style="background-color: #8AC926; height: 15px; width: 15px; border-radius: 50%; display: inline-block; margin: 0 auto;"></div> 
                                    <span>Verde</span>
                                </label><br>

                                <label>
                                    <input type="checkbox" name="color" value="morado" class="input-check-box-categorias-filtros" onclick="filtrarPorColor()"> 
                                    <div style="background-color: #6A4C93; height: 15px; width: 15px; border-radius: 50%; display: inline-block; margin: 0 auto;"></div> 
                                    Morado
                                </label><br>

                            </div>
                        </div>

                    </div>







                </div>
                <div class="medio">
                    <%
                        session = request.getSession(false);
                        if (session != null && session.getAttribute("email") != null) {
                            String email = (String) session.getAttribute("email");
                            Base bd = new Base();
                            PreparedStatement pstmt5 = null;
                            ResultSet rs2 = null;

                            String idKit = request.getParameter("idKit");
                            if (idKit != null && !idKit.isEmpty()) {
                                session.setAttribute("idKit", idKit);
                            } else {
                                idKit = (String) session.getAttribute("idKit");
                            }

                            if (idKit == null || idKit.isEmpty()) {
                    %>
                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado">
                        <div  id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">Seleccionar primero una cuenta de Kit para poder acceder a la información de esa cuenta.</p>
                        </div>

                    </div>
                    <%
                    } else {
                        PreparedStatement pstmt6 = null;
                        try {
                            bd.conectar();

                            String query = "SELECT * FROM Actividad WHERE idKit = ?";
                            pstmt6 = bd.getConn().prepareStatement(query);
                            pstmt6.setInt(1, Integer.parseInt(idKit));
                            rs2 = pstmt6.executeQuery();

                            List<String> estaSemana = new ArrayList<>();
                            List<String> siguienteSemana = new ArrayList<>();
                            List<String> masTarde = new ArrayList<>();

                            // Fecha actual
                            LocalDate today = LocalDate.now();
                            LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
                            LocalDate endOfWeek = startOfWeek.plusDays(6);
                            LocalDate startOfNextWeek = endOfWeek.plusDays(1);
                            LocalDate endOfNextWeek = startOfNextWeek.plusDays(6);

                            while (rs2.next()) {
                                java.sql.Date diaMeta = rs2.getDate("diaMetaHabito");

                                LocalDate diaMetaLocal = diaMeta.toLocalDate();

                                String iconoHabitoDespl = rs2.getString("rutaImagenHabito");
                                String nombreHabitoDespl = rs2.getString("nombreHabito");
                                String numRamitasDespl = rs2.getString("numRamitas");
                                String horaFinHabitoDespl = rs2.getString("horaFinHabito");
                                String horaInicioHabitoDespl = rs2.getString("horaInicioHabito");
                                String idActividad = rs2.getString("idActividad");
                                String idKitForm = rs2.getString("idKit");
                                String idCastorForm = rs2.getString("idCastor");

                                String tipoActiForm = rs2.getString("tipoHabito");
                                String frecuenciaRepForm = rs2.getString("repeticiones");
                                String estadoActividadForm = rs2.getString("estadoActividad");
                                String colorActividadForm = rs2.getString("color");
                                String fechaInicialActividadForm = rs2.getString("diaInicioHabito");
                                String fechaFinalActividadForm = rs2.getString("diaMetaHabito");

                                String actividad = String.format("%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s",
                                        iconoHabitoDespl, nombreHabitoDespl, numRamitasDespl,
                                        horaFinHabitoDespl, horaInicioHabitoDespl, idActividad,
                                        idKitForm, idCastorForm, tipoActiForm, frecuenciaRepForm,
                                        estadoActividadForm, colorActividadForm, fechaInicialActividadForm, fechaFinalActividadForm);
                                if ((diaMetaLocal.isEqual(startOfWeek) || diaMetaLocal.isAfter(startOfWeek)) && diaMetaLocal.isBefore(endOfWeek.plusDays(1))) {
                                    estaSemana.add(actividad);
                                } else if (diaMetaLocal.isEqual(startOfNextWeek) || (diaMetaLocal.isAfter(endOfWeek) && diaMetaLocal.isBefore(endOfNextWeek.plusDays(1)))) {
                                    siguienteSemana.add(actividad);
                                } else if (diaMetaLocal.isAfter(endOfNextWeek)) {
                                    masTarde.add(actividad);
                                }
                            }

                            rs2.close();

                    %>

                    <div class="seccion" id="div-esta-semana-act">
                        <div id="div-esta-semana-act-arriba" onclick="toggleContentActividades()">
                            <div id="div-text-esta-semana-act">
                                <h3 class="text-distribucion-actividades">Esta Semana</h3>
                            </div>
                            <div id="div-icono-desplegar-act">
                                <span class="contador-actividades"><%= estaSemana.size()%></span>
                                <img src="../img/flechita-abajo.svg" id="img-flechita">
                            </div>
                        </div>
                        <div id="div-esta-semana-act-abajo">
                            <%
                                for (String contenido : estaSemana) {
                                    String[] detallesActividad = contenido.split("\\|"); // Usando | como delimitador
                                    String iconoHabit = detallesActividad[0];
                                    String nombreHabit = detallesActividad[1];
                                    String numRamitasHabit = detallesActividad[2];
                                    String horaFinHabit = detallesActividad[3];
                                    String horaIniciHabit = detallesActividad[4];
                                    String idActividadForm = detallesActividad[5];
                                    String idKitMandarForm = detallesActividad[6];
                                    String idCastorMandarForm = detallesActividad[7];
                                    String tipoAct = detallesActividad[8];
                                    String frecuenciaRep = detallesActividad[9];
                                    String estadoAct = detallesActividad[10];
                                    String colorActi = detallesActividad[11];
                                    String dateIniActi = detallesActividad[12];
                                    String dateFinalActi = detallesActividad[13];
                            %>
                            <div class="contenedor-cada-actividad">


                                <span class="text-tipo-act-habit-desplegado" style="display: none;"><%= tipoAct%></span>
                                <span class="text-estado-act-habit-desplegado" style="display: none;"><%= estadoAct%></span>
                                <span class="text-color-act-habit-desplegado" style="display: none;"><%= colorActi%></span>
                                <span class="text-frecuencia-rep-habit-desplegado" style="display: none;"><%= frecuenciaRep%></span>
                                <span class="text-date-ini-habit-desplegado" style="display: none;"><%= dateIniActi%></span>
                                <span class="text-date-fin-habit-desplegado" style="display: none;"><%= dateFinalActi%></span>

                                <div class="actividad-desplegada-icono">
                                    <img src="<%= iconoHabit%>" class="imgIconoActividad">
                                </div>
                                <div class="actividad-despleada-nombre-ramitas">
                                    <div class="actividad-despleada-nombre">
                                        <span class="text-nombre-habit-desplegado">
                                            <%= nombreHabit%>
                                        </span>
                                    </div>
                                    <div class="actividad-despleada-ramitas">
                                        <div class="cont-img-icono-ramita-num-ramitas">
                                            <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                        </div>
                                        <div>
                                            <label id="text-num-ramitas-despl-acti"><%= numRamitasHabit%> Ramitas</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="actividad-desplegada-horario">
                                    <div class="div-botoncito-actividad-desplegada">
                                        <form id="formActividad" method="post" action="actividades_tutor.jsp">
                                            <input type="hidden" value="<%= idActividadForm%>" name="idActividad">
                                            <input type="hidden" value="<%= idKitMandarForm%>" name="idKit">
                                            <input type="hidden" value="<%= idCastorMandarForm%>" name="idCastor">
                                            <button type="submit" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="abrirModal()">
                                                Ir
                                            </button>
                                        </form>
                                    </div>
                                    <div class="div-horarios-actividad-desplegada">
                                        <div class="contenedor-hora-inicio-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaIniciHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                        <div style="
                                             font-family: 'Gayathri', system-ui;
                                             font-weight: 700;
                                             font-style: normal;
                                             font-size: .9rem;">
                                            <span>-</span>
                                        </div>
                                        <div class="contenedor-hora-fin-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaFinHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div>
                    <div class="seccion" id="div-siguiente-semana-act">
                        <div id="div-siguiente-semana-act-arriba" onclick="toggleContentActividades2()">
                            <div id="div-text-siguiente-semana-act">
                                <h3 class="text-distribucion-actividades">Siguiente Semana</h3>
                            </div>
                            <div id="div-icono-desplegar-act">
                                <span class="contador-actividades"><%= siguienteSemana.size()%></span>
                                <img src="../img/flechita-abajo.svg" id="img-flechita2">
                            </div>
                        </div>
                        <div id="div-siguiente-semana-act-abajo">
                            <%
                                for (String contenido : siguienteSemana) {
                                    String[] detallesActividad = contenido.split("\\|"); // Usando | como delimitador
                                    String iconoHabit = detallesActividad[0];
                                    String nombreHabit = detallesActividad[1];
                                    String numRamitasHabit = detallesActividad[2];
                                    String horaFinHabit = detallesActividad[3];
                                    String horaIniciHabit = detallesActividad[4];
                                    String idActividadForm = detallesActividad[5];
                                    String idKitMandarForm = detallesActividad[6];
                                    String idCastorMandarForm = detallesActividad[7];
                                    String tipoAct = detallesActividad[8];
                                    String frecuenciaRep = detallesActividad[9];
                                    String estadoAct = detallesActividad[10];
                                    String colorActi = detallesActividad[11];
                                    String dateIniActi = detallesActividad[12];
                                    String dateFinalActi = detallesActividad[13];
                            %>
                            <div class="contenedor-cada-actividad">

                                <span class="text-tipo-act-habit-desplegado" style="display: none;"><%= tipoAct%></span>
                                <span class="text-frecuencia-rep-habit-desplegado" style="display: none;"><%= frecuenciaRep%></span>
                                <span class="text-estado-act-habit-desplegado" style="display: none;"><%= estadoAct%></span>
                                <span class="text-color-act-habit-desplegado" style="display: none;"><%= colorActi%></span>
                                <span class="text-date-ini-habit-desplegado" style="display: none;"><%= dateIniActi%></span>
                                <span class="text-date-fin-habit-desplegado" style="display: none;"><%= dateFinalActi%></span>

                                <div class="actividad-desplegada-icono">
                                    <img src="<%= iconoHabit%>" class="imgIconoActividad">
                                </div>
                                <div class="actividad-despleada-nombre-ramitas">
                                    <div class="actividad-despleada-nombre">
                                        <span class="text-nombre-habit-desplegado">
                                            <%= nombreHabit%>
                                        </span>
                                    </div>
                                    <div class="actividad-despleada-ramitas">
                                        <div class="cont-img-icono-ramita-num-ramitas">
                                            <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                        </div>
                                        <div>
                                            <label id="text-num-ramitas-despl-acti"><%= numRamitasHabit%> Ramitas</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="actividad-desplegada-horario">
                                    <div class="div-botoncito-actividad-desplegada">
                                        <form id="formActividad" method="post" action="actividades_tutor.jsp">
                                            <input type="hidden" value="<%= idActividadForm%>" name="idActividad">
                                            <input type="hidden" value="<%= idKitMandarForm%>" name="idKit">
                                            <input type="hidden" value="<%= idCastorMandarForm%>" name="idCastor">
                                            <button type="submit" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="abrirModal()">
                                                Ir
                                            </button>
                                        </form>
                                    </div>
                                    <div class="div-horarios-actividad-desplegada">
                                        <div class="contenedor-hora-inicio-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaIniciHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                        <div style="
                                             font-family: 'Gayathri', system-ui;
                                             font-weight: 700;
                                             font-style: normal;
                                             font-size: .9rem;">
                                            <span>-</span>
                                        </div>
                                        <div class="contenedor-hora-fin-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaFinHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div>
                    <div class="seccion" id="div-mas-tarde-act">
                        <div id="div-mas-tarde-act-arriba" onclick="toggleContentActividades3()">
                            <div id="div-mas-tarde-act">
                                <h3 class="text-distribucion-actividades">Más tarde</h3>
                            </div>
                            <div id="div-icono-desplegar-act">
                                <span class="contador-actividades"><%= masTarde.size()%></span>
                                <img src="../img/flechita-abajo.svg" id="img-flechita3">
                            </div>
                        </div>
                        <div id="div-mas-tarde-act-abajo">
                            <%
                                for (String contenido : masTarde) {
                                    String[] detallesActividad = contenido.split("\\|"); // Usando | como delimitador
                                    String iconoHabit = detallesActividad[0];
                                    String nombreHabit = detallesActividad[1];
                                    String numRamitasHabit = detallesActividad[2];
                                    String horaFinHabit = detallesActividad[3];
                                    String horaIniciHabit = detallesActividad[4];
                                    String idActividadForm = detallesActividad[5];
                                    String idKitMandarForm = detallesActividad[6];
                                    String idCastorMandarForm = detallesActividad[7];
                                    String tipoAct = detallesActividad[8];
                                    String frecuenciaRep = detallesActividad[9];
                                    String estadoAct = detallesActividad[10];
                                    String colorActi = detallesActividad[11];
                                    String dateIniActi = detallesActividad[12];
                                    String dateFinalActi = detallesActividad[13];
                            %>
                            <div class="contenedor-cada-actividad">
                                <span class="text-tipo-act-habit-desplegado" style="display: none;"><%= tipoAct%></span>
                                <span class="text-estado-act-habit-desplegado" style="display: none;"><%= estadoAct%></span>
                                <span class="text-color-act-habit-desplegado" style="display: none;"><%= colorActi%></span>
                                <span class="text-frecuencia-rep-habit-desplegado" style="display: none;"><%= frecuenciaRep%></span>
                                <span class="text-date-ini-habit-desplegado" style="display: none;"><%= dateIniActi%></span>
                                <span class="text-date-fin-habit-desplegado" style="display: none;"><%= dateFinalActi%></span>

                                <div class="actividad-desplegada-icono">
                                    <img src="<%= iconoHabit%>" class="imgIconoActividad">
                                </div>
                                <div class="actividad-despleada-nombre-ramitas">
                                    <div class="actividad-despleada-nombre">
                                        <span class="text-nombre-habit-desplegado">
                                            <%= nombreHabit%>
                                        </span>
                                    </div>
                                    <div class="actividad-despleada-ramitas">
                                        <div class="cont-img-icono-ramita-num-ramitas">
                                            <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                        </div>
                                        <div>
                                            <label id="text-num-ramitas-despl-acti"><%= numRamitasHabit%> Ramitas</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="actividad-desplegada-horario">
                                    <div class="div-botoncito-actividad-desplegada">
                                        <form id="formActividad" method="post" action="actividades_tutor.jsp">
                                            <input type="hidden" value="<%= idActividadForm%>" name="idActividad">
                                            <input type="hidden" value="<%= idKitMandarForm%>" name="idKit">
                                            <input type="hidden" value="<%= idCastorMandarForm%>" name="idCastor">
                                            <button type="submit" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="abrirModal()">
                                                Ir
                                            </button>
                                        </form>
                                    </div>
                                    <div class="div-horarios-actividad-desplegada">
                                        <div class="contenedor-hora-inicio-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaIniciHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                        <div style="
                                             font-family: 'Gayathri', system-ui;
                                             font-weight: 700;
                                             font-style: normal;
                                             font-size: .9rem;">
                                            <span>-</span>
                                        </div>
                                        <div class="contenedor-hora-fin-act-deplegada">
                                            <span class="text-horarios-desplegados">
                                                <%= horaFinHabit.substring(0, 5)%>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div>
                    <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs2 != null) {
                                        try {
                                            rs2.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    if (pstmt6 != null) {
                                        try {
                                            pstmt6.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }

                                }
                            }
                        }

                    %>
                </div>
            </div>
        </div>

        <div class="container-wrapper" id="container-wrapper">
            <div class = "div-container-table-scroll">
                <table class="tabla">
                    <tr>
                        <%                                        PreparedStatement pstmt7 = null;
                            ResultSet rs = null;
                            PreparedStatement pstmt8 = null;
                            ResultSet rs2 = null;
                            PreparedStatement pstmt9 = null;
                            ResultSet rs3 = null;
                            String email = (String) session.getAttribute("email");

                            session = request.getSession(false);
                            if (session != null && session.getAttribute("email") != null) {
                                pstmt7 = null;
                                rs = null;

                                try {
                                    Base bd = new Base();
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
                                <form action="procesa_tutor_actividades.jsp" method="post" style="display: inline;" id="pruebapaber">
                                    <input type="text" id="idKit" name="idKit" style="display: none;" value="<%= rsp.getString(1)%>">
                                    <button type="submit" style="background: none; border: none; padding: 0; cursor: pointer; height: auto; height: auto; display: flex; align-content: center; align-items: center; position: relative; z-index: 100000;">
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

                        %>
                        <td id = "td-burbujas-escondidas">
                            <form action="procesa_tutor_actividades.jsp" method="post" style="display: inline;" id="pruebapaber2">
                                <input type="text" id="idKit" name="idKit" value="<%= rs3.getString(1)%>" style="display: none;">
                                <button type="submit" class="icon-button" style="background: none; border: none; padding: 0; cursor: pointer; display: flex; align-items: center; position: relative; z-index: 100000;">
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
                                <div class="contenedor-button-add-actividad">
                                    <%
                                        String codPresaMandar = "hola";
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
                                    <a style="text-decoration: none;" href="../formularios_sesion/registro_hijo.jsp?returnUrl=<%= request.getRequestURL()%>&codPresa=<%= codPresaMandar != null ? codPresaMandar : ""%>">  
                                        <button class="agregarHijo" id="agregarHijo"><img src="../img/icon_add.svg"/></button>
                                    </a>
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

        <%
            String idKit = (String) session.getAttribute("idKit");
        %>
        <div class="act_tit">
            <div class="contenedor-button-add-actividad">
                <button class="crearAct_Btn" id="crearActBtn"><img src="../img/icon_add.svg"/></button>
            </div>
        </div>

        <script>
            // Obtenemos el botón por su ID
            const button = document.getElementById('crearActBtn');

            <% if (idKit == null) { %>
            // Si idKit es null, deshabilitamos y ocultamos el botón
            button.disabled = true;
            button.style.display = "none";
            <% } else { %>
            // Si idKit tiene un valor, habilitamos el botón
            button.disabled = false;
            <% } %>
        </script>















        <%
            // Iniciar sesión
            session = request.getSession(false);
            if (session != null && session.getAttribute("email") != null) {

                PreparedStatement pstmt1 = null;
                PreparedStatement pstmt2 = null;
                rs = null;
                rs2 = null;

                try {
                    Base bd = new Base();
                    bd.conectar();

                    // Paso 1: Obtener idCastor donde el email coincide
                    String query = "SELECT * FROM Castor WHERE email = ?";
                    pstmt1 = bd.getConn().prepareStatement(query);
                    pstmt1.setString(1, email);
                    rs = pstmt1.executeQuery();

                    int idCastor = 0; // Variable para almacenar el idCastor

                    if (rs.next()) {
                        idCastor = rs.getInt(1); // Obtener idCastor
                    }

                    // Paso 2: Verificar si hay registros en relKitCastor con el idCastor obtenido
                    // Dentro del bloque donde verificas si hay hijos
                    if (idCastor > 0) {
                        String query2 = "SELECT * FROM relKitCastor WHERE idCastor = ?";
                        pstmt2 = bd.getConn().prepareStatement(query2);
                        pstmt2.setInt(1, idCastor); // Usar el idCastor obtenido
                        rs2 = pstmt2.executeQuery();

                        int count = 0;

                        while (rs2.next()) {
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






        <!-- Segundo nav dentro del contenido -->


        <!-- Modal -->
        <div id="modalCrearActividad" class="modal-crear-actividad">
            <div class="modal-content-crear-actividad">
                <form action="formulario_procesa_tutor_actividades.jsp" method="post" id="formulario-nuevo-habito" style="width: auto; height: 100%;">
                    <input id="idActividadEditarActividad" name="idActividadEditarActividad" type="hidden">
                    <div class="modal-titulo">
                        <p id="p-nuevo-habito-tit">Nuevo hábito</p>
                    </div>
                    <div class="modal-separacion1">
                        <div class="input-nombre-habito-container">
                            <span class="texto-input-nuevo-habito">Nombre del hábito</span>
                            <input type="text" id="nombreHabito" name="nombreHabito" class="input-nuevo-habito" placeholder="Ingresa el nombre que llevará el hábito" onfocus="showOptionsNombre()" oninput="filterOptionsNombre()"  value="<%= nombreHabito != null ? nombreHabito : ""%>">
                            <div class="options-nombre" id="options-nombre">
                                <div class="category-nombres">Hábitos de Salud</div>
                                <div data-value="Comer frutas y verduras" class="text-options-nombre-habito" onclick="llenarForm('Comer frutas y verduras')">Comer frutas y verduras</div>
                                <div data-value="Beber agua" class="text-options-nombre-habito" onclick="llenarForm('Beber agua')">Beber agua</div>
                                <div data-value="Hacer ejercicio" class="text-options-nombre-habito" onclick="llenarForm('Hacer ejercicio')">Hacer ejercicio</div>
                                <div data-value="Cepillarse los dientes" class="text-options-nombre-habito">Cepillarse los dientes</div>
                                <div data-value="Mantener higiene personal" class="text-options-nombre-habito">Mantener higiene personal</div>
                                <div data-value="Dormir lo necesario" class="text-options-nombre-habito">Dormir lo necesario</div>
                                <div data-value="Elegir snacks saludables" class="text-options-nombre-habito">Elegir snacks saludables</div>
                                <div data-value="Seguir una rutina de higiene" class="text-options-nombre-habito">Seguir una rutina de higiene</div>
                                <div data-value="Preparar tu desayuno" class="text-options-nombre-habito">Preparar tu desayuno</div>
                                <div data-value="Cuidar tu piel"class="text-options-nombre-habito">Cuidar tu piel</div>
                                <div class="category-nombres">Hábitos de Productividad</div>
                                <div data-value="Organizar su Mochila"class="text-options-nombre-habito">Organizar su Mochila</div>
                                <div data-value="Hacer la tarea"class="text-options-nombre-habito">Hacer la tarea</div>
                                <div data-value="Seguir una rutina de estudio"class="text-options-nombre-habito">Seguir una rutina de estudio</div>
                                <div data-value="Establecer metas diarias"class="text-options-nombre-habito">Establecer metas diarias</div>
                                <div data-value="Limpiar espacio personal"class="text-options-nombre-habito">Limpiar espacio personal</div>
                                <div data-value="Limpiar espacio de estudio"class="text-options-nombre-habito">Limpiar espacio de estudios</div>
                                <div data-value="Llevar diario personal en CastorWay"class="text-options-nombre-habito">Llevar diario personal en CastorWay</div>
                                <div data-value="Planificar actividades"class="text-options-nombre-habito">Planificar actividades</div>
                                <div data-value="Reflexionar sobre aprendizajes"class="text-options-nombre-habito">Reflexionar sobre aprendizajes</div>
                                <div class="category-nombres">Hábitos Personales</div>
                                <div data-value="Cuidar sus Pertenencias" class="text-options-nombre-habito">Cuidar sus Pertenencias</div>
                                <div data-value="Elegir su Ropa" class="text-options-nombre-habito">Elegir su Ropa</div>
                                <div data-value="Practicar un Hobby" class="text-options-nombre-habito">Practicar un Hobby</div>
                                <div data-value="Cuidar su Espacio Personal" class="text-options-nombre-habito">Cuidar su Espacio Personal</div>
                                <div data-value="Preparar su Almuerzo" class="text-options-nombre-habito">Preparar su Almuerzo</div>
                                <div data-value="Hacer su Cama" class="text-options-nombre-habito">Hacer su Cama</div>
                                <div data-value="Leer un Libro" class="text-options-nombre-habito">Leer un Libro</div>
                                <div data-value="Seguir Instrucciones" class="text-options-nombre-habito">Seguir Instrucciones</div>
                                <div data-value="Practicar la Independencia" class="text-options-nombre-habito">Practicar la Independencia</div>
                                <div data-value="Ser Responsable con los Animales" class="text-options-nombre-habito">Ser Responsable con los Animales</div>

                                <div class="category-nombres">Hábitos Sociales</div>
                                <div data-value="Saludar a las Personas" class="text-options-nombre-habito">Saludar a las Personas</div>
                                <div data-value="Invitar Amigos a Jugar" class="text-options-nombre-habito">Invitar Amigos a Jugar</div>
                                <div data-value="Compartir Juguetes" class="text-options-nombre-habito">Compartir Juguetes</div>
                                <div data-value="Escribir Cartas" class="text-options-nombre-habito">Escribir Cartas</div>
                                <div data-value="Resolver Conflictos" class="text-options-nombre-habito">Resolver Conflictos</div>
                                <div data-value="Participar en Juegos de Grupo" class="text-options-nombre-habito">Participar en Juegos de Grupo</div>
                                <div data-value="Practicar la Escucha Activa" class="text-options-nombre-habito">Practicar la Escucha Activa</div>
                                <div data-value="Dar Gracias" class="text-options-nombre-habito">Dar Gracias</div>
                                <div data-value="Mostrar Empatía" class="text-options-nombre-habito">Mostrar Empatía</div>
                                <div data-value="Participar en Proyectos de Clase" class="text-options-nombre-habito">Participar en Proyectos de Clase</div>

                                <div class="category-nombres">Hábitos Financieros</div>
                                <div data-value="Ahorrar Dinero" class="text-options-nombre-habito">Ahorrar Dinero</div>
                                <div data-value="Hacer Compras Pequeñas" class="text-options-nombre-habito">Hacer Compras Pequeñas</div>
                                <div data-value="Comparar Precios" class="text-options-nombre-habito">Comparar Precios</div>
                                <div data-value="Hacer un Registro de Gastos" class="text-options-nombre-habito">Hacer un Registro de Gastos</div>
                                <div data-value="Decidir Gastos" class="text-options-nombre-habito">Decidir Gastos</div>
                                <div data-value="Participar en el Presupuesto Familiar" class="text-options-nombre-habito">Participar en el Presupuesto Familiar</div>
                                <div data-value="Aprender el Valor de las Cosas" class="text-options-nombre-habito">Aprender el Valor de las Cosas</div>
                                <div data-value="Hacer Manualidades para Vender" class="text-options-nombre-habito">Hacer Manualidades para Vender</div>
                                <div data-value="Donar Dinero o Juguetes" class="text-options-nombre-habito">Donar Dinero o Juguetes</div>
                                <div data-value="Participar en Juegos de Dinero" class="text-options-nombre-habito">Participar en Juegos de Dinero</div>

                                <div class="category-nombres">Hábitos Emocionales</div>
                                <div data-value="Identificar Sus Sentimientos" class="text-options-nombre-habito">Identificar Sus Sentimientos</div>
                                <div data-value="Practicar la Gratitud" class="text-options-nombre-habito">Practicar la Gratitud</div>
                                <div data-value="Tomar un Tiempo para Reflexionar" class="text-options-nombre-habito">Tomar un Tiempo para Reflexionar</div>
                                <div data-value="Usar Técnicas de Relajación" class="text-options-nombre-habito">Usar Técnicas de Relajación</div>
                                <div data-value="Escribir en un Diario" class="text-options-nombre-habito">Escribir en un Diario</div>
                                <div data-value="Hablar de sus Sentimientos" class="text-options-nombre-habito">Hablar de sus Sentimientos</div>
                                <div data-value="Escuchar Música Relajante" class="text-options-nombre-habito">Escuchar Música Relajante</div>
                                <div data-value="Practicar la Paciencia" class="text-options-nombre-habito">Practicar la Paciencia</div>
                                <div data-value="Establecer un Espacio Seguro" class="text-options-nombre-habito">Establecer un Espacio Seguro</div>
                                <div data-value="Reflexionar sobre Sus Reacciones" class="text-options-nombre-habito">Reflexionar sobre Sus Reacciones</div>
                            </div>
                            <span id="nombreHabitoError" class="error-form-nuevo-habito">El nombre debe ser sin números y de al menos 3 caracteres</span>
                        </div>
                        <div class="input-icono-habito-container">
                            <div class="icon-picker">
                                <div id="iconDisplay" class="icon-display">
                                    <img id="selectedIcon" src="<%= rutaImagenHabito != null ? rutaImagenHabito : "../img/iconos_formularios/icono_selector_iconos.svg"%>" alt="Ícono seleccionado">
                                </div>
                            </div>

                            <!-- Input oculto para almacenar el src del icono seleccionado -->
                            <input type="hidden" id="iconSrcInput" name="iconSrc" value="<%= rutaImagenHabito != null ? rutaImagenHabito : ""%>">

                            <!-- Tabla para los íconos -->
                            <div id="iconOptions" class="icon-options" style="display: none;"> <!-- Esconde por defecto -->
                                <table>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/perro.png" class="icon-option" data-icon="perro"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/gato.png" class="icon-option" data-icon="gato"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/castillo.png" class="icon-option" data-icon="castillo"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/casa.png" class="icon-option" data-icon="casa"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/avion-papel.png" class="icon-option" data-icon="avion-papel"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/banco.png" class="icon-option" data-icon="banco"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/edificio.png" class="icon-option" data-icon="edificio"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/escuela.png" class="icon-option" data-icon="escuela"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/iglesia.png" class="icon-option" data-icon="iglesia"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/insecto.png" class="icon-option" data-icon="insecto"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/maletin.png" class="icon-option" data-icon="maletin"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/monumento.png" class="icon-option" data-icon="monumento"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/pizarron.png" class="icon-option" data-icon="pizarron"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/tachuela.png" class="icon-option" data-icon="tachuela"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/pera.png" class="icon-option" data-icon="pera"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/agua.png" class="icon-option" data-icon="agua"></td>
                                        <td class="td-iconos-form-habito"><img src="../img/iconos_formularios/pesa.png" class="icon-option" data-icon="pesa"></td>
                                    </tr>

                                </table>
                            </div>

                            <!-- Selector de color -->

                        </div>
                        <div class="input-color-icono-habito-container">
                            <div class="color-picker">
                                <%
                                    // Establecer el color por defecto
                                    String backgroundColor = "#000000"; // Color negro por defecto
                                    if (color != null) {
                                        switch (color.toLowerCase()) {
                                            case "rojo":
                                                backgroundColor = "#FF595E"; // Rojo
                                                break;
                                            case "amarillo":
                                                backgroundColor = "#FFCA3A"; // Amarillo
                                                break;
                                            case "verde":
                                                backgroundColor = "#8AC926"; // Verde
                                                break;
                                            case "azul":
                                                backgroundColor = "#1982C4"; // Azul
                                                break;
                                            case "morado":
                                                backgroundColor = "#6A4C93"; // Morado
                                                break;
                                            default:
                                                backgroundColor = "#000000"; // Negro si no coincide
                                                break;
                                        }
                                    }
                                %>

                                <div id="colorDisplay" class="color-display" style="background-color: <%= backgroundColor%>;"></div>
                                <div id="colorOptions" class="color-options" style="display: none;">
                                    <table>
                                        <tr>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #ff595e;" data-color="rojo"></div>
                                            </td>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #ffca3a;" data-color="amarillo"></div>
                                            </td>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #8ac926;" data-color="verde"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #1982c4;" data-color="azul"></div>
                                            </td>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #6a4c93;" data-color="morado"></div>
                                            </td>
                                            <td class="td-color-input-actividad">
                                                <div class="color-option" style="background-color: #000000;" data-color="black"></div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <input type="hidden" id="selectedColorInput" name="selectedColor"  value="<%= color != null ? color : "black"%>">
                        </div>
                    </div>
                    <div class="modal-separacion2">
                        <div class="input-icon-number-container">
                            <span class="texto-input-nuevo-habito">Recompensa</span>
                            <div class="input-wrapper">
                                <input type="number" id="recompensaActividad" name="recompensaActividad" placeholder="Ingresa un número" class="input-nuevo-habito" value="<%= numRamitas != null ? numRamitas : ""%>">
                                <span class="input-icon">
                                    <img src="../img/icono_ramita.svg" alt="icono-recompensa">
                                </span>
                            </div>
                            <span id="errorRecompensa" class="error-form-nuevo-habito">Por favor, ingresa un número entre 1 y 100.</span>
                        </div>
                        <div class="input-tipo-container">
                            <span class="texto-input-nuevo-habito">Tipo</span>
                            <select id="opciones" name="opciones">
                                <option value="" disabled selected>--Seleccione--</option>
                                <option value="Salud">Salud</option>
                                <option value="Productividad">Productividad</option>
                                <option value="Personales">Personales</option>
                                <option value="Sociales">Sociales</option>
                                <option value="Financieros">Financieros</option>
                                <option value="Emocionales">Emocionales</option>
                            </select>
                            <span id="errorTipo" class="error-form-nuevo-habito">Por favor, seleccione una opción.</span>
                        </div>
                        <div class="input-repeticiones-container">
                            <div id="opciones_intervalos">
                                <span class="texto-input-nuevo-habito">Repeticiones</span>
                                <input type="text" id="main-input" readonly placeholder="Selecciona un intervalo" onclick="toggleDropdown2()" class="input-nuevo-habito" value="<%= repeticiones != null ? repeticiones : ""%>" name="repeticiones">
                                <div id="dropdown-menu-dia">
                                    <a id="option-dia" onclick="toggleSubmenu('submenu-dia')">Diariamente</a>
                                    <a id="option-mensual" onclick="toggleSubmenu('submenu-mensual')">Mensualmente</a>
                                    <a id="option-intervalos" onclick="toggleSubmenu('submenu-intervalos')">Intervalos</a>


                                    <!-- Submenú para los días -->
                                    <div id="submenu-dia" onmouseleave="ocultarSubmenu('submenu-dia')">
                                        <a onclick="toggleDaySelection('Lunes', this)">Lunes</a>
                                        <a onclick="toggleDaySelection('Martes', this)">Martes</a>
                                        <a onclick="toggleDaySelection('Miércoles', this)">Miércoles</a>
                                        <a onclick="toggleDaySelection('Jueves', this)">Jueves</a>
                                        <a onclick="toggleDaySelection('Viernes', this)">Viernes</a>
                                        <a onclick="toggleDaySelection('Sábado', this)">Sábado</a>
                                        <a onclick="toggleDaySelection('Domingo', this)">Domingo</a>
                                    </div>

                                    <div id="submenu-mensual" onmouseleave="ocultarSubmenu('submenu-mensual')">
                                        <div class="calendario">
                                            <div class="calendario-dias">
                                                <a onclick="toggleMonthDaySelection(1, this)"><span>1</span></a>
                                                <a onclick="toggleMonthDaySelection(2, this)"><span>2</span></a>
                                                <a onclick="toggleMonthDaySelection(3, this)"><span>3</span></a>
                                                <a onclick="toggleMonthDaySelection(4, this)"><span>4</span></a>
                                                <a onclick="toggleMonthDaySelection(5, this)"><span>5</span></a>
                                                <a onclick="toggleMonthDaySelection(6, this)"><span>6</span></a>
                                                <a onclick="toggleMonthDaySelection(7, this)"><span>7</span></a>
                                                <a onclick="toggleMonthDaySelection(8, this)"><span>8</span></a>
                                                <a onclick="toggleMonthDaySelection(9, this)"><span>9</span></a>
                                                <a onclick="toggleMonthDaySelection(10, this)"><span>10</span></a>
                                                <a onclick="toggleMonthDaySelection(11, this)"><span>11</span></a>
                                                <a onclick="toggleMonthDaySelection(12, this)"><span>12</span></a>
                                                <a onclick="toggleMonthDaySelection(13, this)"><span>13</span></a>
                                                <a onclick="toggleMonthDaySelection(14, this)"><span>14</span></a>
                                                <a onclick="toggleMonthDaySelection(15, this)"><span>15</span></a>
                                                <a onclick="toggleMonthDaySelection(16, this)"><span>16</span></a>
                                                <a onclick="toggleMonthDaySelection(17, this)"><span>17</span></a>
                                                <a onclick="toggleMonthDaySelection(18, this)"><span>18</span></a>
                                                <a onclick="toggleMonthDaySelection(19, this)"><span>19</span></a>
                                                <a onclick="toggleMonthDaySelection(20, this)"><span>20</span></a>
                                                <a onclick="toggleMonthDaySelection(21, this)"><span>21</span></a>
                                                <a onclick="toggleMonthDaySelection(22, this)"><span>22</span></a>
                                                <a onclick="toggleMonthDaySelection(23, this)"><span>23</span></a>
                                                <a onclick="toggleMonthDaySelection(24, this)"><span>24</span></a>
                                                <a onclick="toggleMonthDaySelection(25, this)"><span>25</span></a>
                                                <a onclick="toggleMonthDaySelection(26, this)"><span>26</span></a>
                                                <a onclick="toggleMonthDaySelection(27, this)"><span>27</span></a>
                                                <a onclick="toggleMonthDaySelection(28, this)"><span>28</span></a>
                                                <a onclick="toggleMonthDaySelection(29, this)"><span>29</span></a>
                                                <a onclick="toggleMonthDaySelection(30, this)"><span>30</span></a>
                                                <a onclick="toggleMonthDaySelection(31, this)"><span>31</span></a>

                                            </div>
                                        </div>
                                    </div>
                                    <div id="submenu-intervalos" onmouseleave="ocultarSubmenu('submenu-intervalos')">
                                        <a onclick="toggleIntervalSelection2('Repetir cada 2', this)">Repetir cada 2</a>
                                        <a onclick="toggleIntervalSelection2('Repetir cada 3', this)">Repetir cada 3</a>
                                        <a onclick="toggleIntervalSelection2('Repetir cada 4', this)">Repetir cada 4</a>
                                        <a onclick="toggleIntervalSelection2('Repetir cada 5', this)">Repetir cada 5</a>
                                        <a onclick="toggleIntervalSelection2('Repetir cada 6', this)">Repetir cada 6</a>
                                        <a onclick="toggleIntervalSelection2('Repetir cada 7', this)">Repetir cada 7</a>
                                    </div>
                                </div>
                                <span id="errorIntervalos" class="error-form-nuevo-habito">Por favor, seleccione una opción.</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-separacion3">
                        <div class="div-input-horario-inicio">
                            <span class="texto-input-nuevo-habito">Hora inicio</span>
                            <div id="div-contenedor-input-horas-inicio">
                                <div class="container-input-horas-inicio">
                                    <input type="time" id="hora-inicio" name="horaInicio" class="input-nuevo-habito" value="<%= horaInicioHabito != null ? horaInicioHabito : ""%>" style="width: 100%;">
                                </div>
                            </div>
                            <span id="errorHoraInicio" class="error-form-nuevo-habito">Por favor, seleccione una hora.</span>
                        </div>

                        <div class="div-input-horario-final">
                            <span class="texto-input-nuevo-habito">Hora Fin</span>
                            <div>
                                <div class="container-input-horas-inicio" id="contenedor-input-horas-fin-id">
                                    <input type="time" id="hora-final" name="horaFinal" class="input-nuevo-habito" value="<%= horaFinHabito != null ? horaFinHabito : ""%>" style="width: 100%;">
                                </div>
                            </div>
                            <span id="errorHoraFinal" class="error-form-nuevo-habito">Por favor, seleccione una hora.</span>
                        </div>



                        <div class="div-input-fecha-inicial">
                            <span class="texto-input-nuevo-habito">Fecha de Inicio</span>
                            <div>
                                <div id="contenedor-input-fecha-inicio-id"  style="display: flex;">
                                    <input type="date" id="mi-calendario-inicial" class="input-nuevo-habito" name="calendarioInicial" value="<%= diaInicioHabito != null ? diaInicioHabito : ""%>">
                                </div>
                            </div>
                            <span id="errorFechaInicial" class="error-form-nuevo-habito">Por favor, seleccione una fecha.</span>
                        </div>
                        <div class="div-input-fecha-final">
                            <span class="texto-input-nuevo-habito">Fecha de Fin</span>
                            <div class="input-wrapper">
                                <input type="date" id="mi-calendario-final" class="input-nuevo-habito" name="calendarioFinal" value="<%= diaMetaHabito != null ? diaMetaHabito : ""%>">
                            </div>
                            <span id="errorFechaFinal" class="error-form-nuevo-habito">Por favor, seleccione una fecha.</span>
                        </div>
                    </div>

                    <div class="modal-separacion4">
                        <div class="div-input-info-extra">
                            <span class="texto-input-nuevo-habito">Información</span>
                            <div id="contenedor-input-info-extra">
                                <textarea type="text" name="infoExtra" id="info-extra" class="input-nuevo-habito" placeholder="Ingresa información extra que quieras compartir con tu Kit sobre el hábito nuevo. No olvídes ser amable y apoyarlo siempre :)"><%= infoExtraHabito != null ? infoExtraHabito : ""%></textarea>
                            </div>
                            <span id="errorInfoExtra" class="error-form-nuevo-habito">Por favor, ingrese información extra.</span>
                            <div id="charCount">0/400 caracteres</div>
                        </div>
                    </div>

                    <div class="modal-separacion5">
                        <div class="modal-boton1">
                            <button id="cerrarModalBtn" class="cerrar-modal-btn">Cerrar</button>
                        </div>
                        <div class="modal-boton2">
                            <button type="submit" id="mandarFormsNuevaActividad">Crear</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%
            String idActividadConsultInfoActividad = request.getParameter("idActividad");
            String idKitConsultInfoActividad = request.getParameter("idKit");
            String idCastorConsultInfoActividad = request.getParameter("idCastor");

            PreparedStatement pstmt = null;
            ResultSet rsConsultInfoActividad = null;
            Base bd = new Base();

            try {
                bd.conectar();

                String query = "SELECT * FROM actividad WHERE idActividad = ? AND idKit = ? AND idCastor = ?";
                pstmt = bd.getConn().prepareStatement(query);
                pstmt.setString(1, idActividadConsultInfoActividad);
                pstmt.setString(2, idKitConsultInfoActividad);
                pstmt.setString(3, idCastorConsultInfoActividad);
                rsConsultInfoActividad = pstmt.executeQuery();

                if (rsConsultInfoActividad.next()) {
                    String estado = rsConsultInfoActividad.getString("estadoActividad");
                    String estadoMostrar = "";
                    String colorFondoDivEstado = "";
                    String colorTextoDivEstado = "";
                    if (estado == "0" || estado.equals("0")) {
                        estadoMostrar = "En proceso";
                        colorFondoDivEstado = "#FFD274";
                        colorTextoDivEstado = "#BC8E1B";
                    } else if (estado == "1" || estado.equals("1")) {
                        estadoMostrar = "Sin terminar";
                        colorFondoDivEstado = "#FF5C54";
                        colorTextoDivEstado = "#8F281F";
                    } else if (estado == "2" || estado.equals("2")) {
                        estadoMostrar = "Finalizado";
                        colorFondoDivEstado = "#66BD6E";
                        colorTextoDivEstado = "#328324";
                    }

        %>    
        <div id="modalActividadSeleccionadaInfo" class="modalActividadSeleccionadaInfo">
            <div class="modalActividadSeleccionadaInfoContent">
                <div class="contenedor-info-actividad-total">
                    <div class="contenedor-info-modal">
                        <div class="contenedor-info-modal-1">
                            <div class="contenedor-info-modal-1-contenedor-img-tit">
                                <div class="contenedor-info-modal-1-contenedor-img">
                                    <img id="img-icono-actividad-info-ver-actividad" src="<%= rsConsultInfoActividad.getString("rutaImagenHabito")%>">
                                </div>
                                <div class="contenedor-info-modal-1-contenedor-tit">
                                    <span class="span-tit-cafe-ver-info-actividad">
                                        <%= rsConsultInfoActividad.getString("nombreHabito")%></span>
                                </div>
                            </div>
                            <div class="contenedor-info-modal-1-contenedor-img-ramitas-text">
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad-info-act">
                                    </div>
                                    <div>
                                        <label id="text-num-ramitas-despl-actividad-tit"><%= rsConsultInfoActividad.getString("numRamitas")%> Ramitas</label>
                                    </div>
                                </div>
                            </div>
                            <div style="padding-top: 20px">
                                <span class="text-horas-fechas-actividad-info"><b>Tipo:</b> <%= rsConsultInfoActividad.getString("tipoHabito")%></span>
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_reloj_bordes.svg" class="imgRamitaRecompensa-desplegar-actividad-info-act" id="icono-hora-info-actividad">
                                    </div>
                                    <div style="padding-left: 10px;">
                                        <span class="text-horas-fechas-actividad-info"><%= rsConsultInfoActividad.getString("horaInicioHabito")%>   -  </span>
                                        <span class="text-horas-fechas-actividad-info"><%= rsConsultInfoActividad.getString("horaFinHabito")%></span>
                                    </div>
                                </div>
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_calendario_bordes.svg" class="imgRamitaRecompensa-desplegar-actividad-info-act" id="icono-calendario-info-actividad">
                                    </div>
                                    <div style="padding-left: 10px;">
                                        <span class="text-horas-fechas-actividad-info"><%= rsConsultInfoActividad.getString("diaInicioHabito")%>   -   </span>
                                        <span class="text-horas-fechas-actividad-info"><%= rsConsultInfoActividad.getString("diaMetaHabito")%></span>
                                    </div>
                                </div>
                                <div class="actividad-despleada-ramitas">
                                    <span type="button" id="editarActividadBtn" onclick="guardarYRedirigir()"><img src="../img/icono_editar_actividad.svg"> <u>Editar</u></span>
                                </div>
                            </div>
                        </div>
                        <div class="contenedor-info-modal-2">
                            <div style="flex: .2; padding-bottom: 20px;">
                                <div>
                                    <button class="close" onclick="cerrarModal()">
                                        <span class="X"></span>
                                        <span class="Y"></span>
                                    </button>
                                </div>
                            </div>
                            <div style="flex: .2;">
                                <div id="estadoActividadDiv" style="background-color: <%= colorFondoDivEstado%>">
                                    <span id="estadoTextoSpan" style="color: <%= colorTextoDivEstado%>"><%= estadoMostrar%></span>
                                </div>
                            </div>
                            <div id="div-info-extra-ver-info-actividad">
                                <span id="span-info-extra-ver-info-actividad"><b>Información:</b> <%= rsConsultInfoActividad.getString("infoExtraHabito")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="contenedor-info-extra-modal">
                        <div class="contenedor-info-extra-modal-1">
                            <img src="../img/ramitasImagen.svg" id="img_ramitas_sobrepuestas">
                        </div>
                        <div class="contenedor-info-extra-modal-2">
                            <span id="text-aviso-info-extra-modal-act" style="    font-family: 'Gayathri', system-ui;
                                  font-weight: 700;
                                  font-style: normal;
                                  ">¡Completa la actividad para recibir ramitas!</span>
                        </div>
                        <div class="contenedor-info-extra-modal-3">
                            <img id="img-contenedor-info-extra-modal-3" src="../img/icon_incognita.svg" style="margin: 0 auto;">
                        </div>
                    </div>
                </div>
                <span id="nombreHabitoDisplay"style="display: none;"><%= rsConsultInfoActividad.getString("nombreHabito")%></span>
                <span id="numRamitasDisplay"style="display: none;"><%= rsConsultInfoActividad.getString("numRamitas")%></span>
                <span id="tipoHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("tipoHabito")%></span>
                <span id="repeticionesDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("repeticiones")%></span>
                <span id="diaInicioHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("diaInicioHabito")%></span>
                <span id="diaMetaHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("diaMetaHabito")%></span>
                <span id="horaInicioHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("horaInicioHabito")%></span>
                <span id="horaFinHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("horaFinHabito")%></span>
                <span id="colorDisplayDesplegadoInfo" style="display: none;"><%= rsConsultInfoActividad.getString("color")%></span>
                <span id="rutaImagenHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("rutaImagenHabito")%></span>
                <span id="infoExtraHabitoDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("infoExtraHabito")%></span>
                <textarea name="infoExtraHabito" id="idInputModal-infoExtraHabito" style="display:none;"><%= rsConsultInfoActividad.getString("infoExtraHabito")%></textarea>
                <span id="estadoActividadDisplay" style="display: none;"><%= rsConsultInfoActividad.getString("estadoActividad")%></span>
                <span id="idActividadDisplay"style="display: none;"><%= idActividadConsultInfoActividad%></span>
                <input type="hidden" name="idActividad" value="<%= idActividadConsultInfoActividad%>">
                <input type="hidden" name="idKit" value="<%= idKitConsultInfoActividad%>">
                <input type="hidden" name="idCastor" value="<%= idCastorConsultInfoActividad%>">

                <%
                } else {
                %>
                <p>No se encontraron detalles para esta actividad.</p>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rsConsultInfoActividad != null) {
                            rsConsultInfoActividad.close();
                        }
                        if (pstmt != null) {
                            pstmt.close();
                        }
                        if (bd != null) {
                            bd.cierraConexion();
                        }
                    }
                %>

            </div>
        </div>

        <%
            String codPresaMandar = "hola";
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


        <div id="toast" class="toast">
            <span id="toastMessage" class="toastMessage">Error: La hora final no puede ser anterior o igual a la hora de inicio.</span>
        </div>
        <div id="toast-calendario" class="toast">
            <span  class="toastMessage">Error: La fecha de fin del hábito no puede ser anterior o igual a la fecha de inicio.</span>
        </div>
        <div id="toast-iconos" class="toast">
            <span  class="toastMessage">Error: No puede mandar el fomulario sin seleccionar un ícono</span>
        </div>
        <div id="toast-usuario-hijo" class="toast">
            <span  class="toastMessage">Error: No puede mandar el fomulario sin seleccionar un ícono</span>
        </div>

        <div id="toast-validar-informacion-formulario-correct" class="toastCorrect" style="display:
             <%
                 if (session.getAttribute("msjProcesaActividiadForm") != null && session.getAttribute("msjProcesaActividiadForm").equals("Actividad agregada exitosamente")) {
             %>
             block
             <%
             } else {
             %>
             none
             <%
                 }
             %>
             ;">
            <span class="toastMessage"><%= session.getAttribute("msjProcesaActividiadForm") != null ? session.getAttribute("msjProcesaActividiadForm") : ""%></span>
        </div>

        <div id="toast-validar-informacion-formulario" class="toast" style="display:
             <%
                 if (session.getAttribute("msjProcesaActividiadForm") != null && session.getAttribute("msjProcesaActividiadForm").toString().contains("Ya hay una actividad programada que se sobrepone al lapso de tiempo elegido.")) {
             %>
             block
             <%
             } else {
             %>
             none
             <%
                 }
             %>
             ;">
            <span class="toastMessage"><%= session.getAttribute("msjProcesaActividiadForm") != null ? session.getAttribute("msjProcesaActividiadForm") : ""%></span>
        </div>

        <%
            session.removeAttribute("msjProcesaActividiadForm");
        %>



        <%
            session.removeAttribute("msjProcesaActividiadForm");
        %>



        <script src="../codigo_js/codigo_javascript_tutor/js_actividades_tutor.js" type="text/javascript"></script>

    </body>
</html>
