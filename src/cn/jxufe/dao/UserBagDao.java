package cn.jxufe.dao;

import cn.jxufe.entity.UserBag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserBagDao extends JpaRepository<UserBag, Long> {
    List<UserBag> findByUserName(String userName);

    UserBag findByUserNameAndSeedId(String userName, int seedId);
}
