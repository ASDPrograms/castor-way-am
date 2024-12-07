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
            session = request.getSession(true);
            String email = (String) session.getAttribute("email");

            email = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");

            String errorMsg = "bien";

            if (email == null || email.isEmpty() || contrasena == null || contrasena.isEmpty()) {
                errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
            }

            if (errorMsg != "bien" || !errorMsg.equals("bien")) {
                session = request.getSession(true);
                session.setAttribute("error", errorMsg);
                response.sendRedirect("inicio_sesion_tutor.jsp");
                return;
            } else {
                session.removeAttribute("error");
                Base bd = new Base();
                try {
                    bd.conectar();

                    // Verificar si el correo ya existe
                    String checkEmailQuery = "SELECT COUNT(*) FROM Castor WHERE email = ?";
                    PreparedStatement pstmt = bd.getConn().prepareStatement(checkEmailQuery);
                    pstmt.setString(1, email);
                    ResultSet rs = pstmt.executeQuery();
                    int count = 0;
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                    rs.close();
                    pstmt.close();

                    if (count == 1) {
                        // El correo si existe, ahora verificar que la contraseña coincida con el correo
                        String checkPasswordQuery = "SELECT COUNT(*) FROM Castor WHERE email = ? AND contraseña = ?";
                        PreparedStatement pstmtPassword = bd.getConn().prepareStatement(checkPasswordQuery);
                        pstmtPassword.setString(1, email);
                        pstmtPassword.setString(2, contrasena);
                        ResultSet rsPassword = pstmtPassword.executeQuery();
                        int passwordCount = 0;
                        if (rsPassword.next()) {
                            passwordCount = rsPassword.getInt(1);
                        }
                        rsPassword.close();
                        pstmtPassword.close();

                        if (passwordCount == 1) {
                            
                            session.setAttribute("email", email);
                            response.sendRedirect("../tutor/home_tutor.jsp");
                        } else {
                            // Contraseña incorrecta
                            session.setAttribute("correoGuardado", email);
                            session.setAttribute("error", "Contraseña incorrecta. Inténtelo de nuevo.");
                            response.sendRedirect("inicio_sesion_tutor.jsp");
                            return;
                        }

                        session.setAttribute("email", email);

                        response.sendRedirect("../tutor/home_tutor.jsp");
                    } else {
                        session.removeAttribute("correoGuardado");
                        session.setAttribute("error", "Éste correo electrónico no está registrado, intente con uno nuevo o pruebe registrarse");
                        response.sendRedirect("inicio_sesion_tutor.jsp");
                        return;
                    }

                } catch (java.sql.SQLException ex) {
                    out.println("Error al insertar en la base de datos: " + ex.getMessage());
                    ex.printStackTrace(); // Imprime el rastro de la pila para obtener más detalles
                } catch (Exception ex) {
                    out.println("Error general: " + ex.getMessage());
                    ex.printStackTrace(); // Imprime el rastro de la pila para obtener más detalles
                } finally {
                    try {
                        bd.cierraConexion();
                    } catch (Exception ex) {
                        out.println("Error al cerrar la conexión: " + ex.getMessage());
                        ex.printStackTrace(); // Imprime el rastro de la pila para obtener más detalles
                    }
                }
            }


        %>

    </body>
</html>
