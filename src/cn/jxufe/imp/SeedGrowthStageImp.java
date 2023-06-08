package cn.jxufe.imp;

import cn.jxufe.bean.Message;
import cn.jxufe.dao.SeedGrowthStageDao;
import cn.jxufe.entity.SeedGrowthStage;
import cn.jxufe.service.SeedGrowthStageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 关于种子生长阶段的服务层实现类
 */
@Service
public class SeedGrowthStageImp implements SeedGrowthStageService {

    @Autowired
    private SeedGrowthStageDao stageDao;

    /**
     * 根据种子id查询某一种子的所有生长阶段
     * 
     * @param seedId 种子id
     * @return 返回该种子的所有生长阶段
     */
    @Override
    public List<SeedGrowthStage> findBySeedId(int seedId) {
        return stageDao.findBySeedId(seedId);
    }

    /**
     * 保存种子生长阶段的修改或新增某一种子的生长阶段
     * 
     * @param stage 种子生长阶段
     * @return 返回保存结果
     */
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

    /**
     * 删除种子生长阶段
     * 
     * @param id 需要删除的生长阶段的id
     * @return 返回删除结果
     */
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
