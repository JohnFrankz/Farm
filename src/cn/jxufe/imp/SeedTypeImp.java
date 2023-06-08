package cn.jxufe.imp;

import cn.jxufe.dao.SeedTypeDao;
import cn.jxufe.entity.SeedType;
import cn.jxufe.service.SeedTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 关于种子类型的服务层实现类
 */
@Service
public class SeedTypeImp implements SeedTypeService {

    @Autowired
    private SeedTypeDao seedTypeDao;

    /**
     * 根据种子类型id查询种子类型
     * 
     * @param seedId 种子类型id
     * @return 返回种子类型
     */
    @Override
    public SeedType findByTypeId(int seedId) {
        return seedTypeDao.findByTypeId(seedId);
    }

    /**
     * 查询所有种子类型
     * 
     * @return 返回所有种子类型
     */
    @Override
    public List<SeedType> findAll() {
        return seedTypeDao.findAll();
    }
}
