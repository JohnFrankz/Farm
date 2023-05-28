package cn.jxufe.utils;

/**
 * 用于数据转换的工具类
 */
public class DataUtils {
    /**
     * 将字符串转换为整数
     * @param string 字符串
     * @return 返回整数
     */
    public static int ParseInt(String string) {
        try {
            return Integer.parseInt(string);
        } catch (NumberFormatException e) {
            System.out.println(string + "数据格式错误, 无法转换为数字.");
        }
        return Integer.MIN_VALUE;
    }
}
