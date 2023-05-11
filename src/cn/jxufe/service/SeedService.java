package cn.jxufe.service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Seed;
import org.springframework.data.domain.Pageable;

public interface SeedService {
	EasyUIData<Seed> list(Pageable pageable);

	EasyUIData<Seed> findBySeedNameLike(String seedName, Pageable pageable);

	Message save(Seed seed);

	Message delete(Long id);
}