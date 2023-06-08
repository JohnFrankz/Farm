package cn.jxufe.service;

import cn.jxufe.entity.SeedType;

import java.util.List;

/**
 * 关于种子类型的服务层接口
 */
public interface SeedTypeService {
    
    /**
     * 根据种子类型id查询种子类型
     * 
     * @param typeId 种子类型id
     * @return 返回种子类型
     */
    SeedType findByTypeId(int typeId);

    /**
     * 查询所有种子类型
     * 
     * @return 返回所有种子类型
     */
    List<SeedType> findAll();
}