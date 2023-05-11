package cn.jxufe.dao;

import cn.jxufe.entity.SeedGrowthStage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SeedGrowthStageDao extends JpaRepository<SeedGrowthStage, Long> {
    List<SeedGrowthStage> findBySeedId(int seedId);
    SeedGrowthStage findBySeedIdAndGrowthStage(int seedId, int growthStage);
}
