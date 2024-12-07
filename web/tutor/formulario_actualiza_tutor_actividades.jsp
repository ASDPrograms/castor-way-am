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
            session = request.getSession(true);
            String email = (String) session.getAttribute("email");

            //Recuperar info del formu
            String idKitString = (String) session.getAttribute("idKit");
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
            String idActividad = request.getParameter("idActividadEditarActividad");

            int idKit = Integer.parseInt(idKitString);

            //validación para no tener contenido vacío del formu
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
            if (idActividad == null) {
                valid = false;
            }

            boolean validFechas = true;
            Base bd = new Base();
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            if (valid == false) {
                session.setAttribute("error", "Favor de verificar que todos los campos estén llenos y bien válidados.");
                response.sendRedirect("actividades_tutor.jsp");
            }
            try {
                bd.conectar();
                conn = bd.getConn();
                String sql = "SELECT COUNT(*) AS count FROM Actividad WHERE "
                        + "((diaInicioHabito BETWEEN ? AND ?) OR (diaMetaHabito BETWEEN ? AND ?) OR "
                        + "(diaInicioHabito <= ? AND diaMetaHabito >= ?)) AND "
                        + "((horaInicioHabito <= ? AND horaFinHabito >= ?) OR (horaInicioHabito <= ? AND horaFinHabito >= ?)) AND "
                        + "idKit = ? AND idActividad <> ?"; // Excluir la actividad actual

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
                stmt.setInt(12, Integer.parseInt(idActividad)); // Excluir la actividad que se quiere actualizar


                rs = stmt.executeQuery();

                if (rs.next()) {
                    int count = rs.getInt("count");
                    if (count > 0) {
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
                        session.setAttribute("error", "Ya hay una actividad programada en ese lapso de tiempo.");
                        response.sendRedirect("actividades_tutor.jsp");
                    } else {
                        if (idActividad != null && !idActividad.trim().isEmpty()) {
                            // Actualización de actividad existente
                            String updateSql = "UPDATE Actividad SET nombreHabito = ?, tipoHabito = ?, numRamitas = ?, repeticiones = ?, "
                                    + "diaInicioHabito = ?, diaMetaHabito = ?, horaInicioHabito = ?, horaFinHabito = ?, "
                                    + "color = ?, rutaImagenHabito = ?, infoExtraHabito = ? WHERE idActividad = ? AND idKit = ?";
                            try {
                                stmt = conn.prepareStatement(updateSql);
                                stmt.setString(1, nombreHabito);
                                stmt.setString(2, tipoHabito);
                                stmt.setString(3, numRamitas);
                                stmt.setString(4, repeticiones);
                                stmt.setString(5, diaInicioHabito);
                                stmt.setString(6, diaMetaHabito);
                                stmt.setString(7, horaInicioHabito);
                                stmt.setString(8, horaFinHabito);
                                stmt.setString(9, color);
                                stmt.setString(10, rutaImagenHabito);
                                stmt.setString(11, infoExtraHabito);
                                stmt.setInt(12, Integer.parseInt(idActividad));
                                stmt.setInt(13, idKit);

                                int rowsUpdated = stmt.executeUpdate();
                                if (rowsUpdated > 0) {
                                    out.println("Actividad actualizada exitosamente.");
                                    response.sendRedirect("actividades_tutor.jsp");
                                } else {
                                    out.println("Error al actualizar la actividad.");
                                }

                                int rowsAffected = stmt.executeUpdate();

                                if (rowsAffected > 0) {
                                    out.println("Actividad insertada exitosamente.");
                                    response.sendRedirect("actividades_tutor.jsp");
                                } else {
                                    out.println("Error al insertar la actividad.");
                                }
                            } catch (SQLException ex) {
                                out.println("Error al insertar en la base de datos: " + ex.getMessage());
                                ex.printStackTrace();
                            }
                        }
                    }
                }
            } catch (java.sql.SQLException ex) {
                out.println("Error al insertar en la base de datoss: " + ex.getMessage());
                ex.printStackTrace();
            } catch (Exception ex) {
                out.println("Error general: " + ex.getMessage());
                ex.printStackTrace();
            } finally {
                try {
                    bd.cierraConexion();
                } catch (Exception ex) {
                    out.println("Error al cerrar la conexión: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }

        %>
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
