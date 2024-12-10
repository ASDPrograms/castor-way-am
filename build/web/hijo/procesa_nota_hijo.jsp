<%-- 
    Document   : subir_nota_hijo.jsp
    Created on : 27 nov. 2024, 11:05:11
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.Base"%>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.io.*,java.util.*"%>
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
    String tituloNota = request.getParameter("titulo-nota");
    String infoNota = request.getParameter("infoNota-nota");
    String privacidad = request.getParameter("privacidad_nota");
    String estado = request.getParameter("feel_nota");

    if (tituloNota == null || tituloNota.isEmpty() || 
        infoNota == null || infoNota.isEmpty() || 
        privacidad == null || privacidad.isEmpty() || 
        estado == null || estado.isEmpty()) {
        out.println("Error: Todos los campos son obligatorios.");
        return;
    }

    int privacidadValor = Integer.parseInt(privacidad);
    int idKit = 0;
    int idCastor = 0;

    Base bd = new Base();

    try {
        bd.conectar();
        System.out.println("Conexión establecida.");

        String queryKit = "SELECT idKit FROM Kit WHERE nombreUsuario = ?";
        PreparedStatement stmtKit = bd.getConn().prepareStatement(queryKit);
        stmtKit.setString(1, nombreUsuario);
        ResultSet rsKit = stmtKit.executeQuery();

        if (rsKit.next()) {
            idKit = rsKit.getInt("idKit");
            System.out.println("idKit obtenido: " + idKit);
        } else {
            out.println("Error: No se encontró un Kit asociado al usuario.");
            return;
        }

        String insertDiario = "INSERT INTO diario (titulo, info, privacidad, imgSentimiento, idKit) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmtDiario = bd.getConn().prepareStatement(insertDiario);
        stmtDiario.setString(1, tituloNota);
        stmtDiario.setString(2, infoNota);
        stmtDiario.setInt(3, privacidadValor);
        stmtDiario.setString(4, estado);
        stmtDiario.setInt(5, idKit);

        int resultadoInsertDiario = stmtDiario.executeUpdate();
        System.out.println("Nota insertada. Filas afectadas: " + resultadoInsertDiario);

        // Comprobar si ya existe la relación en relDiario
        String queryRelDiario = "SELECT COUNT(*) FROM relDiario WHERE idKit = ?";
        PreparedStatement stmtCheckRel = bd.getConn().prepareStatement(queryRelDiario);
        stmtCheckRel.setInt(1, idKit);
        ResultSet rsRel = stmtCheckRel.executeQuery();

        if (rsRel.next() && rsRel.getInt(1) == 0) {
        System.out.println("Relación no encontrada en relDiario, procediendo a buscar idCastor...");

    String queryIdCastor = "SELECT idCastor FROM relKitCastor WHERE idKit = ?";
    PreparedStatement stmtCastor = bd.getConn().prepareStatement(queryIdCastor);
    stmtCastor.setInt(1, idKit);
    
    System.out.println("Ejecutando consulta: " + queryIdCastor + " con idKit " + idKit);
    
    ResultSet rsCastor = stmtCastor.executeQuery();

    if (rsCastor.next()) {
         idCastor = rsCastor.getInt("idCastor");
        System.out.println("idCastor encontrado: " + idCastor);

        String insertRelQuery = "INSERT INTO relDiario (idKit, idCastor) VALUES (?, ?)";
        PreparedStatement insertRelStmt = bd.getConn().prepareStatement(insertRelQuery);
        insertRelStmt.setInt(1, idKit);
        insertRelStmt.setInt(2, idCastor);
        
        int insertRelResult = insertRelStmt.executeUpdate();
        
        if (insertRelResult > 0) {
            System.out.println("Relación en relDiario insertada exitosamente.");
        } else {
            System.out.println("Error al insertar relación en relDiario.");
        }
    } else {
        System.out.println("No se encontró ningún registro con idKit " + idKit);
    }
} else {
    System.out.println("La relación ya existe en relDiario.");
}

        if (privacidadValor == 0) {
            response.sendRedirect("../hijo/diario_notasPublic.jsp");
        } else {
            response.sendRedirect("../hijo/diario_hijo.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            bd.cierraConexion();
        } catch (SQLException ex) {
            out.println("Error al cerrar la conexión: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
} else {
    response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
}
%>


    </body>
</html>