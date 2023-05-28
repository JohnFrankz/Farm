package cn.jxufe.service;

import cn.jxufe.entity.FarmLandStatus;

import java.util.List;

public interface GameService {
    List<FarmLandStatus> getLandStatus(String username);
}
