package cn.jxufe.controller;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import cn.jxufe.entity.UserBag;
import cn.jxufe.service.UserBagService;
import cn.jxufe.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

import javax.servlet.http.HttpSession;

/**
 *  这是一个种子商店的控制器， 用于处理种子商店的相关请求。
 */
@Controller
@RequestMapping("store")
public class StoreController {

    @Autowired
    private UserBagService userBagService;
    @Autowired
    private UserService userService;

    /**
     * 这是一个种子商店的首页
     * @return 返回种子商店的首页
     */
    @RequestMapping("index")
    public String index() {
        return "seedBag/seedBag";
    }

    /**
     * 获取用户种子背包，用于显示用户已经购买的种子
     * @param userName 用户名
     * @return 返回用户所有已购买的种子
     */
    @RequestMapping("userBag")
    @ResponseBody
    public List<UserBag> userBag(String userName) {
        return userBagService.findUserBagByUserName(userName);
    }

    /**
     * 购买种子的API
     * @param userName 需要购买种子的用户名
     * @param seedId 购买的种子的ID
     * @param num 购买的数量
     * @return 返回购买的结果
     */
    @RequestMapping("buy")
    @ResponseBody
    public Message buySeed(HttpSession session, String userName, int seedId, int num) {
    	Message message = userBagService.buySeed(userName, seedId, num);
    	User user =  userService.findByUsername(userName);
    	session.setAttribute("user", user);
        return message;
    }

}
