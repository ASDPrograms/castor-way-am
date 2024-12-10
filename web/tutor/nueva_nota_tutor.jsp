<%-- 
    Document   : nueva_nota_tutor
    Created on : 26 nov. 2024, 08:16:36
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="diario">
            <form action="subir_nota_hijo.jsp" method="POST" id="subir_nota">
                <div class="titulo"> 
                    <input type="text" name="titulo-nota" placeholder="titulo" id="titulo-nota" >
                    <span class = "error" id = "tituloError"></span>
                </div>
                <div class="nota-info">
                    <input type="text" name="infoNota-nota" placeholder="Escribe aquí..." id="infoNota-nota" >
                    <span class = "error" id = "infoError"></span>
                    
                </div>
                <button type="submit" class="btn-crear-nota">Crear</button>
            </form>
        </div>
    </body>
</html>