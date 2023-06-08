package cn.jxufe.service;

import cn.jxufe.entity.Soil;

import java.util.List;

/**
 * 关于土壤的服务层接口
 */
public interface SoilService {

    /**
     * 根据土壤id查询土壤
     * 
     * @param soilId 土壤id
     * @return 返回土壤
     */
    Soil findBySoilId(int soilId);

    /**
     * 查询所有土壤
     * 
     * @return 返回所有土壤
     */
    List<Soil> findAll();
}
