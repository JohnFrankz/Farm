package cn.jxufe.utils;

import cn.jxufe.bean.Message;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUtils {
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
