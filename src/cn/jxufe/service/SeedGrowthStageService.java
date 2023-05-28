package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.SeedGrowthStage;

import java.util.List;

/**
 * 关于种子生长阶段的服务层接口
 */
public interface SeedGrowthStageService {
    /**
     * 根据种子id查询某一种子的所有生长阶段的接口方法
     * @param seedId 种子id
     * @return 返回该种子的所有生长阶段
     */
    List<SeedGrowthStage> findBySeedId(int seedId);
    /**
     * 保存种子生长阶段的修改或新增某一种子的生长阶段的接口方法
     * @param stage 种子生长阶段
     * @return 返回保存结果
     */
    Message save(SeedGrowthStage stage);
    /**
     * 删除种子生长阶段的接口方法
     * @param id 需要删除的生长阶段的id
     * @return 返回删除结果
     */
    Message delete(Long id);
}
