package cn.jxufe.imp;

import cn.jxufe.bean.Message;
import cn.jxufe.dao.SeedDao;
import cn.jxufe.dao.UserBagDao;
import cn.jxufe.dao.UserDao;
import cn.jxufe.entity.Seed;
import cn.jxufe.entity.User;
import cn.jxufe.entity.UserBag;
import cn.jxufe.service.UserBagService;
import cn.jxufe.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * UserBagImp 类是 UserBagService 接口的实现类，用于处理用户背包相关的操作。
 */
@Service
public class UserBagImp implements UserBagService {

    @Autowired
    private UserBagDao userBagDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private SeedDao seedDao;

    /**
     * 根据用户名查询用户背包中的物品列表。
     *
     * @param userName 用户名
     * @return 用户背包中的物品列表
     */
    @Override
    public List<UserBag> findUserBagByUserName(String userName) {
        return userBagDao.findByUserName(userName);
    }

    /**
     * 购买种子。
     *
     * @param userName 用户名
     * @param seedId   种子ID
     * @param num      购买数量
     * @return 操作结果消息
     */
    @Transactional
    @Override
    public Message buySeed(String userName, int seedId, int num) {
        User user = userDao.findByUsername(userName);
        Seed seed = seedDao.findBySeedId(seedId);

        if (user == null) {
            return MessageUtils.createErrorMessage("用户不存在，购买失败");
        }
        if (seed == null) {
            return MessageUtils.createErrorMessage("种子不存在，购买失败");
        }

        int totalCost = seed.getPurchasePrice() * num;
        if (user.getMoney() < totalCost) {
            return MessageUtils.createErrorMessage("余额不足，购买失败");
        }

        user.setMoney(user.getMoney() - totalCost);
        UserBag userBag = userBagDao.findByUserNameAndSeedId(userName, seedId);
        if (userBag == null) {
            userBag = new UserBag();
            userBag.setUserName(userName);
            userBag.setSeedId(seedId);
            userBag.setSeedNum(num);
        } else {
            userBag.setSeedNum(userBag.getSeedNum() + num);
        }
        userBagDao.save(userBag);
        return MessageUtils.createSuccessMessage("购买成功");
    }
    
    /**
     * 获取可种植的种子列表。
     *
     * @param userName 用户名
     * @param soil     土壤类型
     * @return 可种植的种子列表
     */
    @Override
    public List<UserBag> getSeedCanPlant(String userName, int soil) {
        List<UserBag> allSeed = userBagDao.findByUserName(userName);
        List<UserBag> seedCanPlant = new ArrayList<>();

        for (UserBag userBag : allSeed) {
            Seed seed = seedDao.findBySeedId(userBag.getSeedId());
            if (seed == null) {
                continue;
            }
            if (seed.getSoil() == soil) {
                seedCanPlant.add(userBag);
            }
        }
        return seedCanPlant;
    }
}
