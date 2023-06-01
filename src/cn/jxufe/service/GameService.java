package cn.jxufe.service;

import cn.jxufe.bean.Message;
import cn.jxufe.entity.FarmLandStatus;

import java.util.List;

public interface GameService {
    List<FarmLandStatus> getLandStatus(String username);

    void gameStart();

    Message cleanDeadLeaves(String username, int landIndex);

    Message plantCrop(String username, int landIndex, int seedId);

    Message harvest(String username, int landIndex);

    Message killBug(String username, int landIndex);
}
