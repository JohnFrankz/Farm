package cn.jxufe.dao;

import cn.jxufe.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<User, Long> {
    Page<User> findByUsernameContaining(String username, Pageable pageable);
    User findByUsername(String username);
}
