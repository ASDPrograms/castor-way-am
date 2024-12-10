<%-- 
    Document   : editar_informacion_perfil_tutor
    Created on : 27 oct 2024, 2:21:33 p.m.
    Author     : Alicia
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
    if (session != null && session.getAttribute("email") != null) {
        String email = (String) session.getAttribute("email");
        String idCastor = request.getParameter("idCastor");
        String nombre = request.getParameter("nombre-acutalizado");
        String apellidosActualizado = request.getParameter("apellidos-actualizado");
        String emailActualizado = request.getParameter("email-actualizado");
        String contrasenaActualizada = request.getParameter("contrasena-actualizada");
        String edadStr = request.getParameter("edad-actualizado");
        Integer edad = null;

        
        if (edadStr != null && !edadStr.isEmpty()) {
            try {
                edad = Integer.parseInt(edadStr);
            } catch (NumberFormatException e) {
                edad = null; 
            }
        }

     
        response.getWriter().println("idCastor: " + idCastor);
        response.getWriter().println("nombre: " + nombre);
        response.getWriter().println("email: " + emailActualizado);
        response.getWriter().println("contraseña: " + contrasenaActualizada);
        response.getWriter().println("edad: " + edadStr);
        response.getWriter().println("apellidos: " + apellidosActualizado);

        Base bd = new Base();
        try {
            bd.conectar(); 

            StringBuilder strQ = new StringBuilder("UPDATE Castor SET ");
            boolean hasField = false;

            
            if (nombre != null && !nombre.isEmpty()) {
                strQ.append("nombre = ?, ");
                hasField = true;
            }
            if (emailActualizado != null && !emailActualizado.isEmpty()) {
                strQ.append("email = ?, ");
                hasField = true;
            }
            if (contrasenaActualizada != null && !contrasenaActualizada.isEmpty()) {
                strQ.append("contraseña = ?, ");
                hasField = true;
            }
            if (edad != null) { 
                strQ.append("edad = ?, ");
                hasField = true;
            }
            if (apellidosActualizado != null && !apellidosActualizado.isEmpty()) {
                strQ.append("apellidos = ?, ");
                hasField = true;
            } 

           
            if (hasField) {
                strQ.setLength(strQ.length() - 2); 
                strQ.append(" WHERE idCastor = ?"); 

                PreparedStatement pstmt = bd.getConn().prepareStatement(strQ.toString());
                int index = 1;

               
                if (nombre != null && !nombre.isEmpty()) {
                    pstmt.setString(index++, nombre);
                }
                if (emailActualizado != null && !emailActualizado.isEmpty()) {
                    pstmt.setString(index++, emailActualizado);
                }
                if (contrasenaActualizada != null && !contrasenaActualizada.isEmpty()) {
                    pstmt.setString(index++, contrasenaActualizada);
                }
                if (edad != null) { 
                    pstmt.setInt(index++, edad);
                }
                if (apellidosActualizado != null){
                    pstmt.setString(index++, apellidosActualizado);
                 }

                pstmt.setString(index, idCastor);
                pstmt.executeUpdate();

               
                if (emailActualizado != null && !emailActualizado.isEmpty()) {
                    session.setAttribute("email", emailActualizado);
                }
            }
            response.sendRedirect("perfil_tutor.jsp"); 
        } catch (Exception e) {
            e.printStackTrace(response.getWriter()); 
        }
    } else {
        response.sendRedirect("../formularios_sesion/inicio_sesion_tutor.jsp"); 
    }
%>
    </body>
</html>