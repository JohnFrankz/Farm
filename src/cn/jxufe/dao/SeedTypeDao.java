package cn.jxufe.dao;

import cn.jxufe.entity.SeedType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SeedTypeDao extends JpaRepository<SeedType, Long> {
    SeedType findByTypeId(int typeId);
}
