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

import java.util.List;

@Service
public class UserBagImp implements UserBagService {

    @Autowired
    private UserBagDao userBagDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private SeedDao seedDao;

    @Override
    public List<UserBag> findUserBagByUserName(String userName) {
        return userBagDao.findByUserName(userName);
    }

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

        return MessageUtils.createSuccessMessage("购买成功");
    }
}
