package cn.jxufe.dao;

import cn.jxufe.entity.SeedGrowthStage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 用于操作种子生长阶段的Dao层
 */
public interface SeedGrowthStageDao extends JpaRepository<SeedGrowthStage, Long> {
    /**
     * 根据种子id查询某一种子的所有生长阶段
     * 
     * @param seedId 种子id
     * @return 返回该种子的所有生长阶段
     */
    List<SeedGrowthStage> findBySeedId(int seedId);

    /**
     * 根据种子id和生长阶段查询种子生长阶段
     * 
     * @param seedId 种子id
     * @param growthStage 生长阶段
     * @return 返回种子生长阶段
     */
    SeedGrowthStage findBySeedIdAndGrowthStage(int seedId, int growthStage);
}
