package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 用户种子背包实体类
 */
@Entity
@Table(name = "T_UserBag")
public class UserBag extends EntityID {
    private String userName;
    private int seedId;
    private int seedNum;

    @Override
    public String toString() {
        return "UserBag{" +
                "userName='" + userName + '\'' +
                ", seedId=" + seedId +
                ", seedNum=" + seedNum +
                '}';
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getSeedId() {
        return seedId;
    }

    public void setSeedId(int seedId) {
        this.seedId = seedId;
    }

    public int getSeedNum() {
        return seedNum;
    }

    public void setSeedNum(int seedNum) {
        this.seedNum = seedNum;
    }
}
