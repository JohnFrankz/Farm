package cn.jxufe.service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.User;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * 关于用户的服务层接口
 */
public interface UserService{
    /**
     * 根据用户id查询用户
     * @param id 用户id
     * @return 返回用户
     */
    User findById(Long id);

    /**
     * 查询所有用户
     * @return 返回所有用户
     */
    List<User> findAllUser();

    /**
     * 用户登录, 根据用户id查询用户, 如果用户存在则登录成功, 否则登录失败
     * @param id 用户id
     * @return 返回登录结果
     */
    Message login(Long id);

    /**
     * 查询所有用户
     * @param pageable 分页请求
     * @return 返回用户信息以EasyUIData的形式封装
     */
    EasyUIData<User> findAll(Pageable pageable);

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @param pageable 分页请求
     * @return 返回用户信息以EasyUIData的形式封装
     */
    EasyUIData<User> findUser(String username, Pageable pageable);

    /**
     * 保存用户的修改或新增用户的接口方法
     * @param user 用户
     * @return 返回保存结果
     */
    Message save(User user);

    /**
     * 删除用户的接口方法
     * @param id 需要删除的用户的id
     * @return 返回删除结果
     */
    Message delete(Long id);

    /**
     * 更新用户头像的接口方法
     * @param id 用户id
     * @param avatar 用户头像
     * @return 返回更新结果
     */
    Message updateAvatar(Long id, String avatar);
}
