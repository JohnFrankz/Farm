package cn.jxufe.imp;

import cn.jxufe.dao.SeedTypeDao;
import cn.jxufe.entity.SeedType;
import cn.jxufe.service.SeedTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SeedTypeImp implements SeedTypeService {

    @Autowired
    private SeedTypeDao seedTypeDao;

    @Override
    public SeedType findByTypeId(int seedId) {
        return seedTypeDao.findByTypeId(seedId);
    }

    @Override
    public List<SeedType> findAll() {
        return seedTypeDao.findAll();
    }
}
