package cn.jxufe.utils;

public class DataUtils {
    public static int ParseInt(String string) {
        try {
            return Integer.parseInt(string);
        } catch (NumberFormatException e) {
            System.out.println(string + "数据格式错误, 无法转换为数字.");
        }
        return Integer.MIN_VALUE;
    }
}
