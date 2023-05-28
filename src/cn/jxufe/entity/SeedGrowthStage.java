package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 种子生长阶段实体类
 */
@Entity
@Table(name = "T_SeedGrowthStage")
public class SeedGrowthStage extends EntityID {
    /**
     * 种子id
     */
    private int seedId;
    /**
     * 生长阶段id
     */
    private int growthStage;
    /**
     * 生长阶段名称
     */
    private String growthName;
    /**
     * 生长阶段所需时间
     */
    private int growthTime;
    /**
     * 生长阶段虫害概率
     */
    private float pestProbability;
    /**
     * 生长阶段图片宽度
     */
    private int width;
    /**
     * 生长阶段图片高度
     */
    private int height;
    /**
     * 生长阶段图片x坐标
     */
    private int x;
    /**
     * 生长阶段图片y坐标
     */
    private int y;
    /**
     * 作物状态
     */
    private int state;

    public int getSeedId() {
        return seedId;
    }

    public void setSeedId(int seedId) {
        this.seedId = seedId;
    }

    public int getGrowthStage() {
        return growthStage;
    }

    public void setGrowthStage(int growthStage) {
        this.growthStage = growthStage;
    }

    public String getGrowthName() {
        return growthName;
    }

    public void setGrowthName(String growthName) {
        this.growthName = growthName;
    }

    public int getGrowthTime() {
        return growthTime;
    }

    public void setGrowthTime(int growthTime) {
        this.growthTime = growthTime;
    }

    public float getPestProbability() {
        return pestProbability;
    }

    public void setPestProbability(float pestProbability) {
        this.pestProbability = pestProbability;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "SeedGrowthStage{" +
                "seedId=" + seedId +
                ", growthStage=" + growthStage +
                ", growthName='" + growthName + '\'' +
                ", growthTime=" + growthTime +
                ", pestProbability=" + pestProbability +
                ", width=" + width +
                ", height=" + height +
                ", x=" + x +
                ", y=" + y +
                ", state=" + state +
                '}';
    }
}
