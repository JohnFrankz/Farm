package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.SeedGrowthStage;

import java.util.List;

public interface SeedGrowthStageService {
    List<SeedGrowthStage> findBySeedId(int seedId);
    Message save(SeedGrowthStage stage);
    Message delete(Long id);
}
