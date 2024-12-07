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

            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            email = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");

            String codPresa = "";
            String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            int numCaracterescodPresa = 12;
            Random random = new Random();
            StringBuilder pattern = new StringBuilder();
            for (int i = 0; i < numCaracterescodPresa; i++) {
                int index = random.nextInt(caracteres.length());
                pattern.append(caracteres.charAt(index));
            }
            codPresa = pattern.toString();

            String errorMsg = "bien";

            String edadStr = request.getParameter("edad");
            int edad = 0;
            boolean esValido = true;

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

            if (nombre == null || nombre.isEmpty() || apellidos == null || apellidos.isEmpty() || email == null || email.isEmpty() || contrasena == null || contrasena.isEmpty()) {
                errorMsg = "Favor de verificar que todos los campos estén llenos y bien válidados";
            }

            if (errorMsg != "bien" || !errorMsg.equals("bien")) {
                session = request.getSession(true);
                session.setAttribute("error", errorMsg);
                response.sendRedirect("registro_tutor.jsp");
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

                    if (count > 0) {
                        // El correo ya existe
                        session.setAttribute("error", "El correo electrónico ya está registrado, intente con uno nuevo.");
                        response.sendRedirect("registro_tutor.jsp");
                        return;
                    }
                    else if(!(count > 0)){
                        String strQuery = "INSERT INTO Castor (codPresa, nombre, apellidos, edad, email, contraseña) VALUES ('" + codPresa + "', '" + nombre + "', '" + apellidos + "', '" + edad + "', '" + email + "', '" + contrasena + "')";

                        int resultadoInsert = bd.insertar(strQuery);

                        session.setAttribute("email", email);

                        out.println("Inserción exitosa. Filas afectadas: " + resultadoInsert);
                        response.sendRedirect("../tutor/home_tutor.jsp");
                    } else {
                        response.sendRedirect("../formsRegistroTutorJSP.jsp?error=correo_existente");
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
