<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%                session = request.getSession(true);

            String idUsuario = request.getParameter("idKit");
            String nombreUsuario = request.getParameter("nombreUsuario");

            if (idUsuario != null && nombreUsuario != null) {
                session.setAttribute("usuarioSeleccionado", idUsuario);
                session.setAttribute("nombreUsuarioSeleccionado", nombreUsuario);
                response.sendRedirect("chat_tutor.jsp");
                out.print("success");
            } else {
                out.print("error");
            }
        %>  
    </body>
</html>
