package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.FarmLandStatus;

import java.util.List;

/**
 * GameService 接口定义了游戏相关的操作。
 */
public interface GameService {
    
    /**
     * 获取土地状态列表。
     *
     * @param username 用户名
     * @return 土地状态列表
     */
    List<FarmLandStatus> getLandStatus(String username);

    /**
     * 游戏开始。
     */
    void gameStart();

    /**
     * 清除枯萎的叶子。
     *
     * @param username  用户名
     * @param landIndex 土地索引
     * @return 操作结果消息
     */
    Message cleanDeadLeaves(String username, int landIndex);

    /**
     * 种植作物。
     *
     * @param username  用户名
     * @param landIndex 土地索引
     * @param seedId    种子ID
     * @return 操作结果消息
     */
    Message plantCrop(String username, int landIndex, int seedId);

    /**
     * 收获作物。
     *
     * @param username  用户名
     * @param landIndex 土地索引
     * @return 操作结果消息
     */
    Message harvest(String username, int landIndex);

    /**
     * 杀死害虫。
     *
     * @param username  用户名
     * @param landIndex 土地索引
     * @return 操作结果消息
     */
    Message killBug(String username, int landIndex);
}

