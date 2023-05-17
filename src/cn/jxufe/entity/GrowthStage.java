package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "T_GrowthStage")
public class GrowthStage extends EntityID {
    private int stageId;
    private String stageName;

    @Override
    public String toString() {
        return "GrowthStage{" +
                "stageId=" + stageId +
                ", stageName='" + stageName + '\'' +
                '}';
    }

    public int getStageId() {
        return stageId;
    }

    public void setStageId(int stageId) {
        this.stageId = stageId;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }
}
