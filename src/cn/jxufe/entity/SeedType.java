package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 种子类型实体类
 */
@Entity
@Table(name = "T_SeedType")
public class SeedType extends EntityID {
    /**
     * 种子类型id
     */
    private int typeId;
    /**
     * 种子类型名称
     */
    private String typeName;

    @Override
    public String toString() {
        return "SeedType{" +
                "typeId=" + typeId +
                ", typeName='" + typeName + '\'' +
                '}';
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
