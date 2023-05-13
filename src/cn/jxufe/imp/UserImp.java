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

@Service
public class UserImp implements UserService {

    @Autowired
    private UserDao userDao;

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
        return null;
    }
}
