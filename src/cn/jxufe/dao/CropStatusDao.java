package cn.jxufe.dao;

import cn.jxufe.entity.CropStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CropStatusDao extends JpaRepository<CropStatus, Long> {
    CropStatus findByStatusId(int statusId);
}
