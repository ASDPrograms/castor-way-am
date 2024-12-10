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
        <link href="../estilos_css/estilos_hijo/css_calendario_hijo.css" rel="stylesheet" type="text/css"/>
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
                    <a href="home_hijo.jsp" class = "a_nav"> 
                        <img class="icon icon1" src="../img/icono_casita.svg">
                        <span class="textNav">Inicio</span>
                    </a>
                </div>
                <div class="menu-item" >
                    <a href="actividades_hijo.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item" id = "div_nav_home">
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
                    <a style="display: flex; padding-bottom: 0;" id="text-tit-act-sec-nav">Calendario</a>
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
                        <p><a href="calendario_semanal_hijo.jsp" style="text-decoration: none; color: black">Semanal</a></p>
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
                        if (session != null && session.getAttribute("usuario") != null) {
                            
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

                                    pstmt3.setInt(1, idKit);

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
                
        </script>
        <script src="../codigo_js/codigo_javascript_hijo/js_calendario_hijo.js" type="text/javascript"></script>
    </body>
</html>