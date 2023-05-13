package cn.jxufe.controller;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.EasyUIDataPageRequest;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import cn.jxufe.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 跳转到用户列表页面
     * @return 用户列表页面
     */
    @RequestMapping("grid")
    public String grid() {
        return "user/grid";
    }

    /**
     * 获取用户列表
     * - 如果username不为空，则根据username模糊查询
     * - 如果username为空，则查询所有用户
     * @param request 分页请求
     * @param userName 用户名
     * @return 用户列表
     */
    @RequestMapping("/getUser")
    @ResponseBody
    public EasyUIData<User> getUser(EasyUIDataPageRequest request,
                                    @RequestParam(defaultValue = "") String userName) {
        System.out.println("\n\n\n\n\n\n\n\n\n");
        System.out.println("userName = " + userName);
        System.out.println("request = " + request);
        System.out.println("\n\n\n\n\n\n\n\n\n");
        List<Sort.Order> orders = new ArrayList<>();
        Sort.Direction direction = request.getOrder().equals("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;
        orders.add(new Sort.Order(direction, request.getSort()));
        Pageable pageable = new PageRequest(request.getPage() - 1, request.getRows(), new Sort(orders));
        EasyUIData<User> data;

        if ("".equals(userName)) {
            data = userService.findAll(pageable);
        } else {
            data = userService.findUser(userName, pageable);
        }
        return data;
    }

    /**
     * 如果user.id不为空，则更新用户信息
     * 如果user.id为空，则添加用户
     * @param user 用户信息
     * @return 返回保存结果
     */
    @RequestMapping("/save")
    @ResponseBody
    public Message save(User user) {
        return userService.save(user);
    }

    /**
     * 根据id删除用户
     * @param id 用户id
     * @return 返回删除结果
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Message delete(Long id) {
        return userService.delete(id);
    }

    /**
     * 更新用户头像
     */
    @RequestMapping("/updateAvatar")
    @ResponseBody
    public Message updateAvatar(Long id, String avatar) {
        return null;
    }
}
