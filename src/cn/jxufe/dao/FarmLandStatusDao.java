package cn.jxufe.dao;

import cn.jxufe.entity.FarmLandStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * FarmLandStatus实体类的数据访问对象接口
 */
public interface FarmLandStatusDao extends JpaRepository<FarmLandStatus, Long> {

    /**
     * 根据用户名查询农田状态列表
     *
     * @param username 用户名
     * @return 农田状态列表
     */
    List<FarmLandStatus> findByUsername(String username);

    /**
     * 根据是否种植和作物状态小于指定值查询农田状态列表
     *
     * @param isCrop     是否种植
     * @param cropStatus 作物状态
     * @return 农田状态列表
     */
    List<FarmLandStatus> findByIsCropAndCropStatusLessThan(int isCrop, int cropStatus);
    
    /**
     * 根据用户名和土地索引查询农田状态
     *
     * @param username   用户名
     * @param landIndex  土地索引
     * @return 农田状态
     */
    FarmLandStatus findByUsernameAndLandIndex(String username, int landIndex);
}
