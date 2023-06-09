package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 作物状态实体类
 */
@Entity
@Table(name = "T_CropStatus")
public class CropStatus extends EntityID {
    /**
     * 作物状态id
     */
    private int statusId;

    /**
     * 作物状态名称
     */
    private String statusName;

    @Override
    public String toString() {
        return "CropStatus{" +
                "statusId=" + statusId +
                ", statusName='" + statusName + '\'' +
                '}';
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}
