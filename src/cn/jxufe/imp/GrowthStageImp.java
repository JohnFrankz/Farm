package cn.jxufe.imp;

import cn.jxufe.dao.GrowthStageDao;
import cn.jxufe.entity.GrowthStage;
import cn.jxufe.service.GrowthStageService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GrowthStageImp implements GrowthStageService {

    @Autowired
    private GrowthStageDao growthStageDao;

    @Override
    public GrowthStage findByStageId(int stageId) {
        return growthStageDao.findByStageId(stageId);
    }
    
    @Override
    public List<GrowthStage> findAll() {
        return growthStageDao.findAll();
    }
}
