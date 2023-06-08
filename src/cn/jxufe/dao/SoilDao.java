package cn.jxufe.dao;

import cn.jxufe.entity.Soil;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用于操作土壤的Dao层
 */
public interface SoilDao extends JpaRepository<Soil, Long> {

    /**
     * 根据土壤id查询土壤
     * 
     * @param soilId 土壤id
     * @return 返回土壤
     */
    Soil findBySoilId(int soilId);
}
