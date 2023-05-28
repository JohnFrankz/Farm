package cn.jxufe.imp;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.dao.UserDao;
import cn.jxufe.entity.User;
import cn.jxufe.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 关于用户的服务层实现类
 */
@Service
public class UserImp implements UserService {

    @Autowired
    private UserDao userDao;

    /**
     * 根据用户id查询用户
     * @param id 用户id
     * @return 返回用户
     */
    @Override
    public User findById(Long id) {
        return userDao.findOne(id);
    }

    /**
     * 查询所有用户
     * @return 返回所有用户
     */
    @Override
    public List<User> findAllUser() {
        return userDao.findAll();
    }

    /**
     * 用户登录, 根据用户id查询用户, 如果用户存在则登录成功, 否则登录失败
     * @param id 用户id
     * @return 返回登录结果
     */
    @Override
    public Message login(Long id) {
        Message message = new Message();
        User user = userDao.findOne(id);
        if (user != null) {
            message.setCode(0);
            message.setMsg("登录成功");
        } else {
            message.setCode(1);
            message.setMsg("登录失败");
        }
        return message;
    }
    
    /**
     * 查询所有用户
     * @param pageable 分页参数
     * @return 返回分页后的用户数据以EasyUIData的形式封装
     */
    @Override
    public EasyUIData<User> findAll(Pageable pageable) {
        Page<User> page = userDao.findAll(pageable);
        EasyUIData<User> easyUIData = new EasyUIData<>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
    }

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @param pageable 分页参数
     * @return 返回分页后的用户数据以EasyUIData的形式封装
     */
    @Override
    public EasyUIData<User> findUser(String username, Pageable pageable) {
        Page<User> page = userDao.findByUsernameContaining(username, pageable);
        EasyUIData<User> easyUIData = new EasyUIData<>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
    }

    /**
     * 保存用户的修改或新增用户
     * @param user 用户
     * @return 返回保存结果
     */
    @Override
    public Message save(User user) {
        Message message = new Message();
        try {
            userDao.save(user);
            message.setCode(0);
            message.setMsg("保存成功");
        } catch (Exception e) {
            message.setCode(-1);
            message.setMsg("保存失败");
        }
        return message;
    }

    /**
     * 删除用户
     * @param id 需要删除的用户的id
     * @return 返回删除结果
     */
    @Override
    public Message delete(Long id) {
        Message message = new Message();
        try {
            userDao.delete(id);
            message.setCode(0);
            message.setMsg("删除成功");
        } catch (Exception e) {
            message.setCode(-1);
            message.setMsg("删除失败");
        }
        return message;
    }

    /**
     * 更新用户头像
     * @param id 用户id
     * @param avatar 用户头像
     * @return 返回更新结果
     */
    @Override
    public Message updateAvatar(Long id, String avatar) {
    	Message message = new Message();
        try {
            User user = userDao.findOne(id);
            user.setAvatar(avatar);
            userDao.save(user);
            message.setCode(0);
            message.setMsg("更新头像成功");
        } catch (Exception e) {
            message.setCode(-1);
            message.setMsg("更新头像失败");
        }
        return message;
    }
}
