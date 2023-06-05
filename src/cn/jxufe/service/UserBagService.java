package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.UserBag;

import java.util.List;

public interface UserBagService {
    List<UserBag> findUserBagByUserName(String userName);

    Message buySeed(String userName, int seedId, int num);

    List<UserBag> getSeedCanPlant(String userName, int soil);
}
