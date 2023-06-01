package cn.jxufe.servlet;

import cn.jxufe.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class FarmServlet extends HttpServlet {

    @Autowired
    private GameService gameService;

    @Override
    public void init() throws ServletException {
        super.init();
        WebApplicationContextUtils
                .getWebApplicationContext(getServletContext())
                .getAutowireCapableBeanFactory().autowireBean(this);
        System.out.println("/******************** 我的农场游戏服务开始启动 ***************************/");
        gameService.gameStart();
        System.out.println("/******************** 我的农场游戏服务启动完成 ***************************/");
    }
}
