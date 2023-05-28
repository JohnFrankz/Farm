package cn.jxufe.dao;

import cn.jxufe.entity.CropStatus;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用于操作作物状态的Dao层
 */
public interface CropStatusDao extends JpaRepository<CropStatus, Long> {
    /**
     * 根据状态id查询作物状态
     * @param statusId 状态id
     * @return 返回作物状态
     */
    CropStatus findByStatusId(int statusId);
}
