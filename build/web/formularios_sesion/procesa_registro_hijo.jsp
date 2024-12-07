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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String returnUrl = request.getParameter("returnUrl");

            if ((!returnUrl.equals("http://localhost:8080/CastorWay/tutor/home_tutor.jsp") && !returnUrl.equals("http://localhost:8080/CastorWay/tutor/actividades_tutor.jsp") && !returnUrl.equals("http://localhost:8080/CastorWay/tutor/calendario_tutor.jsp") && !returnUrl.equals("http://localhost:8080/CastorWay/tutor/diario_tutor.jsp") && !returnUrl.equals("http://localhost:8080/CastorWay/tutor/chat_tutor.jsp") && !returnUrl.equals("http://localhost:8080/CastorWay/tutor/recompensas_tutor.jsp")) || returnUrl.isEmpty() || returnUrl == null) {
                returnUrl = "http://localhost:8080/CastorWay/hijo/home_hijo.jsp"; // Página predeterminada si no se especifica returnUrl
            }
           
            session = request.getSession(true);
            String usuario = (String) session.getAttribute("usuario");

            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");

            String codPresa = request.getParameter("codPresa");

            String errorMsg = "bien";

            String edadStr = request.getParameter("edad");
            int edad = 0;
            boolean esValido = true;

            // Validación de la edad
            if (edadStr == null || edadStr.trim().isEmpty()) {
                esValido = false;
                errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
            } else {
                try {
                    edad = Integer.parseInt(edadStr);
                } catch (NumberFormatException e) {
                    esValido = false;
                    errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
                }
            }

            // Validación de otros campos
            if (nombre == null || nombre.isEmpty() || apellidos == null || apellidos.isEmpty() || usuario == null || usuario.isEmpty() || codPresa == null || codPresa.isEmpty()) {
                errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
            }

            // Manejo de errores
            if (!errorMsg.equals("bien")) {
                session.setAttribute("error", errorMsg);
                response.sendRedirect("registro_hijo.jsp");
                return;
            } else {
                session.removeAttribute("error");
                Base bd = new Base();

                try {
                    bd.conectar();

                    // Consulta para verificar codPresa
                    String checkCodPresaQuery = "SELECT COUNT(*) FROM Castor WHERE codPresa = ?";
                    PreparedStatement pstmt = bd.getConn().prepareStatement(checkCodPresaQuery);
                    pstmt.setString(1, codPresa);
                    ResultSet rs = pstmt.executeQuery();
                    int count = 0;
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                    rs.close();
                    pstmt.close();

                    if (count == 0) {
                        session.setAttribute("error", "El código de Presa no está vinculado a un tutor existente.");
                        response.sendRedirect("registro_hijo.jsp");
                        return;
                    }

                    // Obtener idCastor
                    String getIdCastorQuery = "SELECT idCastor FROM Castor WHERE codPresa = ?";
                    pstmt = bd.getConn().prepareStatement(getIdCastorQuery);
                    pstmt.setString(1, codPresa);
                    rs = pstmt.executeQuery();
                    int idCastor = -1;
                    if (rs.next()) {
                        idCastor = rs.getInt("idCastor");
                    }
                    rs.close();
                    pstmt.close();

                    // Verificar si el usuario ya existe
                    String checkUserQuery = "SELECT COUNT(*) FROM Kit WHERE nombreUsuario = ?";
                    pstmt = bd.getConn().prepareStatement(checkUserQuery);
                    pstmt.setString(1, usuario);
                    rs = pstmt.executeQuery();
                    count = 0;
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                    rs.close();

                    if (count > 0) {
                        session.setAttribute("error", "El usuario ya está registrado, intente con uno nuevo.");
                        response.sendRedirect("registro_hijo.jsp");
                        return;
                    } else {
                        // Inserción en la tabla Kit
                        String strQuery = "INSERT INTO Kit (codPresa, nombreUsuario, nombre, apellidos, edad) VALUES (?, ?, ?, ?, ?)";
                        pstmt = bd.getConn().prepareStatement(strQuery, Statement.RETURN_GENERATED_KEYS);
                        pstmt.setString(1, codPresa);
                        pstmt.setString(2, usuario);
                        pstmt.setString(3, nombre);
                        pstmt.setString(4, apellidos);
                        pstmt.setInt(5, edad);

                        int resultadoInsert = pstmt.executeUpdate();

                        // Recuperar el idKit generado
                        ResultSet generatedKeys = pstmt.getGeneratedKeys();
                        int idKit = -1;
                        if (generatedKeys.next()) {
                            idKit = generatedKeys.getInt(1);
                        }
                        generatedKeys.close();
                        pstmt.close();

                        if (idKit != -1) {
                            // Insertar en la tabla relKitCastor
                            String insertRelQuery = "INSERT INTO relKitCastor (codPresa, idKit, idCastor) VALUES (?, ?, ?)";
                            pstmt = bd.getConn().prepareStatement(insertRelQuery);
                            pstmt.setString(1, codPresa);
                            pstmt.setInt(2, idKit);
                            pstmt.setInt(3, idCastor);
                            pstmt.executeUpdate();
                            pstmt.close();

                            // Redirigir al usuario
                            session.setAttribute("usuario", usuario);
                            session.setAttribute("idCastor", idCastor);

                            if (returnUrl == null || returnUrl.isEmpty() || returnUrl.equals(null)) {
                                response.sendRedirect("../hijo/home_hijo.jsp");
                            } else {
                                response.sendRedirect(returnUrl); // Redirige a la URL original
                            }
                            out.println("Inserción exitosa en Kit y relKitCastor. Filas afectadas: " + resultadoInsert);
                        }
                    }

                } catch (java.sql.SQLException ex) {
                    out.println("Error al insertar en la base de datos: " + ex.getMessage());
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
            }
        %>
    </body>
</html>

