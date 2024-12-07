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
        <meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../estilos_css/estilos_tutor/css_recompensas_tutor.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Gayathri:wght@100;400;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&display=swap" rel="stylesheet">
        <link rel="icon" href="../img/icono_cafe_logo.svg" type="image/x-icon" sizes="16x16 32x32 48x48">
        <title>Recompensas - CastorWay</title>
    </head>
    <body>
        <%
           
            session = request.getSession(false);
            String email = (String) session.getAttribute("email");
            if(email==null){
            response.sendRedirect("../formularios_sesion/inicio_sesion_tutor.jsp");
            }
            Base bd = new Base();
            boolean tieneHijos = false;

            try {

                bd.conectar();
                String query = "SELECT COUNT(*) FROM Kit WHERE codPresa IN (SELECT codPresa FROM Castor WHERE email = ?)";
                PreparedStatement pstmt = bd.getConn().prepareStatement(query);
                pstmt.setString(1, email);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    tieneHijos = true;
                }
                rs.close();
                pstmt.close();
            } catch (SQLException ex) {
                out.println("Error al verificar los hijos: " + ex.getMessage());
            } finally {
                bd.cierraConexion(); 
            }
        %>
        <nav class="sidebar">
            <div class="logo-section menu-item" id = "logoNavbar">
                <img src="../img/logo_letras_castorway.svg" alt="Logo" class="icon" id = "iconoNavLogo">
            </div>
            <div class="icon-section">
                <div class="menu-item">
                    <a href="home_tutor.jsp" class = "a_nav"> 
                        <img class="icon icon1" src="../img/icono_casita.svg">
                        <span class="textNav">Inicio</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="actividades_tutor.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="calendario_tutor.jsp">
                        <img class="icon icon1" src="../img/icono_calendario.svg">
                        <span class="textNav">Calendario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="diario_tutor.jsp">
                        <img class="icon icon1" src="../img/icono_diario.svg">
                        <span class="textNav">Diario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="chat_tutor.jsp">
                        <img class="icon icon1" src="../img/icono_chat.svg">
                        <span class="textNav">Chat</span>
                    </a>
                </div>
                <div class="menu-item" id = "div_nav_home">
                    <a href="recompensas_tutor.jsp" class="a_nav">
                        <img class="icon icon1" src="../img/icono_recompensa.svg">
                        <span class="textNav">Recompensas</span>
                    </a>
                </div>
            </div>
            <div class="bottom-section">
                <div class="menu-item toggle">
                    <img class="icon icon1" src="../img/icono_MenuDesplegable.svg">
                </div>
                <div class="menu-item toggle">
                    <img class="icon icon1" src="../img/icono_setings.svg">
                </div>
            </div>
        </nav>
        <div class="content">
            <div class="secondary-nav">
                <div class = "izquierda-secondary-nav">
                    <a style="display: flex; padding-bottom: 0;" id="text-tit-act-sec-nav">Recompensas</a>
                </div>
                <div class = "derecha-secondary-nav">
                    <%                            session = request.getSession(false);

                        if (session != null && session.getAttribute("idKit") != null) {
                            String idKit = (String) session.getAttribute("idKit");
                            int idKitInt = Integer.parseInt(idKit);
                    %>
                    <%                           
                        try {
                            bd.conectar();

                            String consult2 = "select * from Kit where idKit = ?";
                            PreparedStatement pstmt5 = bd.getConn().prepareStatement(consult2);
                            pstmt5.setInt(1, idKitInt);
                            ResultSet r2 = pstmt5.executeQuery();
                            while (r2.next()) {
                    %>
                    <div style="display: flex;">
                        <img src="../img/hojaCongelada.svg">
                        <p class = "second-nav-hojas-congeladas"><%=r2.getString("hojasCongeladas")%></p>
                    </div>
                    <div style="display: flex;">
                        <img src="../img/icono_ramita.svg">
                        <p class = "second-nav-ramitas"><%=r2.getString("ramitas")%></p>
                    </div>
                    <%
                        }
                    %>
                    <%
                        } catch (Exception e) {
                        }
                    %>
                    <%} else {
                    %>
                    <div style="display: flex;">
                        <img src="../img/hojaCongelada.svg" style="flex: 1;">
                        <p id="texto-hojas-cong-secondary-nav" class = "second-nav-hojas-congeladas"style="flex: 1;">0</p>
                    </div>
                    <div style="display: flex;">
                        <img src="../img/icono_ramita.svg"style="flex: 1;">
                        <p id="texto-ramitas-secondary-nav" class = "second-nav-ramitas" style="flex: 1;">0</p>
                    </div>
                    <%
                        }
                    %>
                    <a id="icono-notificaciones-secondary-nav" href="" style="display: flex;"><img src="../img/iconito_notifiNotificacion.svg" class = "imgNavSecondary"></a>
                    <a id="icono-perfil-secondary-nav" href="perfil_tutor.jsp" style="display: flex;"> <img src="../img/icono_Perfil.svg" class = "imgNavSecondary"></a>
                </div>
            </div>
            <div class="principal">

                <div class="imagen" 
                     style="background-image: url('./..//img/Cator fondito.svg');
                     background-repeat: no-repeat; background-position: center;
                     background-size: cover; position: relative; width: 100%; height: 100%; overflow: hidden;">

                    <div class="flechitas" id="reclamados">
                        <div class="Premio1">Premios sin Reclamar</div>
                        <div class="flechas-container">
                            <div class="fle" onclick="window.location.href = 'recompensas_tutor.jsp';" style="cursor: pointer;">
                                <img src="../img/Izquierda.svg">
                            </div>
                            <div class="fle" onclick="window.location.href = 'recompensas_tutor.jsp';" style="cursor: pointer;">
                                <img src="../img/Derecha.svg">
                            </div>    
                        </div>
                    </div>
                </div>





                <div class="recom">
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt6 = null;
                        ResultSet rs0 = null;

                        session = request.getSession(false);
                        String idKit = request.getParameter("idKit");

                        if (idKit != null && !idKit.isEmpty()) {
                            session.setAttribute("idKit", idKit);
                        } else {
                            idKit = (String) session.getAttribute("idKit");
                        }

                        if (idKit == null || idKit.isEmpty()) {
                    %>
                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado">
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">Seleccionar primero una cuenta de Kit para poder acceder a la información de esa cuenta.</p>
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" style="height:12vw; width:auto;" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                    </div>
                    <%
                    } else {
                        try {
                            bd.conectar();
                            conn = bd.getConn();

                            String query = "SELECT DISTINCT p.* FROM premios p "
                                    + "JOIN relPrem rp ON p.idCastor = rp.idCastor "
                                    + "WHERE rp.idKit = ?";
                            pstmt6 = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            pstmt6.setInt(1, Integer.parseInt(idKit));
                            rs0 = pstmt6.executeQuery();

                            if (!rs0.next()) {
                    %>
                    <div class="mensaje-sin-premios">
                        <div><p class="no-premios">No hay premios disponibles para esta cuenta de Kit.</p></div>
                        <div id="div-container-nopremio-img">
                            <img src="../img/Castor.svg" alt="Seleccionar usuario" id="img-hijo-no-premio">
                        </div>
                    </div>
                    <%
                    } else {
                        rs0.beforeFirst();
                    %>
                    <div class="conte">
                        <div class="fav">
                            <p class="favo">Tus favoritos</p>
                        </div>
                        <div class="Iz">
                            <img src="../img/Izquierda.svg" class="flecha-izquierda" onclick="moverIzquierda()" style="cursor: pointer;">
                        </div>
                        <div class="prem">
                            <%
                                String query5 = "SELECT DISTINCT p.*, k.ramitas FROM premios p "
                + "JOIN relPrem rp ON p.idPremio = rp.idPremio "
                + "JOIN Kit k ON rp.idKit = k.idKit "
                + "WHERE rp.idKit = ? "
                + "AND p.estadoPremio = 0 "
                + "ORDER BY p.Favorito DESC";


                                try (PreparedStatement pstmt = conn.prepareStatement(query5)) {
                                    pstmt.setInt(1, Integer.parseInt(idKit)); 
                                    ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                String nombrePremio = rs.getString("nombrePremio");
                String nivelPremio = rs.getString("nivelPremio");
                String categoriaPremio = rs.getString("categoriaPremio");
                String tipoPremio = rs.getString("tipoPremio");
                int costoPremio = rs.getInt("costoPremio");
                String infoExtraPremio = rs.getString("infoExtraPremio");
                String rutaImagenHabito = rs.getString("rutaImagenHabito");
                int estadoPremio = rs.getInt("estadoPremio");
                int favorito = rs.getInt("Favorito");
                int ramitas = rs.getInt("ramitas"); 
                
                

                                        String imagenEstado = (estadoPremio == 0) ? "../img/PremioSinReclamar.svg" : "../img/PremioReclamado.svg";
                                        String imagenFav = (favorito == 0) ? "../img/NoFavorito.svg" : "../img/Favorito.svg";
                            %>
                            <div 
                                class="premio"  
                                data-id="<%= rs.getInt("idPremio") %>" 
                                data-nombre="<%= nombrePremio %>" 
                                data-nivel="<%= nivelPremio %>" 
                                data-categoria="<%= categoriaPremio %>" 
                                data-tipo="<%= tipoPremio %>" 
                                data-costo="<%= costoPremio %>" 
                                data-info="<%= infoExtraPremio %>" 
                                data-estado="<%= estadoPremio %>" 
                                data-favorito="<%= favorito %>"
                                data-ramitas="<%= ramitas%>"

                                >
                                <div class="Imal"  style="cursor: pointer;" data-id="<%= rs.getInt("idPremio") %>" 
                                     data-nombre="<%= nombrePremio %>" 
                                     data-nivel="<%= nivelPremio %>" 
                                     data-categoria="<%= categoriaPremio %>" 
                                     data-tipo="<%= tipoPremio %>" 
                                     data-costo="<%= costoPremio %>" 
                                     data-info="<%= infoExtraPremio %>" 
                                     data-estado="<%= estadoPremio %>" 
                                     data-favorito="<%= favorito %>"
                                     data-ramitas="<%= ramitas%>"
                                     onclick="mostrarModalPremio(event);"><img src="<%= rutaImagenHabito%>" id="imgPremio"></div>
                                <div class="Nomel"><p class="nomPremio"><%= nombrePremio%></p></div>
                                <div class="Sele" >
                                    <img src="<%= imagenFav%>" class="estadoPremio" style="cursor: pointer;" onclick="cambiarEstado(this, 'favorito');">
                                    <img src="<%= imagenEstado%>" class="estadoImagen" style="cursor: pointer; " onclick="cambiarEstado(this, 'premio');">
                                </div>
                            </div>
                            <%
                                        String idPremioParam = request.getParameter("idPremio");
                                        String estadoParam = request.getParameter("estado");
                                        String favoritoParam = request.getParameter("favorito");

                                        if (idPremioParam != null && favoritoParam != null) {
                                            int premioId = Integer.parseInt(idPremioParam);
                                            int nuevoFavorito = Integer.parseInt(favoritoParam);
                                            Integer nuevoEstado = estadoParam != null ? Integer.parseInt(estadoParam) : null;

                                            String updateQuery = "UPDATE premios SET Favorito = ?, estadoPremio = ? WHERE idPremio = ?";
                                            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                                                updateStmt.setInt(1, nuevoFavorito);
                                                updateStmt.setInt(2, nuevoEstado);
                                                updateStmt.setInt(3, premioId);
                                                int rowsAffected = updateStmt.executeUpdate();
                                                if (rowsAffected > 0) {
                                                    out.println("Actualización exitosa para el premio ID: " + premioId);
                                                } else {
                                                    out.println("No se realizó ninguna actualización para el premio ID: " + premioId);
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                                out.println("Error al actualizar el premio: " + e.getMessage());
                                            }
                                        }
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                    out.println("Error al acceder a la base de datos: " + e.getMessage());
                                }
                            %>

                        </div>
                        <script>
                            let currentIndex = 0;
                            let premios = []; 

                            function mostrarPremios() {
                                const flechaIzquierda = document.querySelector('.flecha-izquierda');
                                const flechaDerecha = document.querySelector('.flecha-derecha');

                                premios.forEach((premio, index) => {
                                    premio.style.display = (index >= currentIndex && index < currentIndex + 4) ? 'block' : 'none';
                                });

                                flechaIzquierda.style.display = currentIndex > 0 ? 'block' : 'none';
                                flechaDerecha.style.display = (currentIndex + 4 < premios.length) ? 'block' : 'none';

                                if (premios.length === 0) {
                                    const mensajeDiv = document.createElement('div');
                                    mensajeDiv.className = 'mensaje-sin-prem';
                                    mensajeDiv.innerHTML = '<p>No hay premios reclamados.</p>';
                                    document.querySelector('.prem').appendChild(mensajeDiv);
                                    flechaIzquierda.style.display = 'none';
                                    flechaDerecha.style.display = 'none';
                                }
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                premios = document.querySelectorAll('.premio');

                                mostrarPremios();

                                const flechaIzquierda = document.querySelector('.flecha-izquierda');
                                const flechaDerecha = document.querySelector('.flecha-derecha');

                                flechaDerecha.addEventListener('click', moverDerecha);
                                flechaIzquierda.addEventListener('click', moverIzquierda);
                            });

                            function moverDerecha() {
                                if (currentIndex + 4 < premios.length) {
                                    currentIndex += 4; 
                                    mostrarPremios(); 
                                    console.log("Deslizando a la derecha, índice actual: ", currentIndex);
                                }
                            }

                            function moverIzquierda() {
                                if (currentIndex > 0) {
                                    currentIndex -= 4; 
                                    mostrarPremios(); 
                                    console.log("Deslizando a la izquierda, índice actual: ", currentIndex);
                                }
                            }
                            function mostrarModalPremio(event) {
                                const premioElement = event.currentTarget;

                                const idPremio = premioElement.getAttribute('data-id');
                                const imgSrc = premioElement.querySelector("#imgPremio").src || '';
                                const nombre = premioElement.getAttribute('data-nombre') || 'Sin Nombre';
                                const nivel = premioElement.getAttribute('data-nivel') || 'N/A';
                                const categoria = premioElement.getAttribute('data-categoria') || 'N/A';
                                const tipo = premioElement.getAttribute('data-tipo') || 'N/A';
                                const costo = premioElement.getAttribute('data-costo') || 'N/A';
                                const estadoPremio = premioElement.getAttribute('data-estado');
                                const favoritoPremio = premioElement.getAttribute('data-favorito');
                                const info = premioElement.getAttribute('data-info');
                                const ramitas = premioElement.getAttribute('data-ramitas') || '0';


                                const estadoImg = (estadoPremio === '1' ? "../img/PremioReclamado.svg" : "../img/PremioSinReclamar.svg");
                                const favoritoImg = (favoritoPremio === '1' ? "../img/Favorito.svg" : "../img/NoFavorito.svg");

                                document.getElementById('img-icono-premio-info').src = imgSrc;
                                document.getElementById('ramitasPremioInfo').textContent = ramitas;
                                document.getElementById('nombrePremioInfo').textContent = nombre;
                                document.getElementById('nivelPremioInfo').textContent = nivel;
                                document.getElementById('categoriaPremioInfo').textContent = categoria;
                                document.getElementById('tipoPremioInfo').textContent = tipo;
                                document.getElementById('costoPremioInfo').textContent = costo;
                                document.getElementById('costoPremioI').textContent = costo;
                                document.getElementById('infoExtraPremioInfo').textContent = info;
                                
                                document.getElementById('rutaImagenP').textContent = imgSrc;
                                document.getElementById('nomPre').textContent = nombre;
                                document.getElementById('nivPre').textContent = nivel;
                                document.getElementById('CatPre').textContent = categoria;
                                document.getElementById('TipoP').textContent = tipo;
                                document.getElementById('costoP').textContent = costo;
                                document.getElementById('InfPre').textContent = info;
                                document.getElementById('idPrem').textContent = idPremio;

                                const estadoImgElement = document.getElementById('estadoPremioInfoImg');
                                const favoritoImgElement = document.getElementById('favoritoPremioInfoImg');

                                if (estadoImgElement && favoritoImgElement) {
                                    estadoImgElement.src = estadoImg; 
                                    favoritoImgElement.src = favoritoImg;  
                                } else {
                                    console.error("Error: Los elementos de imagen no fueron encontrados.");
                                }
                                
                                document.getElementById('modalPremio').style.display = 'flex';
                            }


                            function cerrarModalPremio() {
                                document.getElementById('modalPremio').style.display = 'none';
                            }


                            function cambiarEstado(element, tipo) {
                                var premioElement = element.closest('.premio');
                                var imgEstado = premioElement.querySelector('.estadoImagen');
                                var imgFavorito = premioElement.querySelector('.estadoPremio');
                                var estadoActual = parseInt(premioElement.getAttribute('data-estado'));
                                var favoritoActual = parseInt(premioElement.getAttribute('data-favorito'));
                                var idPremio = premioElement.getAttribute('data-id');

                                if (tipo === 'premio') {
                                    var nuevoEstado = estadoActual === 0 ? 1 : 0;
                                    imgEstado.src = nuevoEstado === 1 ? "../img/PremioReclamado.svg" : "../img/PremioSinReclamar.svg";
                                    premioElement.setAttribute('data-estado', nuevoEstado);

                                    console.log(`Enviando estado: idPremio=${idPremio}, estado=${nuevoEstado}, favorito=${favoritoActual}`);

                                    fetch('recompensas_tutor_1.jsp?idPremio=' + idPremio + '&estado=' + nuevoEstado + '&favorito=' + favoritoActual)
                                            .then(response => {
                                                if (!response.ok)
                                                    throw new Error('Network response was not ok');
                                                return response.text();
                                            })
                                            .then(data => {
                                                console.log("Estado actualizado: " + data);
                                                if (nuevoEstado === 0) {
                                                    location.reload(); 
                                                } else {

                                                    actualizarContenido();
                                                    location.reload();
                                                }
                                            })
                                            .catch(error => console.error('Error al actualizar estado:', error));

                                } else if (tipo === 'favorito') {
                                    var nuevoFavorito = favoritoActual === 0 ? 1 : 0;
                                    imgFavorito.src = nuevoFavorito === 1 ? "../img/Favorito.svg" : "../img/NoFavorito.svg";
                                    premioElement.setAttribute('data-favorito', nuevoFavorito);

                                    console.log(`Enviando favorito: idPremio=${idPremio}, estado=${estadoActual}, favorito=${nuevoFavorito}`);

                                    fetch('recompensas_tutor_1.jsp?idPremio=' + idPremio + '&estado=' + estadoActual + '&favorito=' + nuevoFavorito)
                                            .then(response => {
                                                if (!response.ok)
                                                    throw new Error('Network response was not ok');
                                                return response.text();
                                            })
                                            .then(data => {
                                                console.log("Favorito actualizado: " + data);
                                                actualizarContenido();
                                                location.reload();
                                            })
                                            .catch(error => console.error('Error al actualizar favorito:', error));
                                }
                            }

                            function actualizarContenido() {
                                fetch('recompensas_tutor_1.jsp') 
                                        .then(response => response.text())
                                        .then(data => {
                                            const contenedorPremios = document.querySelector('.prem');
                                            contenedorPremios.innerHTML = data; 
                                            actualizarOrden();
                                            mostrarPremios();
                                        })
                                        .catch(error => console.error('Error al obtener contenido actualizado:', error));
                            }


                            function actualizarOrden() {
                                const premiosContainer = document.querySelector('.prem');
                                const premios = Array.from(premiosContainer.getElementsByClassName('premio'));

                                premios.sort((a, b) => {
                                    const favoritoA = parseInt(a.getAttribute('data-favorito'));
                                    const favoritoB = parseInt(b.getAttribute('data-favorito'));

                                    return favoritoB - favoritoA;
                                });

                                premiosContainer.innerHTML = '';
                                premios.forEach(premio => premiosContainer.appendChild(premio));
                            }




                        </script>
                        <div class="Der">
                            <img src="../img/Derecha.svg" class="flecha-derecha" onclick="moverDerecha()" style="cursor: pointer;">
                        </div>
                    </div>

                    <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    %>
                    <div class="mensaje-error">
                        <p>Error al acceder a la base de datos: <%= e.getMessage()%></p>
                    </div>
                    <%
                            } finally {
                                if (rs0 != null) try {
                                    rs0.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                if (pstmt6 != null) try {
                                    pstmt6.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                if (conn != null) try {
                                    bd.cierraConexion();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    %>
                </div>


                <div class = "contenedor-contenido-abajo">
                        <div class="container-wrapper" id="container-wrapper">
                        <div class = "div-container-table-scroll">
                            <table class="tabla">
                                <tr>
                                    <%                                        PreparedStatement pstmt7 = null;
                                        ResultSet rs = null;
                                        PreparedStatement pstmt8 = null;
                                        ResultSet rs2 = null;
                                        PreparedStatement pstmt9 = null;
                                        ResultSet rs3 = null;
                                      

                                        session = request.getSession(false);
                                        if (session != null && session.getAttribute("email") != null) {
                                            pstmt7 = null;
                                            rs = null;

                                            try {
                                            
                                                bd.conectar();

                                                String query = "SELECT * FROM Castor WHERE email = ?";
                                                pstmt7 = bd.getConn().prepareStatement(query);
                                                pstmt7.setString(1, email);
                                                rs = pstmt7.executeQuery();

                                                int idCastor = 0;

                                                if (rs.next()) {
                                                    idCastor = rs.getInt(1);
                                                }

                                                int cont = 0;

                                                boolean comprobar = false;
                                                session = request.getSession(false);
                                                if (session == null || session.getAttribute("idKit") == null) {
                                                    comprobar = true;
                                                } else {
                                                    comprobar = false;
                                                }
                                                if (comprobar) {
                                    %>
                                    <td>
                                        <div id="container-burbuja-img-text">
                                            <div class="img-text-container">
                                                <img src="../img/icono_Perfil.svg" alt="Imagen de iconito" class="icon-img">
                                            </div>
                                            <button class="button-overlay" onclick="toggleBurbujas()">
                                                <img src="../img/icono_cambio_hijo.svg" id="imgCambiarHijos">
                                            </button>
                                        </div>
                                    </td>
                                    <%
                                    } else {
                                        String idKitActualizado = (String) session.getAttribute("idKit");
                                        int idKitActualizadoInt = Integer.parseInt(idKitActualizado);

                                        String queryp = "SELECT * FROM Kit WHERE idKit = ?";
                                        PreparedStatement pstmtp = bd.getConn().prepareStatement(queryp);
                                        pstmtp.setInt(1, idKitActualizadoInt);
                                        ResultSet rsp = pstmtp.executeQuery();
                                        if (rsp.next()) {

                                    %>
                                    <td>
                                        <div id="container-burbuja-img-text">
                                            <form action="procesa_Kit.jsp" method="post" style="display: inline;" id="pruebapaber">
                                                <input type="text" id="idKit" name="idKit" style="display: none;" value="<%= rsp.getString(1)%>">
                                                <button type="submit" style="background: none; border: none; padding: 0; cursor: pointer; height: auto; height: auto; display: flex; align-content: center; align-items: center;">
                                                    <div class="img-text-container">
                                                        <img src="<%= rsp.getString(9)%>" alt="Imagen de iconito" class="icon-img">
                                                    </div>
                                                    <div class="span-text-container">
                                                        <span id="span-nombre-burbuja"><%= rsp.getString(4)%></span>
                                                    </div>
                                                </button>
                                            </form>
                                            <button class="button-overlay" onclick="toggleBurbujas()">
                                                <img src="../img/icono_cambio_hijo.svg" id="imgCambiarHijos">
                                            </button>
                                        </div>
                                    </td>
                                    <%
                                            }
                                        }

                                        if (idCastor > 0) {

                                            String query2 = "SELECT * FROM relKitCastor WHERE idCastor = ?";
                                            pstmt8 = bd.getConn().prepareStatement(query2);
                                            pstmt8.setInt(1, idCastor);
                                            rs2 = pstmt8.executeQuery();

                                            while (rs2.next()) {
                                                cont++;

                                                int idKitInt = rs2.getInt(3);
                                                String idKitString = String.valueOf(idKitInt);

                                                String query3 = "SELECT * FROM Kit WHERE idKit = ?";
                                                pstmt9 = bd.getConn().prepareStatement(query3);
                                                pstmt9.setInt(1, idKitInt);
                                                rs3 = pstmt9.executeQuery();

                                                session = request.getSession(false);
                                                if (!idKitString.equals(session.getAttribute("idKit"))) {

                                                    if (rs3.next()) {

                                    %>
                                    <td id = "td-burbujas-escondidas">
                                        <form action="procesa_Kit.jsp" method="post" style="display: inline;" id="pruebapaber2">
                                            <input type="text" id="idKit" name="idKit" value="<%= rs3.getString(1)%>" style="display: none;">
                                            <button type="submit" class="icon-button" style="background: none; border: none; padding: 0; cursor: pointer; display: flex; align-items: center;">
                                                <div class="img-text-container">
                                                    <img src="<%= rs3.getString(9)%>" alt="Imagen de iconito" class="icon-img">
                                                </div>
                                                <div class="span-text-container">
                                                    <span id="span-nombre-burbuja"><%= rs3.getString(4)%></span>
                                                </div>
                                            </button>
                                        </form>
                                    </td>
                                    <%
                                                }

                                            }
                                        }
                                    %>
                                    <td id = "td-burbujas-escondidas">
                                        <div class="burbujas-escondidas" style="display: none;">
                                            <div class="act_tit" id="hijoadd-div">
                                                <div class="contenedor-button-add-actividad">
                                                    <%
                                                        String codPresaMandar = "hola";
                                                        String emailModal = "email";
                                                        session = request.getSession(false);
                                                        if (session != null && session.getAttribute("email") != null) {
                                                            emailModal = (String) session.getAttribute("email");
                                                        }
                                                        Base bdModalFormu = new Base();
                                                        try {
                                                            bdModalFormu.conectar();
                                                            String sqlModal = "SELECT * FROM Castor WHERE email = ?";

                                                            PreparedStatement psConectionModal = bdModalFormu.getConn().prepareStatement(sqlModal);
                                                            psConectionModal.setString(1, emailModal);
                                                            ResultSet rsModal = psConectionModal.executeQuery();
                                                            if (rsModal.next()) {
                                                                codPresaMandar = rsModal.getString(2);
                                                            }
                                                        } catch (SQLException e) {
                                                            e.printStackTrace();
                                                        }
                                                    %>
                                                    <a style="text-decoration: none;" href="../formularios_sesion/registro_hijo.jsp?returnUrl=<%= request.getRequestURL()%>&codPresa=<%= codPresaMandar != null ? codPresaMandar : ""%>">  
                                                        <button class="agregarHijo" id="agregarHijo"><img src="../img/icon_add.svg"/></button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <%
                                                    rs2.close(); 
                                                    pstmt8.close();
                                                    rs3.close(); 
                                                    pstmt7.close(); 
                                                }

                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                if (rs != null) try {
                                                    rs.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                if (pstmt7 != null) try {
                                                    pstmt7.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                if (rs2 != null) try {
                                                    rs2.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                if (pstmt8 != null) try {
                                                    pstmt8.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                if (rs3 != null) try {
                                                    rs3.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                                if (pstmt9 != null) try {
                                                    pstmt9.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        }
                                    %>

                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="act_tit">
                        <div class="contenedor-button-add-actividad">
                            <button class="crearAct_Btn" id="crearActBtn"><img src="../img/icon_add.svg"/></button>
                        </div>
                    </div>

                    <script>
                        const button = document.getElementById('crearActBtn');

                        <% if (idKit == null) { %>
                        button.disabled = true;
                        button.style.display = "none";
                        <% } else { %>
                        button.disabled = false;
                        <% } %>
                    </script>



                </div>
                <%
                    session = request.getSession(false);
                    if (session != null && session.getAttribute("email") != null) {

                        PreparedStatement pstmt1 = null;
                        PreparedStatement pstmt2 = null;
                        rs = null;
                        rs2 = null;

                        try {
                            bd.conectar();

                            String query = "SELECT * FROM Castor WHERE email = ?";
                            pstmt1 = bd.getConn().prepareStatement(query);
                            pstmt1.setString(1, email);
                            rs = pstmt1.executeQuery();

                            int idCastor = 0; 

                            if (rs.next()) {
                                idCastor = rs.getInt(1); 
                                session.setAttribute("idCastor",idCastor);
                            }

                            if (idCastor > 0) {
                                String query2 = "SELECT * FROM relKitCastor WHERE idCastor = ?";
                                pstmt2 = bd.getConn().prepareStatement(query2);
                                pstmt2.setInt(1, idCastor); 
                                rs2 = pstmt2.executeQuery();

                                int count = 0;

                                while (rs2.next()) {
                                    count += 1;
                                }

                                if (count == 0) {
                %>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        document.getElementById("noChildModal").style.display = "block"; 
                        document.getElementById("noChildModal").style.display = "flex";
                    });
                </script>
                <%
                } else {
                %>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        document.getElementById("noChildModal").style.display = "none"; 
                    });
                </script>
                <%
                                }
                            }

                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                        }
                    } else {
                    }
                %>


                <!-- Modal -->
                <div id="modalCrearActividad" class="modal-crear-actividad">
                    <div class="modal-content-crear-actividad">
                        <form action="formulario_procesa_recompensas_tutor.jsp" method="post" id="formulario-nuevo-habito">
                          <input id="idActividadEditarActividad" name="idActividadEditarActividad" type="hidden">
                            <div class="modal-titulo">
                                <p id="p-nuevo-habito-tit">Nuevo Premio</p>
                            </div>
                            <div class="modal-separacion1">
                                <div class="input-nombre-habito-container">
                                    <div class="juntador">
                                        <div class="flea">
                                            <span class="texto-input-nuevo-habito">Nombre del premio</span>
                                            <input autocomplete="off"type="text" id="nombreHabito" name="nombreHabito" autocomplete="off" class="input-nuevo-habito" placeholder="Ingresa el nombre que llevará el premio" onfocus="showOptionsNombre()" oninput="filterOptionsNombre()">
                                            <div class="options-nombre" id="options-nombre">
                                                <div class="category-nombres">Recompensas de Juguetes</div>
                                                <div data-value="Coche de juguete" class="text-options-nombre-habito">Coche de juguete</div>
                                                <div data-value="Muñeca" class="text-options-nombre-habito">Muñeca</div>
                                                <div data-value="Pelota" class="text-options-nombre-habito">Pelota</div>
                                                <div data-value="Bloques de construcción" class="text-options-nombre-habito">Bloques de construcción</div>
                                                <div data-value="Set de LEGO" class="text-options-nombre-habito">Set de LEGO</div>
                                                <div data-value="Robot de juguete" class="text-options-nombre-habito">Robot de juguete</div>
                                                <div data-value="Drone para niños" class="text-options-nombre-habito">Drone para niños</div>
                                                <div data-value="Camión de bomberos" class="text-options-nombre-habito">Camión de bomberos</div>
                                                <div data-value="Juegos de mesa (ej. Monopoly, Uno)" class="text-options-nombre-habito">Juegos de mesa (ej. Monopoly, Uno)</div>
                                                <div data-value="Puzzles y rompecabezas" class="text-options-nombre-habito">Puzzles y rompecabezas</div>
                                                <div data-value="Kits de ciencia o experimentos" class="text-options-nombre-habito">Kits de ciencia o experimentos</div>
                                                <div data-value="Figuras de acción (ej. superhéroes)" class="text-options-nombre-habito">Figuras de acción (ej. superhéroes)</div>

                                                <div class="category-nombres">Recompensas de Tiempo</div>
                                                <div data-value="15 minutos adicionales de TV" class="text-options-nombre-habito">15 minutos adicionales de TV</div>
                                                <div data-value="30 minutos de videojuego" class="text-options-nombre-habito">30 minutos de videojuego</div>
                                                <div data-value="Hora de dormir extendida" class="text-options-nombre-habito">Hora de dormir extendida</div>
                                                <div data-value="30 minutos de parque" class="text-options-nombre-habito">30 minutos de parque</div>
                                                <div data-value="Una tarde en casa de amigos" class="text-options-nombre-habito">Una tarde en casa de amigos</div>
                                                <div data-value="Día libre de tareas escolares" class="text-options-nombre-habito">Día libre de tareas escolares</div>
                                                <div data-value="Una noche de películas con palomitas" class="text-options-nombre-habito">Una noche de películas con palomitas</div>
                                                <div data-value="Sesión de lectura extra" class="text-options-nombre-habito">Sesión de lectura extra</div>
                                                <div data-value="Día sin reglas de casa" class="text-options-nombre-habito">Día sin reglas de casa</div>
                                                <div data-value="Tarde de juegos de mesa en familia" class="text-options-nombre-habito">Tarde de juegos de mesa en familia</div>
                                                <div data-value="Tiempo de relajación en la bañera" class="text-options-nombre-habito">Tiempo de relajación en la bañera</div>

                                                <div class="category-nombres">Recompensas de Comida</div>
                                                <div data-value="Helado" class="text-options-nombre-habito">Helado</div>
                                                <div data-value="Pizza" class="text-options-nombre-habito">Pizza</div>
                                                <div data-value="Chocolates" class="text-options-nombre-habito">Chocolates</div>
                                                <div data-value="Palomitas de maíz" class="text-options-nombre-habito">Palomitas de maíz</div>
                                                <div data-value="Cena en tu restaurante favorito" class="text-options-nombre-habito">Cena en tu restaurante favorito</div>
                                                <div data-value="Tarta de cumpleaños extra" class="text-options-nombre-habito">Tarta de cumpleaños extra</div>
                                                <div data-value="Galletas caseras" class="text-options-nombre-habito">Galletas caseras</div>
                                                <div data-value="Una caja de dulces sorpresa" class="text-options-nombre-habito">Una caja de dulces sorpresa</div>
                                                <div data-value="Batidos de frutas" class="text-options-nombre-habito">Batidos de frutas</div>
                                                <div data-value="Desayuno en la cama" class="text-options-nombre-habito">Desayuno en la cama</div>

                                                <div class="category-nombres">Recompensas Especiales</div>
                                                <div data-value="Salir al cine" class="text-options-nombre-habito">Salir al cine</div>
                                                <div data-value="Paseo a la playa" class="text-options-nombre-habito">Paseo a la playa</div>
                                                <div data-value="Día en el zoológico" class="text-options-nombre-habito">Día en el zoológico</div>
                                                <div data-value="Visita al parque de diversiones" class="text-options-nombre-habito">Visita al parque de diversiones</div>
                                                <div data-value="Día de picnic" class="text-options-nombre-habito">Día de picnic</div>
                                                <div data-value="Día de compras" class="text-options-nombre-habito">Día de compras</div>
                                                <div data-value="Concierto de tu banda favorita" class="text-options-nombre-habito">Concierto de tu banda favorita</div>
                                                <div data-value="Excursión al museo" class="text-options-nombre-habito">Excursión al museo</div>
                                                <div data-value="Viaje de fin de semana a una ciudad cercana" class="text-options-nombre-habito">Viaje de fin de semana a una ciudad cercana</div>
                                                <div data-value="Día de spa en casa" class="text-options-nombre-habito">Día de spa en casa</div>
                                                <div data-value="Visita a una granja o reserva natural" class="text-options-nombre-habito">Visita a una granja o reserva natural</div>

                                                <div class="category-nombres">Recompensas de Tecnología</div>
                                                <div data-value="Nueva tablet o e-reader" class="text-options-nombre-habito">Nueva tablet o e-reader</div>
                                                <div data-value="Auriculares inalámbricos" class="text-options-nombre-habito">Auriculares inalámbricos</div>
                                                <div data-value="Juego de video nuevo" class="text-options-nombre-habito">Juego de video nuevo</div>
                                                <div data-value="Accesorios para la consola de videojuegos" class="text-options-nombre-habito">Accesorios para la consola de videojuegos</div>
                                                <div data-value="Cámara instantánea" class="text-options-nombre-habito">Cámara instantánea</div>
                                                <div data-value="Suscripción a un servicio de streaming" class="text-options-nombre-habito">Suscripción a un servicio de streaming</div>
                                                <div data-value="Reloj inteligente" class="text-options-nombre-habito">Reloj inteligente</div>
                                                <div data-value="Laptop nueva" class="text-options-nombre-habito">Laptop nueva</div>
                                                <div data-value="Altavoz Bluetooth" class="text-options-nombre-habito">Altavoz Bluetooth</div>

                                                <div class="category-nombres">Recompensas de Entretenimiento</div>
                                                <div data-value="Entradas para un espectáculo" class="text-options-nombre-habito">Entradas para un espectáculo</div>
                                                <div data-value="Suscripción a una revista" class="text-options-nombre-habito">Suscripción a una revista</div>
                                                <div data-value="Curso en línea de un tema de interés" class="text-options-nombre-habito">Curso en línea de un tema de interés</div>
                                                <div data-value="Pase anual a un parque temático" class="text-options-nombre-habito">Pase anual a un parque temático</div>
                                                <div data-value="Tarjeta de regalo para una tienda de entretenimiento" class="text-options-nombre-habito">Tarjeta de regalo para una tienda de entretenimiento</div>
                                                <div data-value="Día de karaoke con amigos" class="text-options-nombre-habito">Día de karaoke con amigos</div>
                                                <div data-value="Taller de arte o manualidades" class="text-options-nombre-habito">Taller de arte o manualidades</div>
                                                <div data-value="Clases de cocina" class="text-options-nombre-habito">Clases de cocina</div>
                                                <div data-value="Participación en una escape room" class="text-options-nombre-habito">Participación en una escape room</div>
                                                <div data-value="Festival de música" class="text-options-nombre-habito">Festival de música</div>

                                                <div class="category-nombres">Recompensas de Deporte</div>
                                                <div data-value="Equipo deportivo nuevo (ej. bicicleta, patines)" class="text-options-nombre-habito">Equipo deportivo nuevo (ej. bicicleta, patines)</div>
                                                <div data-value="Entradas para un evento deportivo" class="text-options-nombre-habito">Entradas para un evento deportivo</div>
                                                <div data-value="Clase de deportes (ej. natación, fútbol)" class="text-options-nombre-habito">Clase de deportes (ej. natación, fútbol)</div>
                                                <div data-value="Pase para un gimnasio" class="text-options-nombre-habito">Pase para un gimnasio</div>
                                                <div data-value="Ropa deportiva nueva" class="text-options-nombre-habito">Ropa deportiva nueva</div>
                                                <div data-value="Accesorios para practicar un deporte (ej. balón, raqueta)" class="text-options-nombre-habito">Accesorios para practicar un deporte (ej. balón, raqueta)</div>
                                                <div data-value="Un día en un parque de aventuras" class="text-options-nombre-habito">Un día en un parque de aventuras</div>
                                                <div data-value="Día de senderismo en la naturaleza" class="text-options-nombre-habito">Día de senderismo en la naturaleza</div>

                                                <div class="category-nombres">Recompensas de Educación</div>
                                                <div data-value="Herramientas para el aprendizaje (ej. calculadora, diccionario)" class="text-options-nombre-habito">Herramientas para el aprendizaje (ej. calculadora, diccionario)</div>
                                                <div data-value="Clases de música o arte" class="text-options-nombre-habito">Clases de música o arte</div>
                                                <div data-value="Visitas a bibliotecas o centros culturales" class="text-options-nombre-habito">Visitas a bibliotecas o centros culturales</div>
                                                <div data-value="Material de arte (pinturas, lápices, etc.)" class="text-options-nombre-habito">Material de arte (pinturas, lápices, etc.)</div>

                                                <div class="category-nombres">Recompensas de Aventura</div>
                                                <div data-value="Día de camping" class="text-options-nombre-habito">Día de camping</div>
                                                <div data-value="Escalada en roca" class="text-options-nombre-habito">Escalada en roca</div>
                                                <div data-value="Paseo en kayak o canoa" class="text-options-nombre-habito">Paseo en kayak o canoa</div>
                                                <div data-value="Safari en un parque nacional" class="text-options-nombre-habito">Safari en un parque nacional</div>
                                                <div data-value="Exploración de cuevas" class="text-options-nombre-habito">Exploración de cuevas</div>
                                                <div data-value="Día de rafting" class="text-options-nombre-habito">Día de rafting</div>
                                                <div data-value="Tirolesa en un parque de aventura" class="text-options-nombre-habito">Tirolesa en un parque de aventura</div>
                                                <div data-value="Un viaje en globo aerostático" class="text-options-nombre-habito">Un viaje en globo aerostático</div>
                                                <div data-value="Clases de supervivencia al aire libre" class="text-options-nombre-habito">Clases de supervivencia al aire libre</div>

                                                <div class="category-nombres">Recompensas de Creatividad</div>
                                                <div data-value="Taller de fotografía" class="text-options-nombre-habito">Taller de fotografía</div>
                                                <div data-value="Clases de pintura o escultura" class="text-options-nombre-habito">Clases de pintura o escultura</div>
                                                <div data-value="Material de escritura (ej. cuadernos, plumas)" class="text-options-nombre-habito">Material de escritura (ej. cuadernos, plumas)</div>
                                                <div data-value="Accesorios para música (ej. guitarra, teclado)" class="text-options-nombre-habito">Accesorios para música (ej. guitarra, teclado)</div>
                                                <div data-value="Curso de diseño gráfico" class="text-options-nombre-habito">Curso de diseño gráfico</div>
                                                <div data-value="Kit de jardinería" class="text-options-nombre-habito">Kit de jardinería</div>
                                                <div data-value="Participación en un club de arte" class="text-options-nombre-habito">Participación en un club de arte</div>
                                                <div data-value="Materiales para hacer joyas" class="text-options-nombre-habito">Materiales para hacer joyas</div>
                                                <div data-value="Experiencias de improvisación teatral" class="text-options-nombre-habito">Experiencias de improvisación teatral</div>
                                            </div>

                                            <span id="nombreHabitoError" class="error-form-nuevo-habito">El nombre debe ser sin números y de al menos 3 caracteres</span>
                                        </div>
                                        <div class="input-icono-habito-container">
                                            <div class="icon-picker">
                                                <div id="iconDisplay" class="icon-display">
                                                    <img id="selectedIcon" src="../img/iconos_formularios/icono_selector_iconos.svg" alt="Ícono seleccionado">
                                                </div>
                                            </div>

                                            <!-- Input oculto para almacenar el src del icono seleccionado -->
                                            <input autocomplete="off"type="hidden" autocomplete="off" id="iconSrcInput" name="iconSrc" value="">

                                            <!-- Tabla para los íconos -->
                                            <div id="iconOptions" class="icon-options" style="display: none;"> <!-- Esconde por defecto -->
                                                <table>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/coche_juguete.svg" class="icon-option" data-icon="coche_juguete"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/muneca.svg" class="icon-option" data-icon="muneca"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/pelota.svg" class="icon-option" data-icon="pelota"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/bloques_construccion.svg" class="icon-option" data-icon="bloques_construccion"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Lego.svg" class="icon-option" data-icon="Lego"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Robot.svg" class="icon-option" data-icon="Robot"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Dron.svg" class="icon-option" data-icon="Dron"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Bomberos.svg" class="icon-option" data-icon="Bomberos"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Juegos_de_mesa.svg" class="icon-option" data-icon="Juegos_de_mesa"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Puzzle.svg" class="icon-option" data-icon="Puzzle"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Ciencia.svg" class="icon-option" data-icon="Ciencia"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Heroe.svg" class="icon-option" data-icon="Heroe"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/TV.svg" class="icon-option" data-icon="TV"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/VideoJuego.svg" class="icon-option" data-icon="VideoJuego"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Dormir.svg" class="icon-option" data-icon="Dormir"></td>
                                                    </tr>

                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Parque.svg" class="icon-option" data-icon="Parque"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Amigos.svg" class="icon-option" data-icon="Amigos"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Tareas.svg" class="icon-option" data-icon="Tareas"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Pelicula.svg" class="icon-option" data-icon="Pelicula"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Libro.svg" class="icon-option" data-icon="Libro"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/No_Reglas.svg" class="icon-option" data-icon="No_Reglas"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Juegos_Familia.svg" class="icon-option" data-icon="Juegos_Familia"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/banera.svg" class="icon-option" data-icon="banera"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Helado.svg" class="icon-option" data-icon="Helado"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Pizza.svg" class="icon-option" data-icon="Pizza"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Chocolate.svg" class="icon-option" data-icon="Chocolate"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Palomitas.svg" class="icon-option" data-icon="Palomitas"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Restaurante.svg" class="icon-option" data-icon="Restaurante"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Pastel_cumpleaños.svg" class="icon-option" data-icon="Pastel_cumpleaños"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Galleta.svg" class="icon-option" data-icon="Galleta"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Dulces.svg" class="icon-option" data-icon="Dulces"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Batido_Frutas.svg" class="icon-option" data-icon="Batido_Frutas"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Desayuno_Cama.svg" class="icon-option" data-icon="Desayuno_Cama"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Cine.svg" class="icon-option" data-icon="Cine"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Playa.svg" class="icon-option" data-icon="Playa"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Zoo.svg" class="icon-option" data-icon="Zoo"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Parque_Diversiones.svg" class="icon-option" data-icon="Parque_Diversiones"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Picnic.svg" class="icon-option" data-icon="Picnic"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Compras.svg" class="icon-option" data-icon="Compras"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Concierto.svg" class="icon-option" data-icon="Concierto"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Museo.svg" class="icon-option" data-icon="Museo"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Viaje_Ciudad.svg" class="icon-option" data-icon="Viaje_Ciudad"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Spa.svg" class="icon-option" data-icon="Spa"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Granja.svg" class="icon-option" data-icon="Granja"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Tablet.svg" class="icon-option" data-icon="Tablet"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Auriculares.svg" class="icon-option" data-icon="Auriculares"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Video_Nuevo.svg" class="icon-option" data-icon="Video_Nuevo"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Accesorios.svg" class="icon-option" data-icon="Accesorios"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Camara.svg" class="icon-option" data-icon="Camara"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Streaming.svg" class="icon-option" data-icon="Streaming"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Reloj.svg" class="icon-option" data-icon="Reloj"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Laptop.svg" class="icon-option" data-icon="Laptop"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Altavoz.svg" class="icon-option" data-icon="Altavoz"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Entradas.svg" class="icon-option" data-icon="Entradas"></td>
                                                    </tr>

                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Revista.svg" class="icon-option" data-icon="Revista"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Curso_Linea.svg" class="icon-option" data-icon="Curso_Linea"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Pase_Anual.svg" class="icon-option" data-icon="Pase_Anual"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Tarjeta.svg" class="icon-option" data-icon="Tarjeta"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Karaoke.svg" class="icon-option" data-icon="Karaoke"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Manualidades.svg" class="icon-option" data-icon="Manualidades"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Cocina.svg" class="icon-option" data-icon="Cocina"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/EscapeRoom.svg" class="icon-option" data-icon="EscapeRoom"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Musica.svg" class="icon-option" data-icon="Musica"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Equipo_Deportivo.svg" class="icon-option" data-icon="Equipo_Deportivo"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Entradas_Estadio.svg" class="icon-option" data-icon="Entradas_Estadio"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Clases_Deporte.svg" class="icon-option" data-icon="Clases_Deporte"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Gym.svg" class="icon-option" data-icon="Gym"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Ropa_Deportiva.svg" class="icon-option" data-icon="Ropa_Deportiva"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Accesorios_Deporte.svg" class="icon-option" data-icon="Accesorios_Deporte"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Parque_Aventuras.svg" class="icon-option" data-icon="Parque_Aventuras"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Senderismo.svg" class="icon-option" data-icon="Senderismo"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Calculadora.svg" class="icon-option" data-icon="Calculadora"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Clases_Musica.svg" class="icon-option" data-icon="Clases_Musica"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Biblioteca_1.svg" class="icon-option" data-icon="Biblioteca_1"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Arte.svg" class="icon-option" data-icon="Arte"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Camping.svg" class="icon-option" data-icon="Camping"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Escalada.svg" class="icon-option" data-icon="Escalada"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Kayak.svg" class="icon-option" data-icon="Kayak"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Safari.svg" class="icon-option" data-icon="Safari"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Cuevas.svg" class="icon-option" data-icon="Cuevas"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Rafting.svg" class="icon-option" data-icon="Rafting"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Tirolesa.svg" class="icon-option" data-icon="Tirolesa"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Globo_Aerostatico.svg" class="icon-option" data-icon="Globo_Aerostatico"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Supervivencia.svg" class="icon-option" data-icon="Supervivencia"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Fotografia.svg" class="icon-option" data-icon="Fotografia"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/escultura.svg" class="icon-option" data-icon="escultura"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Escritura.svg" class="icon-option" data-icon="Escritura"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Guitarra.svg" class="icon-option" data-icon="Guitarra"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Diseño_Grafico.svg" class="icon-option" data-icon="Diseño_Grafico"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Jardineria.svg" class="icon-option" data-icon="Jardineria"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Club.svg" class="icon-option" data-icon="Club"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Joyas.svg" class="icon-option" data-icon="Joyas"></td>
                                                        <td class="td-iconos-form-habito"><img src="../img/Iconos-recompensas/Teatral.svg" class="icon-option" data-icon="Teatral"></td>
                                                    </tr>


                                                </table>
                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="modal-separacion2">
                                <div class="spa1"><span class="texto-input-nuevo-habito">Nivel del premio</span></div>
                                <div class="spa2"><span class="texto-input-nuevo-habito">Categoría de Premio</span></div>
                                <div class="spa3"><span class="texto-input-nuevo-habito">Tipo de Premio</span></div>
                                <div class="spa4"><span class="texto-input-nuevo-habito">Costo de Premio</span></div>

                                <!-- Recompensa 1 (Nivel del premio) -->
                                <div class="input-tipo-container">
                                    <select id="opcionesNivel" autocomplete="off" name="opcionesNivel">
                                        <option value="" disabled selected>--Seleccione--</option>
                                        <option value="común">Común</option>
                                        <option value="raro">Raro</option>
                                        <option value="epico">Épico</option>
                                        <option value="legendario">Legendario</option>
                                    </select>
                                    <span id="erroropcionesNivel" class="error-form-nuevo-habito">Por favor, seleccione una opción.</span>
                                </div>

                                <!-- Categoría de Premio -->
                                <div class="input-tipo-container">
                                    <select id="opcionesCategoria" autocomplete="off" name="opcionesCategoria">
                                        <option value="" disabled selected>--Seleccione--</option>
                                        <option value="Juguetes">Juguetes</option>
                                        <option value="Tiempo">Tiempo</option>
                                        <option value="Comida">Comida</option>
                                        <option value="Especiales">Especiales</option>
                                        <option value="Tecnología">Tecnología</option>
                                        <option value="Entretenimiento">Entretenimiento</option>
                                        <option value="Deporte">Deporte</option>
                                        <option value="Educación">Educación</option>
                                        <option value="Aventura">Aventura</option>
                                        <option value="Creatividad">Creatividad</option>
                                        <option value="Viajes">Viajes</option>
                                    </select>
                                    <span id="errorTipoCategoria" class="error-form-nuevo-habito">Por favor, seleccione una opción.</span>
                                </div>

                                <!-- Tipo de Premio -->
                                <div class="input-tipo-container">
                                    <select id="opcionesTipo" autocomplete="off" name="opcionesTipo">
                                        <option value="" disabled selected>--Seleccione--</option>
                                        <option value="Salud">Salud</option>
                                        <option value="Productividad">Productividad</option>
                                        <option value="Personales">Personales</option>
                                        <option value="Sociales">Sociales</option>
                                        <option value="Financieros">Financieros</option>
                                        <option value="Emocionales">Emocionales</option>
                                        <option value="Mentales">Mentales</option>
                                        <option value="Aventuras">Aventuras</option>
                                        <option value="Habilidades">Habilidades</option>
                                        <option value="Recreación">Recreación</option>
                                        <option value="Tecnológicos">Tecnológicos</option>
                                        <option value="Educativos">Educativos</option>
                                        <option value="Familiares">Familiares</option>
                                        <option value="Amistosos">Amistosos</option>
                                        <option value="Experiencias">Experiencias</option>
                                    </select>
                                    <span id="errorTipo" class="error-form-nuevo-habito">Por favor, seleccione una opción.</span>
                                </div>

                                <!-- Costo de Premio -->
                                <div class="input-icon-number-container">
                                    <div class="input-wrapper">
                                        <input type="number"  autocomplete="off" style="background-image: url('../img/icono_ramita.svg'); /* Ruta de la imagen */
                                               background-repeat: no-repeat;
                                               background-position: left 1vw center; /* Ajustamos la posición de la imagen */
                                               background-size: 2.5vw 2.5vw;" id="recompensaActividad" name="recompensaActividad" placeholder="1" class="input-nuevo-habito">
                                    </div>
                                    <span id="errorRecompensa" class="error-form-nuevo-habito">Por favor, ingresa un número entre 1 y 1000.</span>
                                </div>
                            </div>

                            <div class="modal-separacion4">
                                <div><span class="texto-input-nuevo-habito">Información</span></div>
                                <div>

                                    <textarea type="text" name="infoExtra" autocomplete="off" id="info-extra" class="input-nuevo-habito" placeholder="Ingresa información extra que quieras compartir con tu Kit sobre el hábito nuevo. No olvides ser amable y apoyarlo siempre :)"></textarea>
                                    <div id="charCount">0/350 caracteres</div>
                                </div>

                                <span id="errorInfoExtra" class="error-form-nuevo-habito">Por favor, ingrese información extra.</span>
                            </div>

                            <div class="modal-separacion5">
                                <div class="modal-boton1">
                                    <button id="cerrarModalBtn" class="cerrar-modal-btn">Cerrar</button>
                                </div>
                                <div class="modal-boton2">
                                    <button type="submit" id="mandarFormsNuevaActividad">Crear</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Modal -->
                <!-- Modal -->
                <%            String codPresaMandar = "hola";
                    String emailModal = "email";
                    session = request.getSession(false);
                    if (session != null && session.getAttribute("email") != null) {
                        emailModal = (String) session.getAttribute("email");
                    }
                    Base bdModalFormu = new Base();
                    try {
                        bdModalFormu.conectar();
                        String sqlModal = "SELECT * FROM Castor WHERE email = ?";

                        PreparedStatement psConectionModal = bdModalFormu.getConn().prepareStatement(sqlModal);
                        psConectionModal.setString(1, emailModal);
                        ResultSet rsModal = psConectionModal.executeQuery();
                        if (rsModal.next()) {
                            codPresaMandar = rsModal.getString(2);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>

                <div id="noChildModal" class="modal">
                    <div class="modal-content">
                        <span style="
                              font-family: 'Dongle', sans-serif;
                              font-weight: 400;
                              font-style: normal;
                              font-size: 3.5rem;"
                              >Registro de Hijo (a)</span>

                        <br>

                        <span style="
                              font-family: 'Gayathri', system-ui;
                              font-weight: 700;
                              font-style: normal;
                              font-size: 1.2rem;"
                              >No tienes ningún hijo (a) registrado (a). Por favor, registra a tu hijo (a) para continuar.</span>
                        <div>
                            <img src="../img/perfil_niño_globo.svg" style="height: 15rem; width: 15rem;">
                        </div>
                        <div style="margin-top: 20px;">
                            <a style="text-decoration: none;" href="../formularios_sesion/registro_hijo.jsp?returnUrl=<%= request.getRequestURL()%>&codPresa=<%= codPresaMandar != null ? codPresaMandar : ""%>" class="button">
                                <button class="agregar-hijo-modal-button">
                                    Registrar Hijo
                                </button>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="toast-iconos" class="toast">
                    <span  class="toastMessage">Error: No puede mandar el fomulario sin seleccionar un ícono</span>
                </div>
                <div id="toast-premio-existente" class="toast" style="display: none;">
                    <span class="toastMessage">Error: Ya existe un premio con esos datos.</span>
                </div>

                <%
                    String error = (String) session.getAttribute("error");
                    if (error != null) {
                %>
                <script>
                    window.onload = function () {
                        showToastPremioExistente();  
                    };
                </script>
                <%
                        session.removeAttribute("error"); 
                    }
                %>
                <div id="modalPremio" class="modalPremio" style="display: none;">
                    <div class="modalPremioContent">         

                        <div class="imagePremiox">      
                            <div class="imag">
                                <img id="img-icono-premio-info" src="" class="image-prem" alt="Imagen del Premio">       
                            </div>
                            <div class="ramso">
                                <div class="costoso">
                                    <div style="background-color: #BA6958;  border-radius: 1rem;">
                                        <img src="../img/icono_ramita.svg">
                                    </div>
                                    <div class="ramsitas">
                                        <span id="ramitasPremioInfo"></span>  / <span id="costoPremioI"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="infodet">
                            <div class="infol">
                                <div class="nomP">
                                    <span  id="nombrePremioInfo"></span>
                                </div>
                                <div class="nomN">
                                    <span><b>Nivel</b> <span id="nivelPremioInfo"></span></span>
                                </div>
                                <div class="tipes">
                                    <div class="tip">
                                        <span><b>Categoría</b></span>
                                    </div>
                                    <div class="tip">
                                        <span><b>Tipo</b></span><br>
                                    </div>
                                    <div class="tipe">
                                        <span id="categoriaPremioInfo"> </span>
                                    </div>
                                    <div class="tipe">
                                        <span id="tipoPremioInfo"></span>
                                    </div>

                                </div>
                                <div class="estadosx">
                                    <div class="estatus">
                                        <span>Estatus</span>
                                    </div>
                                    <div class="est"> 
                                        <div><span id="estadoPremioInfo">  
                                                <img id="estadoPremioInfoImg" src="" alt="Estado Premio">
                                            </span></div>
                                        <div class="estados">
                                            <span><b>Canjeados</b></span>
                                        </div>
                                    </div>

                                    <div class="cost">
                                        <div class="costito">
                                            <div class="costo"><span id="costoPremioInfo"></span></div>
                                            <div class="rams"><img  src="../img/icono_ramita.svg"></div>
                                        </div>
                                    </div>

                                    <div class="est">
                                        <div>
                                            <span id="favoritoPremioInfo">                                 
                                                <img id="favoritoPremioInfoImg" src="" alt="Favorito Premio">
                                            </span>
                                        </div>
                                        <div class="estados">
                                            <span><b>Favoritos</b></span>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <div class="contenedor-info-modal-2">

                                <span class="close" onclick="cerrarModalPremio()">&times;</span>

                            </div>
                        </div>  
                        <div class="des">

                            <div>
                                <div class="desc"><span><b>Descripción</b></span> </div>
                                <div class="desce"><span id="infoExtraPremioInfo"></span></div>
                            </div>
                            <div class="premio-despleada-ramitas">
                                <span type="button" id="editarActividadBtn" data-id="" onclick="cerrarModalPremio();"><img src="../img/icono_editar_actividad.svg"> <u>Editar</u></span>
                            </div>
                        </div>
                        <span style="display:none;" id="nomPre"></span>
                        <span style="display:none;" id="rutaImagenP"></span>
                        <span style="display:none;" id="TipoP"></span>
                        <span style="display:none;" id="CatPre"></span>
                        <span style="display:none;" id="EstPre"></span>
                        <span style="display:none;" id="FavPre"></span>
                        <span style="display:none;" id="InfPre"></span>
                        <span style="display:none;" id="costoP"></span>
                        <span style="display:none;" id="nivPre"></span>
                        <span style="display:none;" id="idPrem"></span>
                             


                    </div>
                </div>
                




                <script src="../codigo_js/codigo_javascript_tutor/js_recompensas_tutor.js" type="text/javascript"></script>
              
                </body>
                </html>