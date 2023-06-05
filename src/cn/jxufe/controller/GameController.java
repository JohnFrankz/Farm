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

@Controller
@RequestMapping("/game")
public class GameController {

    @Autowired
    private GameService gameService;
    @Autowired
    private UserBagService userBagService;

    @RequestMapping("/index")
    public String index() {
        return "game";
    }

    @RequestMapping("/landStatus")
    @ResponseBody
    public List<FarmLandStatus> getLandStatus(HttpSession session) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        System.out.println("currUser = " + currUser);
        return gameService.getLandStatus(currUser.getUsername());
    }
    

    /**
     * 清除枯草
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @return
     */
    @RequestMapping("/cleanDeadLeaves")
    @ResponseBody
    public Message cleanWeed(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return gameService.cleanDeadLeaves(currUser.getUsername(), landIndex);
    }


    /**
     * 种植作物
     * @param session 当前用户会话
     * @param landIndex 土地索引
     * @param seedId 种子id
     * @return
     */
    @RequestMapping("/plant")
    @ResponseBody
    public Message plant(HttpSession session, int landIndex, int seedId) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return gameService.plantCrop(currUser.getUsername(), landIndex, seedId);
    }

    /**
     * 收获作物
     * @param session 当前用户会话
     * @param landIndex 土地索引
     */
    @RequestMapping("/harvest")
    @ResponseBody
    public Message harvest(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return gameService.harvest(currUser.getUsername(), landIndex);
    }

    /**
     * 除虫
     * @param session 当前用户会话
     * @param landIndex 土地索引
     */
    @RequestMapping("/killBug")
    @ResponseBody
    public Message killBug(HttpSession session, int landIndex) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return gameService.killBug(currUser.getUsername(), landIndex);
    }
    
    /**
     * 获取用户对应于某一土地类型的种子
     *
     */
    @RequestMapping("/getSeeds")
    @ResponseBody
    public List<?> getSeeds(HttpSession session, int landType) {
        User currUser = (User) session.getAttribute(GameConfig.__DEFAULT_USER_NAME_SESSION);
        return userBagService.getSeedCanPlant(currUser.getUsername(), landType);
    }
}
