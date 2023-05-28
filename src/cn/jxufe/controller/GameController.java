package cn.jxufe.controller;

import cn.jxufe.bean.GameConfig;
import cn.jxufe.entity.FarmLandStatus;
import cn.jxufe.entity.User;
import cn.jxufe.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/game")
public class GameController {

    @Autowired
    private GameService gameService;

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
}
