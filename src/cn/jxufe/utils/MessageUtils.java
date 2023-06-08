package cn.jxufe.utils;

import cn.jxufe.bean.Message;

/**
 * MessageUtils类用于创建Message对象。
 */
public class MessageUtils {

    /**
     * 创建一个包含指定错误消息内容的错误消息。
     *
     * @param errorMessage 错误消息内容
     * @return 创建的错误消息
     */
    public static Message createErrorMessage(String errorMessage) {
        Message message = new Message();
        message.setCode(1);
        message.setMsg(errorMessage);
        return message;
    }

    /**
     * 创建一个包含指定成功消息内容的成功消息。
     *
     * @param successMessage 成功消息内容
     * @return 创建的成功消息
     */
    public static Message createSuccessMessage(String successMessage) {
        Message message = new Message();
        message.setCode(0);
        message.setMsg(successMessage);
        return message;
    }
}
