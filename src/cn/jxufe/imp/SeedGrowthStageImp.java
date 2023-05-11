package cn.jxufe.imp;

import cn.jxufe.bean.Message;
import cn.jxufe.dao.SeedGrowthStageDao;
import cn.jxufe.entity.SeedGrowthStage;
import cn.jxufe.service.SeedGrowthStageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SeedGrowthStageImp implements SeedGrowthStageService {

    @Autowired
    private SeedGrowthStageDao stageDao;

    @Override
    public List<SeedGrowthStage> findBySeedId(int seedId) {
        return stageDao.findBySeedId(seedId);
    }

    @Override
    public Message save(SeedGrowthStage stage) {
        Message message=new Message();
        try {
            stageDao.save(stage);
            message.setCode(0);
            message.setMsg("保存成功");
        }catch (Exception e) {
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
    }

    @Override
    public Message delete(Long id) {
        Message message = new Message();
        try {
            stageDao.delete(id);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
    }
}
