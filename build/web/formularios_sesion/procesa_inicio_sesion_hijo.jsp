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
            String usuario = (String) session.getAttribute("usuario");

            usuario = request.getParameter("usuario");
            String codPresa = request.getParameter("codPresa");
            String errorMsg = "bien";

            if (usuario == null || usuario.isEmpty()) {
                errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
            }

            if (errorMsg != "bien" || !errorMsg.equals("bien")) {
                session = request.getSession(true);
                session.setAttribute("error", errorMsg);
                response.sendRedirect("inicio_sesion_hijo.jsp");
                return;
            } else {
                session.removeAttribute("error");
                Base bd = new Base();
                try {
                    bd.conectar();

                    // Verificar si el usuario ya existe
                    String checkUsuarioQuery = "SELECT COUNT(*) FROM Kit WHERE nombreUsuario = ?";
                    PreparedStatement pstmt = bd.getConn().prepareStatement(checkUsuarioQuery);
                    pstmt.setString(1, usuario);
                    ResultSet rs = pstmt.executeQuery();
                    int count = 0;
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                    rs.close();
                    pstmt.close();

                    if (count == 1) {
                        String checkPasswordQuery = "SELECT COUNT(*) FROM Kit WHERE nombreUsuario = ? AND codPresa = ?";
                        PreparedStatement pstmtPassword = bd.getConn().prepareStatement(checkPasswordQuery);
                        pstmtPassword.setString(1, usuario);
                        pstmtPassword.setString(2, codPresa);
                        ResultSet rsPassword = pstmtPassword.executeQuery();
                        int codPresaCount = 0;
                        if (rsPassword.next()) {
                            codPresaCount = rsPassword.getInt(1);
                        }
                        rsPassword.close();
                        pstmtPassword.close();

                        if (codPresaCount == 1) {
                            
                        session.setAttribute("usuario", usuario);
                        session.setAttribute("codPresa", codPresa);
                        response.sendRedirect("../hijo/home_hijo.jsp");
                        }
                        else {
                            session.setAttribute("usuarioGuardado", usuario);
                            session.setAttribute("error", "Código de Presa incorrecto. Inténtelo de nuevo.");
                            response.sendRedirect("inicio_sesion_hijo.jsp");
                            return;
                        }

                    } else {
                        session.removeAttribute("usuarioGuardado");
                        session.setAttribute("error", "Éste usuario no existe, intente con uno nuevo o pruebe registrarse");
                        response.sendRedirect("inicio_sesion_hijo.jsp");
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
