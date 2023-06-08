package cn.jxufe.dao;

import cn.jxufe.entity.SeedType;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用于操作种子类型的Dao层
 */
public interface SeedTypeDao extends JpaRepository<SeedType, Long> {
    
    /**
     * 根据类型id查询种子类型
     * 
     * @param typeId 类型id
     * @return 返回种子类型
     */
    SeedType findByTypeId(int typeId);
}
