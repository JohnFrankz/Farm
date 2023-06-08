package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.UserBag;

import java.util.List;

import java.util.List;

/**
 * UserBagService 接口定义了用户背包相关的操作。
 */
public interface UserBagService {
    
    /**
     * 根据用户名查找用户背包列表。
     *
     * @param userName 用户名
     * @return 用户背包列表
     */
    List<UserBag> findUserBagByUserName(String userName);

    /**
     * 购买种子。
     *
     * @param userName 用户名
     * @param seedId   种子ID
     * @param num      购买数量
     * @return 操作结果消息
     */
    Message buySeed(String userName, int seedId, int num);

    /**
     * 获取可种植的种子列表。
     *
     * @param userName 用户名
     * @param soil     土地类型
     * @return 可种植的种子列表
     */
    List<UserBag> getSeedCanPlant(String userName, int soil);
}

