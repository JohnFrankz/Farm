package cn.jxufe.service;

import cn.jxufe.entity.CropStatus;

import java.util.List;

/**
 * 关于作物状态的服务层接口
 */
public interface CropStatusService {
    /**
     * 根据状态id查询作物状态的接口方法
     * 
     * @param statusId 状态id
     * @return 返回作物状态
     */
    CropStatus findByStatusId(int statusId);

    /**
     * 查询所有作物状态的接口方法
     * 
     * @return 返回所有作物状态
     */
    List<CropStatus> findAll();
}
