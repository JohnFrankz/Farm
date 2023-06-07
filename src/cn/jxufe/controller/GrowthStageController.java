package cn.jxufe.controller;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.CropStatus;
import cn.jxufe.entity.SeedGrowthStage;
import cn.jxufe.service.CropStatusService;
import cn.jxufe.service.SeedGrowthStageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 这是一个种子生长阶段的控制器
 */
@Controller
@RequestMapping("growth")
public class GrowthStageController {

    @Autowired
    private SeedGrowthStageService stageService;
    @Autowired
    private CropStatusService cropStatusService;
    
    @RequestMapping(value="getStage")
    @ResponseBody
    public SeedGrowthStage getStage(int seedId, int growthStage){
        return stageService.getSeedGrowthStage(seedId, growthStage);
    }
    
    /**
     * 这是一个获取种子生长阶段的API
     * @param seedId 种子id
     * @return 返回种子的生长阶段
     */
    @RequestMapping(value="gridData")
    @ResponseBody
    public List<SeedGrowthStage> grid(int seedId){
        return stageService.findBySeedId(seedId);
    }

    /**
     * 这是一个保存种子生长阶段的API
     * @param stage 种子生长阶段
     * @return 返回保存结果
     */
    @RequestMapping(value="save",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Message save(SeedGrowthStage stage) {
        return stageService.save(stage);
    }

    /**
     * 这是一个删除种子生长阶段的API
     * @param id 需要删除的生长阶段的id
     * @return 返回删除结果
     */
    @RequestMapping(value="delete",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Message delete(Long id) {
        return stageService.delete(id);
    }
    
    /**
     * 这是获取作物状态的API
     * @param statusId 作物状态id
     * @return 返回对应的作物状态
     */
    @RequestMapping(value = "getCropStatus", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public CropStatus getCropStatus(int statusId) {
        return cropStatusService.findByStatusId(statusId);
    }

    /**
     * 这是获取所有作物状态的API
     * @return 返回所有作物状态
     */
    @RequestMapping(value = "getAllCropStatus")
    @ResponseBody
    public List<CropStatus> getAllCropStatus() {
        return cropStatusService.findAll();
    }
    
    
}
