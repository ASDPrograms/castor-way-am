<%@page import="java.time.format.DateTimeParseException"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String fechasComoTexto = "";
            String nombreActiviSobrePone = "";
            
            session = request.getSession(true);
            String email = (String) session.getAttribute("email");

            String idKitString = (String) session.getAttribute("idKit");
            int idCastor = (int) session.getAttribute("idCastor");

            String nombreHabito = request.getParameter("nombreHabito");
            String tipoHabito = request.getParameter("opciones");
            String numRamitas = request.getParameter("recompensaActividad");
            String repeticiones = request.getParameter("repeticiones");
            String diaInicioHabito = request.getParameter("calendarioInicial");
            String diaMetaHabito = request.getParameter("calendarioFinal");
            String horaInicioHabito = request.getParameter("horaInicio");
            String horaFinHabito = request.getParameter("horaFinal");
            String color = request.getParameter("selectedColor");
            String rutaImagenHabito = request.getParameter("iconSrc");
            String infoExtraHabito = request.getParameter("infoExtra");

            int idKit = Integer.parseInt(idKitString);

            boolean valid = true;
            String errorMsj = "";
            if (nombreHabito == null) {
                valid = false;
            }
            if (tipoHabito == null) {
                valid = false;
            }
            if (numRamitas == null) {
                valid = false;
            }
            if (repeticiones == null) {
                valid = false;
            }
            if (diaInicioHabito == null) {
                valid = false;
            }
            if (diaMetaHabito == null) {
                valid = false;
            }
            if (horaInicioHabito == null) {
                valid = false;
            }
            if (horaFinHabito == null) {
                valid = false;
            }
            if (color == null) {
                valid = false;
            }
            if (rutaImagenHabito == null) {
                valid = false;
            }
            if (infoExtraHabito == null) {
                valid = false;
            }
            if (valid == false) {
                session.setAttribute("error", "Favor de verificar que todos los campos estén llenos y bien válidados.");
                response.sendRedirect("actividades_tutor.jsp");
            }

            Base bd = new Base();
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            List<LocalDate> fechasActividad = new ArrayList<>();

            if (repeticiones.contains("Lunes")
                    || repeticiones.contains("Martes")
                    || repeticiones.contains("Miércoles")
                    || repeticiones.contains("Jueves")
                    || repeticiones.contains("Viernes")
                    || repeticiones.contains("Sábado")
                    || repeticiones.contains("Domingo")) {

                String[] diasSeleccionados = repeticiones.split(",");

                LocalDate fechaInicio = LocalDate.parse(diaInicioHabito);
                LocalDate fechaFin = LocalDate.parse(diaMetaHabito);

                while (!fechaInicio.isAfter(fechaFin)) {
                    String diaDeLaSemana = fechaInicio.getDayOfWeek().toString();
                    for (String dia : diasSeleccionados) {
                        dia = dia.trim();

                        if (dia.equals("Lunes") && diaDeLaSemana.equals("MONDAY")
                                || dia.equals("Martes") && diaDeLaSemana.equals("TUESDAY")
                                || dia.equals("Miércoles") && diaDeLaSemana.equals("WEDNESDAY")
                                || dia.equals("Jueves") && diaDeLaSemana.equals("THURSDAY")
                                || dia.equals("Viernes") && diaDeLaSemana.equals("FRIDAY")
                                || dia.equals("Sábado") && diaDeLaSemana.equals("SATURDAY")
                                || dia.equals("Domingo") && diaDeLaSemana.equals("SUNDAY")) {
                            fechasActividad.add(fechaInicio);
                        }
                    }
                    fechaInicio = fechaInicio.plusDays(1);
                }

            } else if (repeticiones.contains("Cada mes el día")) {
                String[] diasSeleccionados = repeticiones.replace("Cada mes el día", "").split(",");

                List<Integer> diasDelMesSeleccionados = new ArrayList<>();

                for (String dia : diasSeleccionados) {
                    try {
                        diasDelMesSeleccionados.add(Integer.parseInt(dia.trim()));
                    } catch (NumberFormatException e) {
                        out.println("Error al convertir el día: " + dia);
                    }
                }

                LocalDate fechaInicio = LocalDate.parse(diaInicioHabito);
                LocalDate fechaFin = LocalDate.parse(diaMetaHabito);

                while (!fechaInicio.isAfter(fechaFin)) {
                    int diaDelMes = fechaInicio.getDayOfMonth();
                    if (diasDelMesSeleccionados.contains(diaDelMes)) {
                        fechasActividad.add(fechaInicio);
                    }
                    fechaInicio = fechaInicio.plusDays(1);
                }

            } else if (repeticiones.contains("Repetir cada")) {
                String[] partesRepeticiones = repeticiones.split(" ");
                int diasIntervalo = Integer.parseInt(partesRepeticiones[2]);

                LocalDate fechaInicio = LocalDate.parse(diaInicioHabito);
                LocalDate fechaFin = LocalDate.parse(diaMetaHabito);

                while (!fechaInicio.isAfter(fechaFin)) {
                    fechasActividad.add(fechaInicio);
                    fechaInicio = fechaInicio.plusDays(diasIntervalo);
                }
            }

            try {
                bd.conectar();
                conn = bd.getConn();
                String sqlVerifiActi = "select * from actividad where idKit = ?";
                stmt = conn.prepareStatement(sqlVerifiActi);
                stmt.setInt(1, idKit);
                out.println("idkit: " + idKit + "<br>");

                /*
                
                String sql = "SELECT COUNT(*) AS count FROM Actividad WHERE "
                        + "((diaInicioHabito BETWEEN ? AND ?) OR (diaMetaHabito BETWEEN ? AND ?) OR "
                        + "(diaInicioHabito <= ? AND diaMetaHabito >= ?)) AND "
                        + "((horaInicioHabito <= ? AND horaFinHabito >= ?) OR (horaInicioHabito <= ? AND horaFinHabito >= ?)) AND "
                        + "idKit = ?";

                stmt = conn.prepareStatement(sql);
                stmt.setString(1, diaInicioHabito);
                stmt.setString(2, diaMetaHabito);
                stmt.setString(3, diaInicioHabito);
                stmt.setString(4, diaMetaHabito);
                stmt.setString(5, diaInicioHabito);
                stmt.setString(6, diaMetaHabito);
                stmt.setString(7, horaFinHabito);
                stmt.setString(8, horaInicioHabito);
                stmt.setString(9, horaFinHabito);
                stmt.setString(10, horaInicioHabito);
                stmt.setInt(11, idKit);

                 */
                rs = stmt.executeQuery();
                String nombreActi = "";
                boolean haySuperposicion = false;
                while (rs.next()) {
                    LocalDate fechaBD = null;

                    String fecha = rs.getString("fechasActividad");
                    String[] fechasArray = fecha.split(",");
                    String horaI = rs.getString("horaInicioHabito");
                    String horaF = rs.getString("horaFinHabito");
                    out.println("fecha: " + fecha);

                    for (String fechaStr : fechasArray) {
                        fechaStr = fechaStr.trim();
                        try {
                            fechaBD = LocalDate.parse(fechaStr);
                            out.println("");
                        } catch (DateTimeParseException e) {
                            out.println("Error en parsear: " + e.getMessage());
                        }

                        for (LocalDate fechaNueva : fechasActividad) {
                            if (fechaNueva.equals(fechaBD)) {
                                if (horaI != null && horaF != null && horaInicioHabito != null && horaFinHabito != null) {
                                    try {
                                        LocalTime horaInicioBD = LocalTime.parse(horaI);
                                        LocalTime horaFinBD = LocalTime.parse(horaF);
                                        LocalTime horaInicioNueva = LocalTime.parse(horaInicioHabito);
                                        LocalTime horaFinNueva = LocalTime.parse(horaFinHabito);

                                        if ((horaInicioNueva.isBefore(horaFinBD) && horaFinNueva.isAfter(horaInicioBD))) {
                                            haySuperposicion = true;
                                            nombreActiviSobrePone = rs.getString("nombreHabito");
                                            out.print("Superposición detectada");
                                            nombreActi = rs.getString("nombreHabito");
                                            break;
                                        } else if (horaInicioNueva.equals(horaFinBD) || horaFinNueva.equals(horaInicioBD)) {
                                            haySuperposicion = true;
                                            out.print("Superposición por coincidencia exacta de horas");
                                            nombreActiviSobrePone = rs.getString("nombreHabito");
                                            nombreActi = rs.getString("nombreHabito");
                                            break;
                                        }

                                    } catch (DateTimeParseException e) {
                                        out.println("Error al parsear las horas: " + e.getMessage());
                                    }

                                }
                            }
                        }
                    }

                }

                StringBuilder fechasConcatenadas = new StringBuilder();

                if (fechasActividad != null && !fechasActividad.isEmpty()) {
                    for (int i = 0; i < fechasActividad.size(); i++) {
                        try {
                            LocalDate fecha = fechasActividad.get(i);
                            fechasConcatenadas.append(fecha);
                            if (i < fechasActividad.size() - 1) {
                                fechasConcatenadas.append(", ");
                            }
                        } catch (Exception e) {
                            out.println("Error al formatear la fecha: " + e.getMessage());
                        }
                    }
                } else {
                    fechasConcatenadas.append("No hay fechas disponibles.");
                }

                fechasComoTexto = fechasConcatenadas.toString();

                if (haySuperposicion) {
                    out.println("Ya existe una actividad en el rango de tiempo seleccionado.");
                    session.setAttribute("nombreHabito", nombreHabito);
                    session.setAttribute("tipoHabito", tipoHabito);
                    session.setAttribute("numRamitas", numRamitas);
                    session.setAttribute("repeticiones", repeticiones);
                    session.setAttribute("diaInicioHabito", diaInicioHabito);
                    session.setAttribute("diaMetaHabito", diaMetaHabito);
                    session.setAttribute("horaInicioHabito", horaInicioHabito);
                    session.setAttribute("horaFinHabito", horaFinHabito);
                    session.setAttribute("color", color);
                    session.setAttribute("rutaImagenHabito", rutaImagenHabito);
                    session.setAttribute("infoExtraHabito", infoExtraHabito);
                    session.setAttribute("msjProcesaActividiadForm", "Ya hay una actividad programada que se sobrepone al lapso de tiempo elegido." + "<br>" + "Nombre del hábito que se sobrepone: " + nombreActiviSobrePone);
                    response.sendRedirect("actividades_tutor.jsp");
                } else {
                    String insertSql = "INSERT INTO Actividad (idKit, idCastor, nombreHabito, tipoHabito, numRamitas, repeticiones, "
                            + "diaInicioHabito, diaMetaHabito, horaInicioHabito, horaFinHabito, color, rutaImagenHabito, "
                            + "infoExtraHabito, fechasActividad) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    try {
                        stmt = conn.prepareStatement(insertSql);
                        stmt.setInt(1, idKit);
                        stmt.setInt(2, idCastor);
                        stmt.setString(3, nombreHabito);
                        stmt.setString(4, tipoHabito);
                        stmt.setString(5, numRamitas);
                        stmt.setString(6, repeticiones);
                        stmt.setString(7, diaInicioHabito);
                        stmt.setString(8, diaMetaHabito);
                        stmt.setString(9, horaInicioHabito);
                        stmt.setString(10, horaFinHabito);
                        stmt.setString(11, color);
                        stmt.setString(12, rutaImagenHabito);
                        stmt.setString(13, infoExtraHabito);
                        stmt.setString(14, fechasComoTexto);

                        int rowsAffected = stmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("Actividad insertada exitosamente.");
                            session.setAttribute("msjProcesaActividiadForm", "Actividad agregada exitosamente");
                            response.sendRedirect("actividades_tutor.jsp");
                        } else {
                            out.println("Error al insertar la actividad.");
                        }
                    } catch (SQLException ex) {
                        out.println("Error al insertar en la base de datos: " + ex.getMessage());
                        ex.printStackTrace();
                    }
                }

            } catch (java.sql.SQLException ex) {
                out.println("Error al insertar en la base de datoss: " + ex.getMessage());
                ex.printStackTrace();
            } catch (Exception ex) {
                out.println("Error: " + fechasComoTexto);
                out.print("<br>");
                out.println("Error general: " + ex.getMessage());
                ex.printStackTrace();
            } finally {
                try {

                    bd.cierraConexion();
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error cerrando recursos: " + ex.getMessage());
                }
            }

        %>
        <p>
            <%= idKit%>
        </p>
        <p>
            <%= idCastor%>
        </p>
        <p>
            <%= nombreHabito%>
        </p>
        <p>
            <%= tipoHabito%>
        </p>
        <p>
            <%= numRamitas%>
        </p>
        <p>
            <%= repeticiones%>
        </p>
        <p>
            <%= diaInicioHabito%>
        </p>
        <p>
            <%= diaMetaHabito%>
        </p>
        <p>
            <%= horaInicioHabito%>
        </p>
        <p>
            <%= horaFinHabito%>
        </p>
        <p>
            <%= color%>
        </p>
        <p>
            <%= rutaImagenHabito%>
        </p>
        <p>
            <%= infoExtraHabito%>
        </p>
    </body>
</html>
