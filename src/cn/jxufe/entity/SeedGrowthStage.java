package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "T_SeedGrowthStage")
public class SeedGrowthStage extends EntityID {
    private int seedId;

    // 种子生长阶段
    private int growthStage;

    // 生长阶段标题
    private String growthName;

    // 阶段生长时间
    private int growthTime;

    // 害虫概率
    private float pestProbability;

    private int width;
    private int height;
    private int x;
    private int y;

    // 作物状态
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
