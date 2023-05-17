package cn.jxufe.imp;

import cn.jxufe.dao.SoilDao;
import cn.jxufe.entity.Soil;
import cn.jxufe.service.SoilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SoilImp implements SoilService {

    @Autowired
    private SoilDao soilDao;

    @Override
    public Soil findBySoilId(int soilId) {
        return soilDao.findBySoilId(soilId);
    }
}
