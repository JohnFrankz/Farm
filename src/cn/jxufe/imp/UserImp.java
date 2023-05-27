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

@Service
public class UserImp implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User findById(Long id) {
        return userDao.findOne(id);
    }

    @Override
    public List<User> findAllUser() {
        return userDao.findAll();
    }

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
    
    @Override
    public EasyUIData<User> findAll(Pageable pageable) {
        Page<User> page = userDao.findAll(pageable);
        EasyUIData<User> easyUIData = new EasyUIData<>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
    }

    @Override
    public EasyUIData<User> findUser(String username, Pageable pageable) {
        Page<User> page = userDao.findByUsernameContaining(username, pageable);
        EasyUIData<User> easyUIData = new EasyUIData<>();
        easyUIData.setTotal(page.getTotalElements());
        easyUIData.setRows(page.getContent());
        return easyUIData;
    }

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

	@Override
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}
}
