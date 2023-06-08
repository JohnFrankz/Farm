package cn.jxufe.dao;

import cn.jxufe.entity.UserBag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 用于操作用户种子背包的数据访问对象（Dao）层，实现用户背包的增删改查。
 */
public interface UserBagDao extends JpaRepository<UserBag, Long> {

    /**
     * 根据用户名查询用户种子背包。
     *
     * @param userName 用户名
     * @return 返回用户种子背包列表
     */
    List<UserBag> findByUserName(String userName);

    /**
     * 根据用户名和种子id查询用户种子背包。
     *
     * @param userName 用户名
     * @param seedId   种子id
     * @return 返回用户种子背包
     */
    UserBag findByUserNameAndSeedId(String userName, int seedId);
}
