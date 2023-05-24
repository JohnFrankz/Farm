package cn.jxufe.dao;

import cn.jxufe.entity.Seed;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SeedDao extends JpaRepository<Seed, Long> {
	Page<Seed> findBySeedNameContaining(String seedName, Pageable pageable);
	
	Seed findBySeedId(int seedId);
}