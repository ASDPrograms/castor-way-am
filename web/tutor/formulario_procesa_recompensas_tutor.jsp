<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" session="true">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session = request.getSession(true);
            String email = (String) session.getAttribute("email");

            String nombrePremio = request.getParameter("nombreHabito");
            String rutaImagenHabito = request.getParameter("iconSrc");
            String nivelPremio = request.getParameter("opcionesNivel");
            String categoriaPremio = request.getParameter("opcionesCategoria");
            String tipoPremio = request.getParameter("opcionesTipo");
            int costoPremio = Integer.parseInt(request.getParameter("recompensaActividad"));
            String infoExtraPremio = request.getParameter("infoExtra");
            int idCastor = (int) session.getAttribute("idCastor");
            int idKit = Integer.parseInt((String) session.getAttribute("idKit"));
            String refererPage = request.getHeader("Referer");
            // Validación de campos
            boolean valid = true;
            if (nombrePremio == null || nivelPremio == null || categoriaPremio == null || tipoPremio == null
                    || infoExtraPremio == null || rutaImagenHabito == null) {
                valid = false;
            }

            if (!valid) {
                session.setAttribute("error", "Favor de verificar que todos los campos estén llenos y bien válidados.");
                response.sendRedirect(refererPage);
                return;
            }

            Base bd = new Base();
            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                bd.conectar();
                conn = bd.getConn();

                // Verificar si ya existe un premio con los mismos datos para el mismo idKit
                String checkPremioSql = "SELECT COUNT(*) FROM relPrem rp " +
                                        "JOIN premios p ON rp.idPremio = p.idPremio " +
                                        "WHERE rp.idKit = ? AND p.nombrePremio = ? " +
                                        "AND p.nivelPremio = ? AND p.categoriaPremio = ? " +
                                        "AND p.tipoPremio = ? AND p.costoPremio = ? " +
                                        "AND p.infoExtraPremio = ?" +
                                        "AND p.rutaImagenHabito = ?";
                stmt = conn.prepareStatement(checkPremioSql);
                stmt.setInt(1, idKit);
                stmt.setString(2, nombrePremio);
                stmt.setString(3, nivelPremio);
                stmt.setString(4, categoriaPremio);
                stmt.setString(5, tipoPremio);
                stmt.setInt(6, costoPremio);
                stmt.setString(7, infoExtraPremio);
                stmt.setString(8, rutaImagenHabito);
          

                ResultSet rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    // Si ya existe un premio, establecer un mensaje de error
                    session.setAttribute("error", "Ya existe un premio con esos datos para el idKit seleccionado.");
                    response.sendRedirect(refererPage); // Redirige a la página de recompensas
                    return; // Salir del proceso
                }

                // Inserción en la tabla premios
                String insertPremioSql = "INSERT INTO premios (idCastor, nombrePremio, nivelPremio, categoriaPremio, tipoPremio, costoPremio, infoExtraPremio, rutaImagenHabito) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertPremioSql, Statement.RETURN_GENERATED_KEYS);
                stmt.setInt(1, idCastor);
                stmt.setString(2, nombrePremio);
                stmt.setString(3, nivelPremio);
                stmt.setString(4, categoriaPremio);
                stmt.setString(5, tipoPremio);
                stmt.setInt(6, costoPremio);
                stmt.setString(7, infoExtraPremio);
                stmt.setString(8, rutaImagenHabito);

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int idPremio = generatedKeys.getInt(1);

                        // Inserción en la tabla relPrem incluyendo idPremio
                        String insertRelPremSql = "INSERT INTO relPrem (idKit, idCastor, idPremio) VALUES (?, ?, ?)";
                        stmt = conn.prepareStatement(insertRelPremSql);
                        stmt.setInt(1, idKit);
                        stmt.setInt(2, idCastor);
                        stmt.setInt(3, idPremio); // Aquí se incluye el idPremio

                        stmt.executeUpdate();

                        out.println("Premio insertado y relación creada exitosamente.");
                        response.sendRedirect(refererPage);// Redirige a la página de premios
                    }
                } else {
                    out.println("Error al insertar el premio.");
                }
            } catch (SQLException ex) {
                out.println("Error al insertar en la base de datos: " + ex.getMessage());
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
            <%=nombrePremio%>
        </p>
        <p>
            <%=rutaImagenHabito%>
        </p>
        <p>
            <%=nivelPremio%>
        </p>
        <p>
            <%=categoriaPremio%>
        </p>
        <p>
            <%=tipoPremio%>
        </p>
        <p>
            <%=costoPremio%>
        </p>
        <p>
            <%=infoExtraPremio%>
        </p>
        <p>
            <%=idCastor%>
        </p>
        <p>
            <%=idKit%>
        </p>
    </body>
</html>