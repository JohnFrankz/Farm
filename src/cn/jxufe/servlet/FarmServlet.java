package cn.jxufe.servlet;

import cn.jxufe.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * FarmServlet 是一个 HttpServlet，用于启动农场游戏服务。
 */
public class FarmServlet extends HttpServlet {

    @Autowired
    private GameService gameService;

    /**
     * 初始化方法，在Servlet启动时调用。
     *
     * @throws ServletException Servlet异常
     */
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
