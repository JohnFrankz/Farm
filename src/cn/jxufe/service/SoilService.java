package cn.jxufe.service;

import cn.jxufe.entity.Soil;

import java.util.List;

public interface SoilService {
    Soil findBySoilId(int soilId);

    List<Soil> findAll();
}
