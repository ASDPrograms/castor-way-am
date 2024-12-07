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
            String idKit = request.getParameter("idKit");

            session.setAttribute("idKit", idKit);
            response.sendRedirect("calendario_tutor.jsp");

            Base bd = new Base();
            try {
                bd.conectar();

            } catch (Exception e) {
            } finally {
                
                if (bd != null) {
                    try {
                        bd.cierraConexion();
                    } catch (Exception ex) {
                        out.println("Error al cerrar la conexión: " + ex.getMessage());
                    }
                }
            }


        %>
    </body>
</html>