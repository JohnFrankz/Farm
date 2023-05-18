package cn.jxufe.service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService{
    User findById(Long id);

    List<User> findAllUser();

    Message login(Long id);

    EasyUIData<User> findAll(Pageable pageable);

    EasyUIData<User> findUser(String username, Pageable pageable);

    Message save(User user);

    Message delete(Long id);

    Message updateAvatar(Long id, String avatar);
}
