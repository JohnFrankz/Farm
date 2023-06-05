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

/**
 * 关于种子的服务层实现类
 */
@Service
public class SeedImp implements SeedService {

    @Autowired
    private SeedDao seedDao;

    /**
     * 查询所有种子信息
     * @param pageable 分页请求
     * @return 返回种子信息以EasyUIData的形式封装
     */
    @Override
    public EasyUIData<Seed> list(Pageable pageable) {
        Page<Seed> page = seedDao.findAll(pageable);
        EasyUIData<Seed> data = new EasyUIData<>();

        data.setTotal(page.getTotalElements());
        data.setRows(page.getContent());
        return data;
    }

    /**
     * 根据种子名称查询种子信息
     * @param seedName 种子名称
     * @param pageable 分页请求
     * @return 返回种子信息以EasyUIData的形式封装
     */
    @Override
    public EasyUIData<Seed> findBySeedNameLike(String seedName, Pageable pageable) {
        Page<Seed> page = seedDao.findBySeedNameContaining(seedName, pageable);
        EasyUIData<Seed> data = new EasyUIData<>();

        data.setTotal(page.getTotalElements());
        data.setRows(page.getContent());
        return data;
    }

    /**
     * 保存种子的修改或新增种子
     * @param seed 种子
     * @return 返回保存结果
     */
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

    /**
     * 删除种子
     * @param id 需要删除的种子的id
     * @return 返回删除结果
     */
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
    
    @Override
    public Seed findBySeedId(int seedId) {
        return seedDao.findBySeedId(seedId);
    }
}
