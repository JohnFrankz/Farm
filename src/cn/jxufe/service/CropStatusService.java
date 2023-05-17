package cn.jxufe.service;

import cn.jxufe.entity.CropStatus;

import java.util.List;

public interface CropStatusService {
    CropStatus findByStatusId(int statusId);

    List<CropStatus> findAll();
}
