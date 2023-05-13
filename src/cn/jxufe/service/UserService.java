package cn.jxufe.service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import org.springframework.data.domain.Pageable;

public interface UserService{
    EasyUIData<User> findAll(Pageable pageable);

    EasyUIData<User> findUser(String username, Pageable pageable);

    Message save(User user);

    Message delete(Long id);

    Message updateAvatar(Long id, String avatar);
}
