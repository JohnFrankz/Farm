package cn.jxufe.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jxufe.bean.GameConfig;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.FarmLandStatus;
import cn.jxufe.entity.User;
import cn.jxufe.service.GameService;
import cn.jxufe.service.UserBagService;
import cn.jxufe.service.UserService;

/**
 * 处理农场相关操作的控制器
 */
@Controller
@RequestMapping("/game")
public class GameController {

    @Autowired
    private GameService gameService;
    @Autowired
    private UserBagService userBagService;
    @Autowired
    private UserService userService;

    /**
     * 跳转到游戏页面
     * 
     * @return 游戏页面对应的视图
     */
    @RequestMapping("/index")
    public String index() {
        return "cropsGrow/grid";
    }

    /**
     * 获取某一用户的土地状态
     * 
     * @param session 当前用户会话
     * @return 土地状态列表
     */
    @RequestMapping("/landStatus")
    @ResponseBody
    public List<FarmLandStatus> getLandStatus(HttpSession session) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        System.out.println("currUser = " + currUser);
        return gameService.getLandStatus(currUser.getUsername());
    }
    

    /**
     * 清除枯草
     * 
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @return 清除结果
     */
    @RequestMapping("/cleanDeadLeaves")
    @ResponseBody
    public Message cleanWeed(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        Message message = gameService.cleanDeadLeaves(currUser.getUsername(), landIndex);
        currUser =  userService.findByUsername(currUser.getUsername());
    	session.setAttribute("user", currUser);
        return message;
    }


    /**
     * 种植作物
     * 
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @param seedId 种子id
     * @return 种植结果
     */
    @RequestMapping("/plant")
    @ResponseBody
    public Message plant(HttpSession session, int landIndex, int seedId) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return gameService.plantCrop(currUser.getUsername(), landIndex, seedId);
    }

    /**
     * 收获作物
     * 
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @return 收获结果
     */
    @RequestMapping("/harvest")
    @ResponseBody
    public Message harvest(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        Message message = gameService.harvest(currUser.getUsername(), landIndex);
        currUser =  userService.findByUsername(currUser.getUsername());
    	session.setAttribute("user", currUser);
        return message;
    }

    /**
     * 除虫
     * 
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @return 除虫结果
     */
    @RequestMapping("/killBug")
    @ResponseBody
    public Message killBug(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        Message message = gameService.killBug(currUser.getUsername(), landIndex);
        currUser =  userService.findByUsername(currUser.getUsername());
    	session.setAttribute("user", currUser);
        return message;
    }
    
    /**
     * 获取用户拥有的种子
     * 
     * @param session 当前用户会话
     * @param landType 土地类型
     * @return 种子列表
     */
    @RequestMapping("/getSeeds")
    @ResponseBody
    public List<?> getSeeds(HttpSession session, int landType) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return userBagService.getSeedCanPlant(currUser.getUsername(), landType);
    }
}
