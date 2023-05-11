package cn.jxufe.imp;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.Message;
import cn.jxufe.dao.SeedDao;
import cn.jxufe.entity.Seed;
import cn.jxufe.service.SeedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class SeedImp implements SeedService {

    @Autowired
    private SeedDao seedDao;

    @Override
    public EasyUIData<Seed> list(Pageable pageable) {
        Page<Seed> page = seedDao.findAll(pageable);
        EasyUIData<Seed> data = new EasyUIData<>();

        data.setTotal(page.getTotalElements());
        data.setRows(page.getContent());
        return data;
    }

    @Override
    public EasyUIData<Seed> findBySeedNameLike(String seedName, Pageable pageable) {
        Page<Seed> page = seedDao.findBySeedNameLike(seedName, pageable);
        EasyUIData<Seed> data = new EasyUIData<>();

        data.setTotal(page.getTotalElements());
        data.setRows(page.getContent());
        return data;
    }

    @Override
    public Message save(Seed seed) {
        Message message=new Message();
        try {
            seedDao.save(seed);
            message.setCode(0);
            message.setMsg("保存成功");
        }catch (Exception e) {
            message.setCode(-10);
            message.setMsg("保存失败");
        }
        return message;
    }

    @Override
    public Message delete(Long id) {
        Message message = new Message();
        try {
            seedDao.delete(id);
            message.setCode(0);
            message.setMsg("删除成功");
        }catch(Exception e) {
            message.setCode(-10);
            message.setMsg("删除失败");
        }
        return message;
    }
}
