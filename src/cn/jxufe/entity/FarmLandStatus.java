package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * 这是记录农场的土地状态的实体类
 */
@Entity
@Table(name = "T_FarmLandStatus")
public class FarmLandStatus extends EntityID {
    /** 所属用户 */
    private String username;
    /** 土地索引 */
    private int landIndex;
    /** 土地类型 */
    private int landType;
    /** 是否已种植 */
    private int isCrop;
    /** 作物Id */
    private int cropId;
    /** 作物状态 */
    private int cropStatus;
    /** 该作物状态下已经生长的时间 */
    private int currentStateHasGrownTime;
    /** 当前状态已经生长的时间 */
    private Date stateEndTime;
    /** 是否生虫 */
    private int isInsect;
    /** 是否枯萎 */
    private int isWithered;
    /** 是否成熟 */
    private int isMature;
    /** 作物产量 */
    private int output;

    @Override
    public String toString() {
        return "FarmLandStatus{" +
                "username='" + username + '\'' +
                ", landIndex=" + landIndex +
                ", landType=" + landType +
                ", isCrop=" + isCrop +
                ", cropId=" + cropId +
                ", cropStatus=" + cropStatus +
                ", currentStateHasGrownTime=" + currentStateHasGrownTime +
                ", stateEndTime=" + stateEndTime +
                ", isInsect=" + isInsect +
                ", isWithered=" + isWithered +
                ", isMature=" + isMature +
                ", output=" + output +
                '}';
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getLandIndex() {
        return landIndex;
    }

    public void setLandIndex(int landIndex) {
        this.landIndex = landIndex;
    }

    public int getLandType() {
        return landType;
    }

    public void setLandType(int landType) {
        this.landType = landType;
    }

    public int getIsCrop() {
        return isCrop;
    }

    public void setIsCrop(int isCrop) {
        this.isCrop = isCrop;
    }

    public int getCropId() {
        return cropId;
    }

    public void setCropId(int cropId) {
        this.cropId = cropId;
    }

    public int getCropStatus() {
        return cropStatus;
    }

    public void setCropStatus(int cropStatus) {
        this.cropStatus = cropStatus;
    }

    public int getCurrentStateHasGrownTime() {
        return currentStateHasGrownTime;
    }

    public void setCurrentStateHasGrownTime(int currentStateHasGrownTime) {
        this.currentStateHasGrownTime = currentStateHasGrownTime;
    }

    public Date getStateEndTime() {
        return stateEndTime;
    }

    public void setStateEndTime(Date stateEndTime) {
        this.stateEndTime = stateEndTime;
    }

    public int getIsInsect() {
        return isInsect;
    }

    public void setIsInsect(int isInsect) {
        this.isInsect = isInsect;
    }

    public int getIsWithered() {
        return isWithered;
    }

    public void setIsWithered(int isWithered) {
        this.isWithered = isWithered;
    }

    public int getIsMature() {
        return isMature;
    }

    public void setIsMature(int isMature) {
        this.isMature = isMature;
    }

    public int getOutput() {
        return output;
    }

    public void setOutput(int output) {
        this.output = output;
    }
}
