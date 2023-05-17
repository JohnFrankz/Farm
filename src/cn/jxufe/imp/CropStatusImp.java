package cn.jxufe.imp;

import cn.jxufe.dao.CropStatusDao;
import cn.jxufe.entity.CropStatus;
import cn.jxufe.service.CropStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CropStatusImp implements CropStatusService {

    @Autowired
    private CropStatusDao cropStatusDao;

    @Override
    public CropStatus findByStatusId(int statusId) {
        return cropStatusDao.findByStatusId(statusId);
    }

    @Override
    public List<CropStatus> findAll() {
        return cropStatusDao.findAll();
    }
}
