package cn.jxufe.imp;

import cn.jxufe.dao.CropStatusDao;
import cn.jxufe.entity.CropStatus;
import cn.jxufe.service.CropStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 关于作物状态的服务层实现类
 */
@Service
public class CropStatusImp implements CropStatusService {

    @Autowired
    private CropStatusDao cropStatusDao;

    /**
     * 根据状态id查询作物状态
     * 
     * @param statusId 状态id
     * @return 返回作物状态
     */
    @Override
    public CropStatus findByStatusId(int statusId) {
        return cropStatusDao.findByStatusId(statusId);
    }

    /**
     * 查询所有作物状态
     * 
     * @return 返回所有作物状态
     */
    @Override
    public List<CropStatus> findAll() {
        return cropStatusDao.findAll();
    }
}
