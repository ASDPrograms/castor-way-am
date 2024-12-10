<%-- 
    Document   : editar_informacion_perfil_hijo
    Created on : 21 nov. 2024, 13:15:44
    Author     : Usuario
--%>
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
    session = request.getSession(false);
    if (session != null && session.getAttribute("usuario") != null) {
        String nombreUsuario = (String) session.getAttribute("usuario");
        
        String nombreUsuarioAct = request.getParameter("nombreUsuario-acutalizado");
        
       response.getWriter().println("nombre " + nombreUsuarioAct);
       

        Base bd = new Base();
        try {
            bd.conectar(); 

            StringBuilder strQ = new StringBuilder("UPDATE Kit SET ");
            boolean hasField = false;

            
            if (nombreUsuarioAct != null && !nombreUsuarioAct.isEmpty()) {
                strQ.append("nombreUsuario = ?, ");
                hasField = true;
            }
           

           
            if (hasField) {
                strQ.setLength(strQ.length() - 2); 
                strQ.append(" WHERE nombreUsuario = ?"); 

                PreparedStatement pstmt = bd.getConn().prepareStatement(strQ.toString());
                int index = 1;
                
                if (nombreUsuarioAct != null && !nombreUsuarioAct.isEmpty()) {
                    pstmt.setString(index++, nombreUsuarioAct);
                }
                pstmt.setString(index, nombreUsuario);
                pstmt.executeUpdate();
                 if (nombreUsuarioAct != null && !nombreUsuarioAct.isEmpty()) {
                    session.setAttribute("usuario", nombreUsuarioAct);
                }
            }
           
                
            response.sendRedirect("perfil_hijo.jsp"); 
        } catch (Exception e) {
            e.printStackTrace(response.getWriter()); 
        }
    } else {
        response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp"); 
    }
%>
    </body>
</html>