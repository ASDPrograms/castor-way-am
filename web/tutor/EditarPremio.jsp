<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Premios</title>
</head>
<body>
<%
    session = request.getSession(true);

    // Recuperar idCastor de la sesión
    int idCastor = (int) session.getAttribute("idCastor");

    // Recuperar idKit de la sesión
    String idKitString = (String) session.getAttribute("idKit");

    // Recuperar datos del formulario
    String nombrePremio = request.getParameter("nombreHabito");
    String nivelPremio = request.getParameter("opcionesNivel");
    String categoriaPremio = request.getParameter("opcionesCategoria");
    String tipoPremio = request.getParameter("opcionesTipo");
    String costoPremio = request.getParameter("recompensaActividad");
    String infoExtraPremio = request.getParameter("infoExtra");
    String rutaImagenHabito = request.getParameter("iconSrc");
    String idPremio = request.getParameter("idActividadEditarActividad");
           String refererPage = request.getHeader("Referer");
    // Validaciones iniciales
    boolean valid = true;
    if (nombrePremio == null || nivelPremio == null || categoriaPremio == null ||
        tipoPremio == null || costoPremio == null || infoExtraPremio == null || 
        rutaImagenHabito == null || idKitString == null) {
        valid = false;
    }

    int idKit = valid ? Integer.parseInt(idKitString) : 0;
    int costo = valid ? Integer.parseInt(costoPremio) : 0;

    if (!valid) {
        response.sendRedirect(refererPage);
        return;
    }

    // Conexión a la base de datos
    Base bd = new Base();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        bd.conectar();
        conn = bd.getConn();

        // Validar si ya existe un premio con los mismos datos (idCastor, idKit, nombrePremio)
        String checkSql = "SELECT COUNT(*) FROM premios p " +
                          "JOIN relPrem r ON p.idPremio = r.idPremio " +
                          "WHERE r.idKit = ? AND p.idCastor = ? AND p.nombrePremio = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setInt(1, idKit);
        stmt.setInt(2, idCastor);
        stmt.setString(3, nombrePremio);
        rs = stmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // Si ya existe un premio con esos datos, se muestra un mensaje de error
            session.setAttribute("error", "Ya existe un premio con el mismo nombre y relación a este Kit.");
             response.sendRedirect(refererPage);
            return;
        }

        if (idPremio != null && !idPremio.trim().isEmpty()) {
            // Actualizar premio existente
            String updateSql = "UPDATE premios SET nombrePremio = ?, nivelPremio = ?, categoriaPremio = ?, " +
                    "tipoPremio = ?, costoPremio = ?, infoExtraPremio = ?, rutaImagenHabito = ? " +
                    "WHERE idPremio = ? AND idCastor = ?";
            stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, nombrePremio);
            stmt.setString(2, nivelPremio);
            stmt.setString(3, categoriaPremio);
            stmt.setString(4, tipoPremio);
            stmt.setInt(5, costo);
            stmt.setString(6, infoExtraPremio);
            stmt.setString(7, rutaImagenHabito);
            stmt.setInt(8, Integer.parseInt(idPremio));
            stmt.setInt(9, idCastor);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
         response.sendRedirect(refererPage);
            } else {
                out.println("Error al actualizar el premio.");
            }
        } else {
            // Insertar nuevo premio
            String insertSql = "INSERT INTO premios (idCastor, nombrePremio, nivelPremio, categoriaPremio, " +
                    "tipoPremio, costoPremio, infoExtraPremio, rutaImagenHabito) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, idCastor); // Obtener de la sesión
            stmt.setString(2, nombrePremio);
            stmt.setString(3, nivelPremio);
            stmt.setString(4, categoriaPremio);
            stmt.setString(5, tipoPremio);
            stmt.setInt(6, costo);
            stmt.setString(7, infoExtraPremio);
            stmt.setString(8, rutaImagenHabito);
            stmt.executeUpdate();

            // Obtener el id del premio recién creado
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int nuevoIdPremio = rs.getInt(1);

                // Insertar en relPrem
                String relPremSql = "INSERT INTO relPrem (idKit, idCastor, idPremio) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(relPremSql);
                stmt.setInt(1, idKit);
                stmt.setInt(2, idCastor);
                stmt.setInt(3, nuevoIdPremio);
                stmt.executeUpdate();
            }

            out.println("Premio creado exitosamente.");
           response.sendRedirect(refererPage);
        }
    } catch (SQLException ex) {
        out.println("Error en la base de datos: " + ex.getMessage());
        ex.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            bd.cierraConexion();
        } catch (SQLException ex) {
            out.println("Error al cerrar recursos: " + ex.getMessage());
        }
    }
%>
</body>
</html>