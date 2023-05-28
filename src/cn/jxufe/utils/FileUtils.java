package cn.jxufe.utils;

import cn.jxufe.bean.Message;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * 处理文件操作相关的工具类
 */
public class FileUtils {
    /**
     * 处理文件上传，如果上传成功返回message(0, "上传成功")，否则返回message(1, "上传失败")
     * @param file 上传的文件
     * @param request 请求对象
     * @return 上传结果
     * @throws IOException
     */
    public static Message avatarUpload(MultipartFile file, HttpServletRequest request) {
        Message message = new Message();
        if (file.isEmpty()) {
            message.setCode(-1);
            message.setMsg("文件为空");
            return message;
        }

        String realPath = request.getServletContext().getRealPath("/avatar/" + file.getOriginalFilename());
        try {
            file.transferTo(new File(realPath));
            message.setCode(0);
            message.setMsg("上传成功");
        } catch (IOException e) {
            message.setCode(-1);
            message.setMsg("上传失败");
        }
        return message;
    }
}
