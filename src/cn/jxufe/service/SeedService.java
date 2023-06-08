package cn.jxufe.service;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Seed;
import org.springframework.data.domain.Pageable;

/**
 * 关于种子的服务层接口
 */
public interface SeedService {

	/**
	 * 查询所有种子信息的接口方法
	 * 
	 * @param pageable 分页请求
	 * @return 返回种子信息以EasyUIData的形式封装
	 */
	EasyUIData<Seed> list(Pageable pageable);

	/**
	 * 根据种子名称查询种子信息的接口方法
	 * 
	 * @param seedName 种子名称
	 * @param pageable 分页请求
	 * @return 返回种子信息以EasyUIData的形式封装
	 */
	EasyUIData<Seed> findBySeedNameLike(String seedName, Pageable pageable);

	/**
	 * 保存种子的修改或新增种子的接口方法
	 * 
	 * @param seed 种子
	 * @return 返回保存结果
	 */
	Message save(Seed seed);

	/**
	 * 删除种子的接口方法
	 * 
	 * @param id 需要删除的种子的id
	 * @return 返回删除结果
	 */
	Message delete(Long id);

	/**
	 * 根据种子id查询种子的接口方法
	 * 
	 * @param seedId 种子id
	 * @return 返回种子
	 */
	Seed findBySeedId(int seedId);	
}