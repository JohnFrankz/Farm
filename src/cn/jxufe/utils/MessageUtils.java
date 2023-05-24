package cn.jxufe.utils;

import cn.jxufe.bean.Message;

public class MessageUtils {
    public static Message createErrorMessage(String errorMessage) {
        Message message = new Message();
        message.setCode(1);
        message.setMsg(errorMessage);
        return message;
    }

    public static Message createSuccessMessage(String successMessage) {
        Message message = new Message();
        message.setCode(0);
        message.setMsg(successMessage);
        return message;
    }
}
