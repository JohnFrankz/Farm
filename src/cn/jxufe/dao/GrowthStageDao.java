package cn.jxufe.dao;

import cn.jxufe.entity.GrowthStage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GrowthStageDao extends JpaRepository<GrowthStage, Long> {
    GrowthStage findByStageId(int stageId);
}
