package cn.jxufe.controller;

import cn.jxufe.bean.Message;
import cn.jxufe.utils.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * 处理文件操作相关的控制器
 */
@Controller
@RequestMapping("file")
public class FileController {

    @RequestMapping("avatarUpload")
    @ResponseBody
    public Message avatarUpload(MultipartFile file, HttpServletRequest request) throws IOException {
        return FileUtils.avatarUpload(file, request);
    }
}
