package cn.jxufe.websocket;

import cn.jxufe.bean.GameConfig;
import cn.jxufe.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;

/**
 * FarmWebsocketHandler 类是处理 WebSocket 请求的处理程序。
 */
public class FarmWebsocketHandler extends TextWebSocketHandler {
    public static final ArrayList<WebSocketSession> sessions = new ArrayList<>();
    private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);

    /**
     * 处理收到的文本消息。
     *
     * @param session WebSocket 会话
     * @param message 接收到的文本消息
     * @throws Exception 处理异常
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        session.sendMessage(new TextMessage("服务器返回收到的消息，" + payload));
    }

    /**
     * 在连接建立后，将session添加到sessions中
     * 
     * @param session
     * @throws Exception
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        User user = (User) session.getHandshakeAttributes().get(GameConfig.__DEFAULT_USER_NAME_SESSION);
        logger.info("用户: " + user.getUsername() + "已连接");
    }

    /**
     * 连接关闭后，移除session
     * 
     * @param session 会话
     * @param status 状态
     * @throws Exception 异常
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        User user = (User) session.getHandshakeAttributes().get(GameConfig.__DEFAULT_USER_NAME_SESSION);
        logger.info("用户: " + user.getUsername() + "已断开连接" + "，状态码: " + status.getCode() + "，原因: " + status.getReason());
    }

    /**
     * 发生传输错误时，关闭连接，移除session
     * 
     * @param session 会话
     * @param exception 异常
     * @throws Exception 异常
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        User user = (User) session.getHandshakeAttributes().get(GameConfig.__DEFAULT_USER_NAME_SESSION);
        if (session.isOpen()) {
            session.close();
        }
        logger.error("用户: " + user.getUsername() + "连接出错，关闭连接");
        sessions.remove(session);
    }

    /**
     * 给所有在线用户发送消息
     * 
     * @param message 消息
     */
    public void sendMessageToAll(TextMessage message) {
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                try {
                    session.sendMessage(message);
                } catch (Exception e) {
                    logger.error("发送消息出错", e);
                }
            }
        }
    }

    /**
     * 给指定用户发送消息
     * 
     * @param username 需要发送消息的用户
     * @param message 消息
     */
    public void sendMessageToUser(String username, TextMessage message) {
        for (WebSocketSession session : sessions) {
            if (!session.isOpen()) {
                continue;
            }
            User user = (User) session.getHandshakeAttributes().get(GameConfig.__DEFAULT_USER_NAME_SESSION);
            if (user != null && user.getUsername().equals(username)) {
                try {
                    session.sendMessage(message);
                    logger.debug("发送消息给用户: " + username + "，消息内容: " + message.getPayload());
                } catch (Exception e) {
                    logger.error("发送消息出错", e);
                }
                break;
            }
        }
    }
}
