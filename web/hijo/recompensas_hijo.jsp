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
        <link href="../estilos_css/estilos_hijo/css_recompensas_hijo.css" rel="stylesheet" type="text/css"/>

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
String usuario = (String) session.getAttribute("usuario");

if (session == null || usuario == null) {
response.sendRedirect("../formularios_sesion/inicio_sesion_hijo.jsp");
return; 
}
        %>
        <nav class="sidebar">
            <div class="logo-section menu-item" id = "logoNavbar">
                <img src="../img/logo_letras_castorway.svg" alt="Logo" class="icon" id = "iconoNavLogo">
            </div>
            <div class="icon-section">
                <div class="menu-item">
                    <a href="home_hijo.jsp" class = "a_nav"> 
                        <img class="icon icon1" src="../img/icono_casita.svg">
                        <span class="textNav">Inicio</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="actividades_hijo.jsp" class = "a_nav">
                        <img class="icon icon1" src="../img/icono_actividades.svg">
                        <span class="textNav">Actividades</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="calendario_hijo.jsp">
                        <img class="icon icon1" src="../img/icono_calendario.svg">
                        <span class="textNav">Calendario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="diario_hijo.jsp">
                        <img class="icon icon1" src="../img/icono_diario.svg">
                        <span class="textNav">Diario</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a class="a_nav" href="chat_hijo.jsp">
                        <img class="icon icon1" src="../img/icono_chat.svg">
                        <span class="textNav">Chat</span>
                    </a>
                </div>
                <div class="menu-item" id = "div_nav_home">
                    <a href="recompensas_hijo.jsp" class="a_nav">
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
                         Base bd=new Base();
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
                     background-size: cover; position: relative; width: 100%; height: 100%; overflow-y: hidden;">

                    <div class="flechitas" id="reclamados">
                        <div class="Premio1">Premios Reclamados</div>
                        <div class="flechas-container">
                            <div class="fle" onclick="window.location.href = 'recompensas1_hijo.jsp';" style="cursor: pointer;">
                                <img src="../img/Izquierda.svg">
                            </div>
                            <div class="fle" onclick="window.location.href = 'recompensas1_hijo.jsp';" style="cursor: pointer;">
                                <img src="../img/Derecha.svg">
                            </div>    
                        </div>
                    </div>
                </div>


                <div class="recom">
                    <%
                        Base bd = new Base();
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        PreparedStatement pstmt6 = null;
                        ResultSet rs0 = null;
                        ResultSet rs = null;
                        String codPresa = "hola";
                String nombreUsuario = (String) session.getAttribute("usuario");
                        Base bdModalFormu = new Base();
                        try {
                            bdModalFormu.conectar();
                       
                            String sqlModal = "SELECT codPresa FROM Kit WHERE nombreUsuario = ?";
                            PreparedStatement psConectionModal = bdModalFormu.getConn().prepareStatement(sqlModal);
                            psConectionModal.setString(1,nombreUsuario);

                            ResultSet rsModal = psConectionModal.executeQuery();
                            if (rsModal.next()) {
                                codPresa = rsModal.getString("codPresa"); 

                                session.setAttribute("codPresa", codPresa); 
                            } else {
                               
                                codPresa = "no_encontrado";
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (bdModalFormu != null) {
                                    bdModalFormu.cierraConexion();
                                }
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        }

                        session = request.getSession(false); 
                        if (session != null) {
                            codPresa = (String) session.getAttribute("codPresa");
                        }

        
                        if (codPresa == null || nombreUsuario == null) {
                    %>
                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado">
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">Por favor, proporciona codPresa y nombre de usuario para continuar.</p>
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" style="height:14vw; width:auto;" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                    </div>
                    <%
                        } else {
                            try {
                                bd.conectar();
                                conn = bd.getConn();
                
                                String userQuery = "SELECT idKit FROM Kit WHERE codPresa = ? AND nombreUsuario = ?";
                                pstmt = conn.prepareStatement(userQuery);
                                pstmt.setString(1, codPresa);
                                pstmt.setString(2, nombreUsuario);
                                rs = pstmt.executeQuery();

                                String idKit = null;

                                if (rs.next()) {
                                    idKit = rs.getString("idKit");
                                }

                                if (idKit == null) {
                    %>
                    <div class="mensaje-sin-seleccion" id="div-conrainer-img-hijono-seleccionado">
                        <div id="div-conrainer-img-hijono-seleccionado-text">
                            <p id="text-hijo-no-seleccionado">No se encontró una cuenta de Kit para los datos proporcionados.</p>
                        </div>
                        <div id="div-conrainer-img-hijono-seleccionado-img">
                            <img src="../img/Castor.svg" style="height:14vw; width:auto;" alt="Seleccionar usuario" id="img-hijo-no-seleccionado">
                        </div>
                    </div>
                    <%
                                } else {
                                    String query = "SELECT DISTINCT p.* FROM premios p "
                                            + "JOIN relPrem rp ON p.idCastor = rp.idCastor "
                                            + "WHERE rp.idKit = ?";
                                    pstmt6 = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                    pstmt6.setInt(1, Integer.parseInt(idKit));
                                    rs0 = pstmt6.executeQuery();

                                    if (!rs0.next()) {
                    %>
                    <div class="mensaje-sin-premios">
                        <div>
                            <p class="no-premios">No hay premios disponibles para esta cuenta de Kit.</p>
                        </div>
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
                                              + "AND p.estadoPremio = 1 "
                                              + "ORDER BY p.Favorito DESC";

                                try (PreparedStatement pstmt12 = conn.prepareStatement(query5)) {
                                    pstmt12.setInt(1, Integer.parseInt(idKit)); 
                                    ResultSet rs12 = pstmt12.executeQuery();

                                    while (rs12.next()) {
                                        String nombrePremio = rs12.getString("nombrePremio");
                                        String nivelPremio = rs12.getString("nivelPremio");
                                        String categoriaPremio = rs12.getString("categoriaPremio");
                                        String tipoPremio = rs12.getString("tipoPremio");
                                        int costoPremio = rs12.getInt("costoPremio");
                                        String infoExtraPremio = rs12.getString("infoExtraPremio");
                                        String rutaImagenHabito = rs12.getString("rutaImagenHabito");
                                        int estadoPremio = rs12.getInt("estadoPremio");
                                        int favorito = rs12.getInt("Favorito");
                                        int ramitas = rs12.getInt("ramitas");

                                        String imagenEstado = (estadoPremio == 0) ? "../img/PremioSinReclamar.svg" : "../img/PremioReclamado.svg";
                                        String imagenFav = (favorito == 0) ? "../img/NoFavorito.svg" : "../img/Favorito.svg";
                            %>
                            <div 
                                class="premio"  
                                data-id="<%= rs12.getInt("idPremio") %>" 
                                data-nombre="<%= nombrePremio %>" 
                                data-nivel="<%= nivelPremio %>" 
                                data-categoria="<%= categoriaPremio %>" 
                                data-tipo="<%= tipoPremio %>" 
                                data-costo="<%= costoPremio %>" 
                                data-info="<%= infoExtraPremio %>" 
                                data-estado="<%= estadoPremio %>" 
                                data-favorito="<%= favorito %>"
                                data-ramitas="<%= ramitas %>">
                                <div class="Imal" style="cursor: pointer;" 
                                     onclick="mostrarModalPremio(event);"data-id="<%= rs12.getInt("idPremio") %>" 
                                     data-nombre="<%= nombrePremio %>" 
                                     data-nivel="<%= nivelPremio %>" 
                                     data-categoria="<%= categoriaPremio %>" 
                                     data-tipo="<%= tipoPremio %>" 
                                     data-costo="<%= costoPremio %>" 
                                     data-info="<%= infoExtraPremio %>" 
                                     data-estado="<%= estadoPremio %>" 
                                     data-favorito="<%= favorito %>"
                                     data-ramitas="<%= ramitas %>">
                                    <img src="<%= rutaImagenHabito %>" id="imgPremio">
                                </div>
                                <div class="Nomel">
                                    <p class="nomPremio"><%= nombrePremio %></p>
                                </div>
                                <div class="Sele">
                                    <img src="<%= imagenEstado %>" class="estadoImagen">
                                    <img src="<%= imagenFav %>" class="estadoPremio" style="cursor:pointer;" onclick="cambiarEstado(this, 'favorito');">
                                </div>
                            </div>
                            <%
                                  String idPremioParam = request.getParameter("idPremio");
                                  String favoritoParam = request.getParameter("favorito");

                                  if (idPremioParam != null && favoritoParam != null) {
                                      int premioId = Integer.parseInt(idPremioParam);
                                      int nuevoFavorito = Integer.parseInt(favoritoParam);
                                            

                                      String updateQuery = "UPDATE premios SET Favorito = ? WHERE idPremio = ?";
                                      try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                                          updateStmt.setInt(1, nuevoFavorito);
                                          updateStmt.setInt(2, premioId);
                                                
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
                        <div class="Der">
                            <img src="../img/Derecha.svg" class="flecha-derecha" onclick="moverDerecha()" style="cursor: pointer;">
                        </div>
                    </div>
                    <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                    %>
                    <div class="mensaje-error">
                        <p>Error al acceder a la base de datos: <%= e.getMessage()%></p>
                    </div>
                    <%
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (rs0 != null) try { rs0.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (pstmt6 != null) try { pstmt6.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (conn != null) try { bd.cierraConexion(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        }
                    %>
                </div>





                <script src="../codigo_js/codigo_javascript_hijo/js_recompensas_hijo.js" type="text/javascript"></script>
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
                                            function cambiarEstado(element, tipo) {
                                                var premioElement = element.closest('.premio');
                                                var imgFavorito = premioElement.querySelector('.estadoPremio');

                                                var favoritoActual = parseInt(premioElement.getAttribute('data-favorito'));
                                                var idPremio = premioElement.getAttribute('data-id');

                                                if (tipo === 'favorito') {
                                                    var nuevoFavorito = favoritoActual === 0 ? 1 : 0;
                                                    imgFavorito.src = nuevoFavorito === 1 ? "../img/Favorito.svg" : "../img/NoFavorito.svg";
                                                    premioElement.setAttribute('data-favorito', nuevoFavorito);

                                                    console.log(`Enviando favorito: idPremio=${idPremio}, favorito=${nuevoFavorito}`);

                                                    fetch('recompensas_hijo.jsp?idPremio=' + idPremio + '&favorito=' + nuevoFavorito)
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
                                                fetch('recompensas_hijo.jsp') 
                                                        .then(response => response.text())
                                                        .then(data => {
                                                            const contenedorPremios = document.querySelector('.prem');
                                                            contenedorPremios.innerHTML = '';
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

                                    <div class="cost" onclick="mostrarModalConfirmacion()" style="cursor: pointer;">
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
             <div id="modalConfirmacion" class="modalCon" style="display: none;">
                    <div class="modalContentCan">
                        <p class="seguro">¿Seguro que quieres reclamar el premio?</p>
                        <p class="nota">Nota: ¡No se puede regresar esta acción!</p>
                        <img src="../img/Castor.svg"  class="Castor_Confirmar">
                        <div class="botoneees">
                        <button onclick="confirmarCanje()" class="reclamar">Sí, reclamar</button>
                        <button onclick="cerrarModalConfirmacion1()" class="cancelar">Cancelar</button>
                        </div>
                    </div>
                </div>
                <script>
                    let premioActual = {};

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

                        
                        premioActual = {
                            idPremio,
                            costo,
                            ramitas,
                            estadoPremio 
                        };

                        document.getElementById('modalPremio').style.display = 'flex';
                    }

                    function mostrarModalConfirmacion() {
                        const ramitas = Number(premioActual.ramitas);
                        const costo = Number(premioActual.costo);
                        const estadoPremio = premioActual.estadoPremio;
                        if (ramitas >= costo && estadoPremio === '0') {
                            document.getElementById('modalConfirmacion').style.display = 'flex';
                        } else if (estadoPremio !== '0') {
                            showToastPremioCanjeado(); 
                        } else if (ramitas < costo) {
                            console.log(ramitas);
                            showToastNoSuficientesRamitas(); 
                        }
                    }

                    function showToastPremioCanjeado() {
                        var toast = document.getElementById("toast-premio-canjeado");
                        toast.style.display = "block";
                        setTimeout(function () {
                            toast.style.display = "none";
                        }, 3000);
                    }

                    function showToastNoSuficientesRamitas() {
                        var toast = document.getElementById("toast-no-suficientes-ramitas");
                        toast.style.display = "block"; 
                        setTimeout(function () {
                            toast.style.display = "none"; 
                        }, 3000);
                    }

       
                    function confirmarCanje() {
                        const {ramitas, costo, idPremio} = premioActual;
                        const nuevasRamitas = ramitas - costo;

                        document.getElementById('ramitasRestantes').value = nuevasRamitas;
                        document.getElementById('idPremio').value = idPremio;
                        document.getElementById('formularioCanje').submit();
                        
                        setTimeout(() => {
                        cerrarModalConfirmacion();
                        }, 500);

                    }

                    function cerrarModalConfirmacion() {
                        document.getElementById('modalConfirmacion').style.display = 'none';  
                        window.location.reload();     
                    }
                      function cerrarModalConfirmacion1() {
                        document.getElementById('modalConfirmacion').style.display = 'none';  
                           
                    }

               
                    function cerrarModalPremio() {
                        document.getElementById('modalPremio').style.display = 'none';

                    }

                </script>

                <form id="formularioCanje" method="post" action="recompensas1_hijo.jsp">
                    <input type="hidden" name="ramitasRestantes" id="ramitasRestantes">
                    <input type="hidden" name="idPremio" id="idPremio">
                </form>

                <%
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        int idKit = Integer.parseInt((String) session.getAttribute("idKit"));
                        int ramitasRestantes = Integer.parseInt(request.getParameter("ramitasRestantes"));
                        int idPremio = Integer.parseInt(request.getParameter("idPremio"));
                        
   

                        Base base = new Base();
                        base.conectar();

                        Connection conn1 = base.getConn();
                        PreparedStatement stmt1 = null;
                        PreparedStatement stmt2 = null;

                        try {
                            String sqlUpdateKit = "UPDATE Kit SET ramitas = ? WHERE idKit = ?";
                            stmt1 = conn1.prepareStatement(sqlUpdateKit);
                            stmt1.setInt(1, ramitasRestantes);
                            stmt1.setInt(2, idKit);
                            int filasKit = stmt1.executeUpdate();

                            String sqlUpdatePremio = "UPDATE premios SET estadoPremio = 1 WHERE idPremio = ?";
                            stmt2 = conn1.prepareStatement(sqlUpdatePremio);
                            stmt2.setInt(1, idPremio);
                            int filasPremio = stmt2.executeUpdate();
                            
          
                        } catch (SQLException e) {
            
                        } finally {
                            try {
                                if (stmt1 != null) stmt1.close();
                                if (stmt2 != null) stmt2.close();
                                if (conn1 != null) conn1.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
                <div id="toast-premio-canjeado" class="toast" style="display: none;">
                    <span class="toastMessage">Error: Este premio ya ha sido canjeado.</span>
                </div>

                <div id="toast-no-suficientes-ramitas" class="toast" style="display: none;">
                    <span class="toastMessage">Error: No tienes suficientes ramitas para canjear este premio.</span>
                </div>


                </body>
                </html>