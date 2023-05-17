package cn.jxufe.service;

import java.util.List;

import cn.jxufe.entity.GrowthStage;

public interface GrowthStageService {
    GrowthStage findByStageId(int stageId);

    List<GrowthStage> findAll();
}
