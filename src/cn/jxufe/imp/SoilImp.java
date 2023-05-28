package cn.jxufe.imp;

import cn.jxufe.dao.SoilDao;
import cn.jxufe.entity.Soil;
import cn.jxufe.service.SoilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 关于土壤的服务层实现类
 */
@Service
public class SoilImp implements SoilService {

    /**
     * 注入土壤的数据访问层
     */
    @Autowired
    private SoilDao soilDao;

    /**
     * 根据土壤id查询土壤
     * @param soilId 土壤id
     * @return 返回土壤
     */
    @Override
    public Soil findBySoilId(int soilId) {
        return soilDao.findBySoilId(soilId);
    }

    /**
     * 查询所有土壤
     * @return 返回所有土壤
     */
    @Override
    public List<Soil> findAll() {
        return soilDao.findAll();
    }
}
