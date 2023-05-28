package cn.jxufe.dao;

import cn.jxufe.entity.FarmLandStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FarmLandStatusDao extends JpaRepository<FarmLandStatus, Long> {
    List<FarmLandStatus> findByUsername(String username);
}
