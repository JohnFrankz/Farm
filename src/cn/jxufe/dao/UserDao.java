package cn.jxufe.dao;

import cn.jxufe.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用于操作用户的Dao层
 */
public interface UserDao extends JpaRepository<User, Long> {
    /**
     * 根据用户名查询用户, 并分页, 支持模糊查询
     * 
     * @param username 用户名
     * @param pageable 分页信息
     * @return 返回用户
     */
    Page<User> findByUsernameContaining(String username, Pageable pageable);

    /**
     * 根据用户名查询用户
     * 
     * @param username 用户名
     * @return 返回用户
     */
    User findByUsername(String username);
}
