package cn.jxufe.dao;

import cn.jxufe.entity.Soil;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SoilDao extends JpaRepository<Soil, Long> {
    Soil findBySoilId(int soilId);
}
