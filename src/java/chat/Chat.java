package chat;

import conexion.Base;
import java.io.IOException;
import com.google.gson.*;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.sql.*;
import java.util.*;

@ServerEndpoint("/chat")
public class Chat {

    private Base base = new Base();
    private static Map<Integer, Session> sesionesUsuarios = new HashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("Conexión abierta: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Mensaje recibido: " + message);

        try {
            JsonParser parser = new JsonParser();
            JsonObject jsonMessage = parser.parse(message).getAsJsonObject();

            int idCastor = Integer.parseInt(jsonMessage.get("idCastor").getAsString());
            int idKit = Integer.parseInt(jsonMessage.get("idKit").getAsString());
            String emisor = jsonMessage.get("emisor").getAsString();
            String txtMsj = jsonMessage.get("txtMsj").getAsString();

            int idEmisor = 0;
            int idDestinatario = 0;

            if ("Tutor".equalsIgnoreCase(emisor)) {
                idEmisor = idCastor;
                idDestinatario = idKit;
            } else if ("Kit".equalsIgnoreCase(emisor)) {
                idEmisor = idKit;
                idDestinatario = idCastor;
            }
            guardarMensajeEnBD(idCastor,idKit, txtMsj, emisor);
            sesionesUsuarios.put(idEmisor, session);

            Session destinatarioSession = sesionesUsuarios.get(idDestinatario);

            if (destinatarioSession != null) {
                JsonObject responseMessage = new JsonObject();
                responseMessage.addProperty("emisor", emisor);
                responseMessage.addProperty("txtMsj", txtMsj);
                destinatarioSession.getBasicRemote().sendText(responseMessage.toString());
                session.getBasicRemote().sendText(responseMessage.toString());

                System.out.println("Mensaje enviado al destinatario con id: " + idDestinatario);
            } else {
                System.out.println("El destinatario no está conectado.");
            }
        } catch (Exception e) {
            System.err.println("Error al manejar el mensaje: " + e.getMessage());
        }
    }

    private void guardarMensajeEnBD(int idCastor, int idKit, String txtMsj, String emisor) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            base.conectar();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        try {
            conn = base.getConn();
            String query = "INSERT INTO chat (idKit, idCastor, contenido, emisor, fechaEnvio) VALUES (?, ?, ?, ?, NOW())";
            stmt = conn.prepareStatement(query);

            stmt.setInt(1, idKit);
            stmt.setInt(2, idCastor);
            stmt.setString(3, txtMsj);
            stmt.setString(4, emisor);

            int filasInsertadas = stmt.executeUpdate();
            if (filasInsertadas > 0) {
                System.out.println("Mensaje guardado correctamente.");
            }
        } catch (SQLException e) {
            System.err.println("Error al guardar el mensaje en la base de datos: " + e.getMessage());
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("Conexión cerrada: " + session.getId());
    }

    private String extractJsonValue(String message, String key) {
        try {
            JsonParser parser = new JsonParser(); // Crear instancia de JsonParser
            JsonObject json = parser.parse(message).getAsJsonObject(); // Analizar el mensaje
            return json.has(key) ? json.get(key).getAsString() : null; // Devolver el valor
        } catch (Exception e) {
            System.err.println("Error al parsear JSON: " + e.getMessage());
            return null;
        }
    }

}
