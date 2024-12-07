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
        <title>Procesa Recompensas</title>
    </head>
    <body>
        <%
         session = request.getSession(true);
                String idKit = request.getParameter("idKit");

                session.setAttribute("idKit", idKit);
                response.sendRedirect("recompensas_tutor.jsp");
                %>
    </body>
</html>
