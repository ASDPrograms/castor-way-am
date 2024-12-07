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
                    <%
                        session = request.getSession(false);

                        if (session != null && session.getAttribute("idKit") != null) {
                            String idKitInt = (String) session.getAttribute("idKit");
                    %>
                    <%
                        Base bd = new Base();
                        try {
                            bd.conectar();

                            String consult2 = "select * from Kit where idKit = ?";
                            PreparedStatement pstmt5 = bd.getConn().prepareStatement(consult2);
                            pstmt5.setString(1, idKitInt);
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
                        if (session != null && session.getAttribute("usuario") != null) {
                            PreparedStatement pstmt5 = null;
                            ResultSet rs2 = null;
                            Base bd = new Base();

                            int idKit = 0;
                            try {
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

                            if (idKit == 0) {
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
                            pstmt6.setInt(1, idKit);
                            rs2 = pstmt6.executeQuery();

                            List<String> estaSemana = new ArrayList<>();
                            List<String> siguienteSemana = new ArrayList<>();
                            List<String> masTarde = new ArrayList<>();
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
                                        <form id="formActividad" method="post" action="actividades_hijo.jsp">
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
                                        <form id="formActividad" method="post" action="actividades_hijo.jsp">
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
                                        <form id="formActividad" method="post" action="actividades_hijo.jsp">
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
        <%            String idActividadConsultInfoActividad = request.getParameter("idActividad");
            String idKitConsultInfoActividad = request.getParameter("idKit");

            PreparedStatement pstmt = null;
            ResultSet rsConsultInfoActividad = null;
            Base bd = new Base();

            try {
                bd.conectar();

                String query = "SELECT * FROM actividad WHERE idActividad = ? AND idKit = ?";
                pstmt = bd.getConn().prepareStatement(query);
                pstmt.setString(1, idActividadConsultInfoActividad);
                pstmt.setString(2, idKitConsultInfoActividad);
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
                            <div class="actividad-desplegada-completar-div" style="display: flex; flex-direction: column; align-items: end; padding: 10px;">
                                <button onclick="abrirCompletarActividadModal()">Marcar como completado</button>
                                <span></span>
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
        <script src="../codigo_js/codigo_javascript_hijo/js_actividades_hijo.js" type="text/javascript"></script>

    </body>
</html>
