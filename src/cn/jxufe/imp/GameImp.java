package cn.jxufe.imp;

import cn.jxufe.dao.FarmLandStatusDao;
import cn.jxufe.entity.FarmLandStatus;
import cn.jxufe.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GameImp implements GameService {

    @Autowired
    private FarmLandStatusDao farmLandStatusDao;

    @Override
    public List<FarmLandStatus> getLandStatus(String username) {
        return farmLandStatusDao.findByUsername(username);
    }
}
