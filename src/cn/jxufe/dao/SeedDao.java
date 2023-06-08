package cn.jxufe.dao;

import cn.jxufe.entity.Seed;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用于操作种子的Dao层, 实现种子的增删改查
 */
public interface SeedDao extends JpaRepository<Seed, Long> {
	/**
	 * 根据种子名称查询种子, 并分页, 支持模糊查询
	 * 如果种子名称为空, 则查询所有种子
	 * 如果种子名称不为空, 则根据种子名称进行模糊查询
	 * 
	 * @param seedName 种子名称或者种子名称的一部分
	 * @return 返回种子
	 */
	Page<Seed> findBySeedNameContaining(String seedName, Pageable pageable);
	
	/**
     * 根据种子ID查询种子。
     *
     * @param seedId 种子ID
     * @return 返回种子
     */
	Seed findBySeedId(int seedId);
}