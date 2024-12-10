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
        <link href="../estilos_css/estilos_hijo/css_calendario_semanal_hijo.css" rel="stylesheet" type="text/css"/>
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
                    <%                            session = request.getSession(false);

                        if (session != null && session.getAttribute("idKit") != null) {
                            String idKitInt = (String) session.getAttribute("idKit");
                            
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
                        <img src="../img/view-agenda.svg"/>
                        <p><a href="calendario_hijo.jsp" style="text-decoration: none; color: black">Agenda</a></p>
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

                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado" style="margin:auto">
                        <div  id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">Seleccionar primero una cuenta de Kit para poder acceder a la información de esa cuenta.</p>
                        </div>

                    </div>
                    <%
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        String semanaConsulta = request.getParameter("semanaConsulta");

//semanaConsulta = "2024-12-01";
                        //String fechaGuardada = request.getParameter("fechaGuardada");
                    %>

                    <div class="horas-col">
                        <div>00:00</div>
                        <div>01:00</div>
                        <div>02:00</div>
                        <div>03:00</div>
                        <div>04:00</div>
                        <div>05:00</div>
                        <div>06:00</div>
                        <div>07:00</div>
                        <div>08:00</div>
                        <div>09:00</div>
                        <div>10:00</div>
                        <div>11:00</div>
                        <div>12:00</div>
                        <div>13:00</div>
                        <div>14:00</div>
                        <div>15:00</div>
                        <div>16:00</div>
                        <div>17:00</div>
                        <div>18:00</div>
                        <div>19:00</div>
                        <div>20:00</div>
                        <div>21:00</div>
                        <div>22:00</div>
                        <div>23:00</div>
                    </div>

                    <div class="calendario-act" id="listaAct">
                        <div class="dia-column" id="columna-domingo"></div>
                        <div class="dia-column" id="columna-lunes"></div>
                        <div class="dia-column" id="columna-martes"></div>
                        <div class="dia-column" id="columna-miércoles"></div>
                        <div class="dia-column" id="columna-jueves"></div>
                        <div class="dia-column" id="columna-viernes"></div>
                        <div class="dia-column" id="columna-sábado"></div>
                    </div>
                    <%                        if (semanaConsulta == null) {
                            Calendar fechaHoy = Calendar.getInstance();

                            fechaHoy.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

                            // Obtener el año, mes y día
                            int año = fechaHoy.get(Calendar.YEAR);
                            int mes = fechaHoy.get(Calendar.MONTH) + 1; // El mes comienza desde 0, así que sumamos 1
                            int dia = fechaHoy.get(Calendar.DAY_OF_MONTH);

                            // Formatear el mes y el día con ceros a la izquierda si es necesario
                            String mesFormateado = String.format("%02d", mes);
                            String diaFormateado = String.format("%02d", dia);

                            semanaConsulta = año + "-" + mesFormateado + "-" + diaFormateado;

                        }
                        if (semanaConsulta != null) {
                    %>
                    <script>
                        console.log("Imprimiendo la semanita de busqueda <%= semanaConsulta%>");
                        const actividades = {};
                        console.log("si hay fechita");
                    </script>
                    <%

                        java.util.Date parsedDate = sdf.parse(semanaConsulta);
                        java.sql.Date fechaSeleccionada = new java.sql.Date(parsedDate.getTime());

                        String query = "SELECT * FROM actividad WHERE idKit = ? ORDER BY horaInicioHabito ASC";
                        String diaNombre = "";
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
                                String colorAct = rs2.getString("color");

                                String[] horaInicioDivs = horaInicioHabitoO.split(":");

                                int horaInicio = Integer.parseInt(horaInicioDivs[0]);
                                int minutoInicio = Integer.parseInt(horaInicioDivs[1]);

                                String[] horaFinDivs = horaFinHabitoO.split(":");

                                int horaFin = Integer.parseInt(horaFinDivs[0]);
                                int minutoFin = Integer.parseInt(horaFinDivs[1]);

                                int duracionHabito = ((horaFin * 60) + minutoFin) - ((horaInicio * 60) + minutoInicio);
                                double posicionAct = (double)((horaInicio * 60) + minutoInicio) / 60 * 3.5;
                                if (duracionHabito < 0) {
                                    duracionHabito += 24 * 60;
                                }
                                double duracionHoras = (double) duracionHabito / 60;
                                double altura = (double) duracionHoras * 3.5;


                    %>
                    <script>
                        actividades['<%= idActividadO%>'] = {
                            nombre: '<%= nombreHabitoO%>',
                            imagen: '<%= rutaImagenHabitoO%>',
                            ramitas: '<%= numRamitasO%>',
                            infoExtra: '<%= infoExtraHabitoO%>',
                            horaInicio: '<%= horaInicioHabitoO%>',
                            horaFin: '<%= horaFinHabitoO%>',
                            color: '<%= colorAct%>',
                            altura: '<%= altura%>',
                            posicion: '<%= posicionAct%>',
                            colorActividad: '',
                            colorFondo: ''
                        };
                        
                        if(actividades['<%= idActividadO%>'].color === "verde"){
                            actividades['<%= idActividadO%>'].colorActividad = "#8ac926";
                            actividades['<%= idActividadO%>'].colorFondo = "#c1e589";
                        }else if(actividades['<%= idActividadO%>'].color === "rojo"){
                            actividades['<%= idActividadO%>'].colorActividad = "#ff595e";
                            actividades['<%= idActividadO%>'].colorFondo = "#ffa4a7";
                        }else if(actividades['<%= idActividadO%>'].color === "amarillo"){
                            actividades['<%= idActividadO%>'].colorActividad = "#ffca3a";
                            actividades['<%= idActividadO%>'].colorFondo = "#ffe18e";
                        }else if(actividades['<%= idActividadO%>'].color === "azul"){
                            actividades['<%= idActividadO%>'].colorActividad = "#1982c4";
                            actividades['<%= idActividadO%>'].colorFondo = "#95d2f9";
                        }else if(actividades['<%= idActividadO%>'].color === "morado"){
                            actividades['<%= idActividadO%>'].colorActividad = "#6a4c93";
                            actividades['<%= idActividadO%>'].colorFondo = "#c8a5f7";
                        }else{
                            actividades['<%= idActividadO%>'].colorActividad = "#484848";
                            actividades['<%= idActividadO%>'].colorFondo = "#dadada";
                        }
                    </script>
                    <%
                    
                        Date diaInicioHabitoF = rs2.getDate("diaInicioHabito");
                        Date diaMetaHabitoF = rs2.getDate("diaMetaHabito");
                        String repeticionesS = rs2.getString("repeticiones");

                        Calendar fechitasComp = Calendar.getInstance();

                        
                        fechitasComp.setTime(diaInicioHabitoF);

                        int numeroDia = fechitasComp.get(Calendar.DAY_OF_WEEK);
                        int diferencia = Calendar.SUNDAY - numeroDia;

                        if (diferencia > 0) {
                            diferencia -= 7;
                        }
                        fechitasComp.add(Calendar.DAY_OF_MONTH, diferencia);
                        Date diaInicioComp = fechitasComp.getTime();

                    
                        if ((fechaSeleccionada.equals(diaInicioComp) || fechaSeleccionada.after(diaInicioComp))
                                && (fechaSeleccionada.equals(diaMetaHabitoF) || fechaSeleccionada.before(diaMetaHabitoF))) {
//Intervalos
                        if (repeticionesS.startsWith("Repetir cada")) {
                    
                        Calendar calendarito = Calendar.getInstance();
                        calendarito.setTime(fechaSeleccionada);
                        int intervalo = Integer.parseInt(repeticionesS.split(" ")[2]);

                        List<Date> fechasList = new ArrayList<>(); //listita para guardar fechas donde cae
                        Calendar calendarS = Calendar.getInstance();

                        if (diaInicioHabitoF != null && diaMetaHabitoF != null) {
                            calendarS.setTime(diaInicioHabitoF);

                            while (calendarS.getTime().before(diaMetaHabitoF) || calendarS.getTime().equals(diaMetaHabitoF)) {

                                fechasList.add(calendarS.getTime());//agrega la fecha a la lista

                                calendarS.add(Calendar.DAY_OF_MONTH, intervalo); //aumenta la fecha en el intervalo
                            }
                            for (int i = 0; i < 7; i++) {
                                Date fechita = new java.sql.Date(calendarito.getTimeInMillis());

                                for (Date fecha : fechasList) {

                                    if (fecha.equals(fechita)) {
                                        actividadEncontrada = true;
                                        diaNombre = new SimpleDateFormat("EEEE").format(fecha).toLowerCase();

                    %>
                    <script>

                        (function () {
                            const columna = document.getElementById("columna-<%= diaNombre%>");
                            
                            if (columna) {
                                const actividadDiv = document.createElement('div');
                                actividadDiv.classList.add('contenedor-cada-actividad');
                                actividadDiv.style.height = actividades['<%= idActividadO%>'].altura + "em";
                                actividadDiv.style.top = actividades['<%= idActividadO%>'].posicion + "em";
                                actividadDiv.style.backgroundColor = actividades['<%= idActividadO%>'].colorFondo;
                                actividadDiv.innerHTML = `
                    <div class="actividad-despleada-nombre">
                        <p class="text-nombre-habit-desplegado textito-calendario-<%= idActividadO%>" id="textito-calendario">
                        <%= nombreHabitoO%>
                        </p>
                    </div>`;
                    
                                columna.appendChild(actividadDiv);
                    const elementos = document.querySelectorAll(".textito-calendario-<%= idActividadO%>");
                    elementos.forEach(function(elemento) {
                    if (actividades['<%= idActividadO%>'].altura < 3.5) {
                        elemento.style.webkitLineClamp = 1;
                    }
                });

                            }
                        })();
                    </script>
                    <%
                                        break;
                                    }
                                }
                                calendarito.add(Calendar.DAY_OF_MONTH, 1);
                            }
                        }

//Días de la semana
                    } else if (repeticionesS.contains("Lunes") || repeticionesS.contains("Martes") || repeticionesS.contains("Miércoles") || repeticionesS.contains("Jueves") || repeticionesS.contains("Viernes") || repeticionesS.contains("Sábado") || repeticionesS.contains("Domingo")) {
                    
                        Calendar calendarito2 = Calendar.getInstance();
                        calendarito2.setTime(fechaSeleccionada);
                        String[] dias = repeticionesS.split(",");
                        for (int i = 0; i < 7; i++) {
                            Date fechita = new java.sql.Date(calendarito2.getTimeInMillis());
                            String diaNombreS = new SimpleDateFormat("EEEE").format(fechita);

                            for (String dia : dias) {
                                if (dia.trim().toLowerCase().equalsIgnoreCase(diaNombreS)) {

                                    actividadEncontrada = true;

                    %>
                    <script>
                        (function () {
                            const columna = document.getElementById("columna-<%= diaNombreS%>");
                            if (columna) {
                                const actividadDiv = document.createElement('div');
                                actividadDiv.classList.add('contenedor-cada-actividad');
                                actividadDiv.style.height = actividades['<%= idActividadO%>'].altura + "em";
                                actividadDiv.style.top = actividades['<%= idActividadO%>'].posicion + "em";
                                actividadDiv.style.backgroundColor = actividades['<%= idActividadO%>'].colorFondo;
                                actividadDiv.innerHTML = `
                    <div class="actividad-despleada-nombre">
                        <p class="text-nombre-habit-desplegado textito-calendario-<%= idActividadO%>" id="textito-calendario">
                        <%= nombreHabitoO%>
                        </p>
                    </div>`;
                    
                                columna.appendChild(actividadDiv);
                    const elementos = document.querySelectorAll(".textito-calendario-<%= idActividadO%>");
                    elementos.forEach(function(elemento) {
                    if (actividades['<%= idActividadO%>'].altura < 3.5) {
                        elemento.style.webkitLineClamp = 1;
                    }
                });
                            }
                        })();
                    </script>
                    <%
                                    break;
                                }
                            }
                            calendarito2.add(Calendar.DAY_OF_MONTH, 1);
                        }
//Días de meses 
                    } else if (repeticionesS.startsWith("Cada mes el día")) {
                    
                        Calendar calendarito3 = Calendar.getInstance();
                        calendarito3.setTime(fechaSeleccionada);

                        String[] reps = repeticionesS.split(", ");
                        List<Integer> diasMes = new ArrayList<>();

                        for (String rep : reps) {
                            String[] repsMes = rep.trim().split(" ");
                            int diaMes = Integer.parseInt(repsMes[4]);
                            diasMes.add(diaMes);
                        }
                        
                        for (int i = 0; i < 7; i++) {
                            Date fechita = new java.sql.Date(calendarito3.getTimeInMillis());

                            int diaSeleccionado = calendarito3.get(Calendar.DAY_OF_MONTH);
                            
                            for (Integer dia : diasMes) {
                                if (dia == diaSeleccionado) {
                                    actividadEncontrada = true;
                                    String diaSemana = new SimpleDateFormat("EEEE").format(fechita);
                    %>

                    <script>
                        (function () {
                            const columna = document.getElementById("columna-<%= diaSemana%>");
                            if (columna) {
                                const actividadDiv = document.createElement('div');
                                actividadDiv.classList.add('contenedor-cada-actividad');
                                actividadDiv.style.height = actividades['<%= idActividadO%>'].altura + "em";
                                actividadDiv.style.top = actividades['<%= idActividadO%>'].posicion + "em";
                                actividadDiv.style.backgroundColor = actividades['<%= idActividadO%>'].colorFondo;
                                actividadDiv.innerHTML = `
                    <div class="actividad-despleada-nombre">
                        <p class="text-nombre-habit-desplegado textito-calendario-<%= idActividadO%>" id="textito-calendario">
                        <%= nombreHabitoO%>
                        </p>
                    </div>`;
                    
                                columna.appendChild(actividadDiv);
                    const elementos = document.querySelectorAll(".textito-calendario-<%= idActividadO%>");
                    elementos.forEach(function(elemento) {
                    if (actividades['<%= idActividadO%>'].altura < 3.5) {
                        elemento.style.webkitLineClamp = 1;
                    }
                });
                            }
                        })();
                    </script>
                    <%
                                                                break;
                                                            }
                                                        }
                                                        calendarito3.add(Calendar.DAY_OF_MONTH, 1);
                                                    }
                                                }
                                            }
                                        }

                                    } catch (Exception e) {
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
            
        <script src="../codigo_js/codigo_javascript_hijo/js_calendario_semanal_hijo.js" type="text/javascript"></script>
    </body>
</html>