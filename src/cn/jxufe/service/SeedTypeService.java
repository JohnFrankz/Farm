package cn.jxufe.service;

import cn.jxufe.entity.SeedType;

import java.util.List;

public interface SeedTypeService {
    SeedType findByTypeId(int typeId);

    List<SeedType> findAll();
}