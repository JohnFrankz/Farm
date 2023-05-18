package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "T_Soil")
public class Soil extends EntityID {
    private int soilId;
    private String soilName;

    @Override
    public String toString() {
        return "Soil{" +
                "soilId=" + soilId +
                ", soilName='" + soilName + '\'' +
                '}';
    }

    public int getSoilId() {
        return soilId;
    }

    public void setSoilId(int soilId) {
        this.soilId = soilId;
    }

    public String getSoilName() {
        return soilName;
    }

    public void setSoilName(String soilName) {
        this.soilName = soilName;
    }
}
