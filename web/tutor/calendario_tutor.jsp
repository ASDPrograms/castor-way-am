<%@page import="java.time.ZoneId"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.ParseException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_tutor/css_calendario_tutor.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">
        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Calendario - CastorWay</title>
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
                <div class="menu-item" >
                    <a href="actividades_tutor.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item" id = "div_nav_home">
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
                    <a style="display: flex; padding-bottom: 0;" id="text-tit-act-sec-nav">Calendario</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <%                            session = request.getSession(false);

                        if (session != null && session.getAttribute("idKit") != null) {
                            String idKit = (String) session.getAttribute("idKit");
                            int idKitInt = Integer.parseInt(idKit);                           
                        try {
                        Base bd = new Base();
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
            <div class="top-div">
                <div class="nav-calendar">
                    <button class="btnHoy" id="btnHoy">
                        <p>Hoy</p>
                    </button>
                    <button class="btnNav" id="btn-previo" value="previo"><img src="../img/left-arrow.svg"/></button>
                    <button class="btnNav" id="btn-siguiente" value="siguiente"><img src="../img/right-arrow.svg"></button>
                    <p id="rango-fecha">Mes, días, año</p>
                    <button class="semanaVista">
                        <img src="../img/view-semana.svg"/>
                        <p><a href="calendario_semanal_tutor.jsp" style="text-decoration: none; color: black">Semanal</a></p>
                    </button>
                </div>

                <div id="fechas" class="div-fechas">
                    <div class="dia"><p data-dia="Dom">Dom</p></div>
                    <div class="dia"><p data-dia="Lun">Lun</p></div>
                    <div class="dia"><p data-dia="Mar">Mar</p></div>
                    <div class="dia"><p data-dia="Mié">Mié</p></div>
                    <div class="dia"><p data-dia="Jue">Jue</p></div>
                    <div class="dia"><p data-dia="Vie">Vie</p></div>
                    <div class="dia"><p data-dia="Sáb">Sáb</p></div>
                    <div id="fechas-cont"></div>
                </div>

            </div>

            <div class="actividades-div">
                <div class="act_tit2">
                    <h3>Actividades</h3>
                </div>
                <div class="act_cont" id="actCont">
                    <%
                        session = request.getSession(false);
                        if (session != null && session.getAttribute("email") != null) {
                            String email = (String) session.getAttribute("email");
                            Base bd = new Base();
                            bd.conectar();
                            String idKit = request.getParameter("idKit");
                            if (idKit != null && !idKit.isEmpty()) {
                                session.setAttribute("idKit", idKit); // Guardar el idKit en la sesión
                            } else {
                                idKit = (String) session.getAttribute("idKit"); // Usar el idKit de la sesión si no se pasó uno nuevo
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
                        String fechaConsulta = request.getParameter("fechaConsulta");
                        //String fechaGuardada = request.getParameter("fechaGuardada");
                        if (fechaConsulta == null){
                    %>
                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado">
                        <div  id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">Seleccionar una fecha para ver las actividades del día</p>
                        </div>
                    </div>
                    <%
                    } 
                    if (fechaConsulta != null) {
                    %>
                    <div class="lista-act" id="listaAct">
                        <script>
                            const actividades = {};
                        </script>
                        <%                            

                            
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                java.util.Date parsedDate = sdf.parse(fechaConsulta);
                                java.sql.Date fechaSeleccionada = new java.sql.Date(parsedDate.getTime());
                                
                                String query = "SELECT * FROM actividad WHERE idKit = ? ORDER BY horaInicioHabito ASC";

                                PreparedStatement pstmt3 = null;
                                ResultSet rs2 = null;

                                try {
                                    pstmt3 = bd.getConn().prepareStatement(query);

                                    pstmt3.setString(1, idKit);

                                    rs2 = pstmt3.executeQuery();

                                    boolean actividadEncontrada = false;

                                    while (rs2.next()) {

                                        String idActividadO = rs2.getString("idActividad");
                                        String nombreHabitoO = rs2.getString("nombreHabito");
                                        String rutaImagenHabitoO = rs2.getString("rutaImagenHabito");
                                        String numRamitasO = rs2.getString("numRamitas");
                                        String infoExtraHabitoO = rs2.getString("infoExtraHabito");
                                        String horaInicioHabitoO = rs2.getString("horaInicioHabito");
                                        String horaFinHabitoO = rs2.getString("horaFinHabito");
                        %>
                        <script>
                            actividades['<%= idActividadO%>'] = {
                                nombre: '<%= nombreHabitoO%>',
                                imagen: '<%= rutaImagenHabitoO%>',
                                ramitas: '<%= numRamitasO%>',
                                infoExtra: '<%= infoExtraHabitoO%>',
                                horaInicio: '<%= horaInicioHabitoO%>',
                                horaFin: '<%= horaFinHabitoO%>'
                            };
                        </script>
                        <%

                            Date diaInicioHabitoF = rs2.getDate("diaInicioHabito");
                            Date diaMetaHabitoF = rs2.getDate("diaMetaHabito");
                            String repeticionesS = rs2.getString("repeticiones");
                            if ((fechaSeleccionada.equals(diaInicioHabitoF) || fechaSeleccionada.after(diaInicioHabitoF)) && 
        (fechaSeleccionada.equals(diaMetaHabitoF) || fechaSeleccionada.before(diaMetaHabitoF))) {
//Intervalos
                            if (repeticionesS.startsWith("Repetir cada")) {
                                int intervalo = Integer.parseInt(repeticionesS.split(" ")[2]);
                                   
                                List<Date> fechasList = new ArrayList<>(); //listita para guardar fechas donde cae
                                Calendar calendar = Calendar.getInstance();

                                if (diaInicioHabitoF != null && diaMetaHabitoF != null) {
                                    calendar.setTime(diaInicioHabitoF);

                                    while (calendar.getTime().before(diaMetaHabitoF) || calendar.getTime().equals(diaMetaHabitoF)) {

                                        fechasList.add(calendar.getTime());//agrega la fecha a la lista

                                        calendar.add(Calendar.DAY_OF_MONTH, intervalo); //aumenta la fecha en el intervalo
                                    }

                                    for (Date fecha : fechasList) {
                                        if (fecha.equals(fechaSeleccionada)) {
                                            actividadEncontrada = true;
                        %>
                        <div class="contenedor-cada-actividad">
                            <div class="actividad-desplegada-icono">
                                <img src="<%= rutaImagenHabitoO%>" class="imgIconoActividad">
                            </div>
                            <div class="actividad-despleada-nombre-ramitas">
                                <div class="actividad-despleada-nombre">
                                    <span class="text-nombre-habit-desplegado">
                                        <%= nombreHabitoO%>
                                    </span>
                                </div>
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                    </div>
                                    <div>
                                        <label id="text-num-ramitas-despl-acti"><%= numRamitasO%> Ramitas</label>
                                    </div>
                                </div>
                            </div>
                            <div class="actividad-desplegada-horario">
                                <div class="div-botoncito-actividad-desplegada">

                                    <button type="button" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="mostrarInfo('<%= idActividadO%>')">Ir</button>

                                </div>
                            </div>
                        </div>
                        <%
                                        break;
                                    }
                                }
                            }
//Días de la semana
                        } else if (repeticionesS.contains("Lunes") || repeticionesS.contains("Martes") || repeticionesS.contains("Miércoles") || repeticionesS.contains("Jueves") || repeticionesS.contains("Viernes") || repeticionesS.contains("Sábado") || repeticionesS.contains("Domingo")) {
                            String[] dias = repeticionesS.split(",");
                            String diaNombre = new SimpleDateFormat("EEEE").format(fechaSeleccionada); // Obtener el nombre del día
                            for (String dia : dias) {
                                if (dia.trim().equalsIgnoreCase(diaNombre)) {
                                    actividadEncontrada = true;
                        %>
                        <div class="contenedor-cada-actividad">
                            <div class="actividad-desplegada-icono">
                                <img src="<%= rutaImagenHabitoO%>" class="imgIconoActividad">
                            </div>
                            <div class="actividad-despleada-nombre-ramitas">
                                <div class="actividad-despleada-nombre">
                                    <span class="text-nombre-habit-desplegado">
                                        <%= nombreHabitoO%>
                                    </span>
                                </div>
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                    </div>
                                    <div>
                                        <label id="text-num-ramitas-despl-acti"><%= numRamitasO%> Ramitas</label>
                                    </div>
                                </div>
                            </div>
                            <div class="actividad-desplegada-horario">
                                <div class="div-botoncito-actividad-desplegada">

                                    <button type="button" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="mostrarInfo('<%= idActividadO%>')">Ir</button>

                                </div>
                            </div>
                        </div>
                        <%
                                    break;
                                }
                            }
//Días de meses 
                        } else if (repeticionesS.startsWith("Cada mes el día")) {
                            String[] reps = repeticionesS.split(", ");
                            List<Integer> diasMes = new ArrayList<>();

                            for (String rep : reps) {
                                String[] repsMes = rep.trim().split(" ");
                                int diaMes = Integer.parseInt(repsMes[4]);
                                diasMes.add(diaMes);
                            }

                            Calendar calendar = Calendar.getInstance();
                            calendar.setTime(fechaSeleccionada);
                            int diaSeleccionado = calendar.get(Calendar.DAY_OF_MONTH);

                            for (Integer dia : diasMes) {
                                if (dia == diaSeleccionado) {
                                    actividadEncontrada = true;
                        %>

                        <div class="contenedor-cada-actividad">
                            <div class="actividad-desplegada-icono">
                                <img src="<%= rutaImagenHabitoO%>" class="imgIconoActividad">
                            </div>
                            <div class="actividad-despleada-nombre-ramitas">
                                <div class="actividad-despleada-nombre">
                                    <span class="text-nombre-habit-desplegado">
                                        <%= nombreHabitoO%>
                                    </span>
                                </div>
                                <div class="actividad-despleada-ramitas">
                                    <div class="cont-img-icono-ramita-num-ramitas">
                                        <img src="../img/icono_ramita.svg" class="imgRamitaRecompensa-desplegar-actividad">
                                    </div>
                                    <div>
                                        <label id="text-num-ramitas-despl-acti"><%= numRamitasO%> Ramitas</label>
                                    </div>
                                </div>
                            </div>
                            <div class="actividad-desplegada-horario">
                                <div class="div-botoncito-actividad-desplegada">

                                    <button type="button" class="button-ver-detalles-desplegue-actividad" id="button-ver-detalles-desplegue-actividad" onclick="mostrarInfo('<%= idActividadO%>')">Ir</button>

                                </div>
                            </div>

                        </div>
                        <%
                                            break;
                                        }
                                    }

                                }
                            }
}
                            if (!actividadEncontrada) {
                        %>
                        <div class="mensaje-no-actividades">
                            <p>No hay actividades en este día.</p>
                        </div>
                        <%
                            }%>


                    </div>
                    <div class="info-act" id="infoAct">
                        <div id="info-seleccionada" class="info-actContent">
                            <p>Selecciona una actividad</p>
                            <img src="../img/Castor.svg" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                    </div>
                    <div id="infoModal" class="modalInfo">
                        <div class="modal-info-content">
                            <span class="close-btn" id="cerrarModal">&times;</span>
                            <div id="info-actContent">
                                
                            </div>
                        </div>
                    </div>
                    <%                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs2 != null) try {
                                            rs2.close();
                                        } catch (SQLException e) {
                                        }
                                        if (pstmt3 != null) try {
                                            pstmt3.close();
                                        } catch (SQLException e) {
                                        }
                                    }
                                }
                            }
                        }
                    %>
                </div>
                </div>
                </div>
                <!--<div class = "contenedor-contenido-abajo">  -->
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
                                <form action="procesa_tutor_calendario.jsp" method="post" style="display: inline;" id="pruebapaber">
                                    <input type="text" id="idKit" name="idKit" style="display: none;" value="<%= rsp.getString(1)%>">
                                    <button type="submit" style="background: none; border: none; padding: 0; cursor: pointer; height: auto; height: auto; display: flex; align-content: center; align-items: center; position: relative; z-index: 7000;">
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
                            <form action="procesa_tutor_calendario.jsp" method="post" style="display: inline;" id="pruebapaber2">
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



                <!--</div>-->
            
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
        

        <div id="modalCrearActividad" class="modal-crear-actividad">
            <div class="modal-content-crear-actividad">
                <form action="formulario_procesa_tutor_calendario.jsp" method="post" id="formulario-nuevo-habito" style="width: auto; height: 100%;">
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
            <span  class="toastMessage">Error: No puede mandar el fomulario sin seleccionar un ícono y un color.</span>
        </div>
        <%
            session.removeAttribute("error"); // Limpia el mensaje después de mostrarlo
        %>

        <div id="toast-validar-informacion-formulario" class="toast" style="display: <% if (toastMessage != null && toastMessage.equals("Ya hay una actividad programada en ese lapso de tiempo.")) { %>block; <% } else { %>none;<% }%>">
            <span class="toastMessage"><%= toastMessage != null ? toastMessage : ""%></span>
        </div>

        <script>
            function showToastErrorHorasAct() {
                const toast = document.getElementById('toast-validar-informacion-formulario');
                if (toast.style.display === "block") {
                    // Se asegura de que el toast esté visible
                    setTimeout(() => {
                        toast.style.display = "none"; // Oculta el toast después de 7 segundos
                    }, 7000);
                }
            }

            // Llama a la función si el toast está visible
            <% if (toastMessage != null && toastMessage.equals("Ya hay una actividad programada en ese lapso de tiempo.")) { %>
            showToastErrorHorasAct(); // Llama a la función para mostrar el toast
            <% }%>
        </script>
        <script src="../codigo_js/codigo_javascript_tutor/js_calendario_tutor.js" type="text/javascript"></script>
    </body>
</html>