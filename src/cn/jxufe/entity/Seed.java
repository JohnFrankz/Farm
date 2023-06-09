package cn.jxufe.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.jxufe.bean.EntityID;

/**
 * 种子实体类
 */
@Entity
@Table(name = "T_Seed")
public class Seed extends EntityID {
	/**
	 * 种子id
	 */
	private int seedId;
	
	/**
	 * 种子名称
	 */
	private String seedName;
	/**
	 * 种子季节
	 */
	private int season;
	/**
	 * 种子等级
	 */
	private int seedLevel;
	/**
	 * 种子类型
	 */
	private int seedType;
	/**
	 * 种子经验
	 */
	private int experience;
	/**
	 * 种子成熟时间
	 */
	private int matureTime;
	/**
	 * 种子收获量
	 */
	private int harvest;
	/**
	 * 种子购买价格
	 */
	private int purchasePrice;
	/**
	 * 种子出售价格
	 */
	private int salePrice;
	/**
	 * 种子所需土壤
	 */
	private int soil;
	/**
	 * 种子成熟后获得的积分
	 */
	private int points;
	/**
	 * 提示信息
	 */
	private String prompt;

	public int getSeedId() {
		return seedId;
	}

	public void setSeedId(int seedId) {
		this.seedId = seedId;
	}

	public String getSeedName() {
		return seedName;
	}

	public void setSeedName(String seedName) {
		this.seedName = seedName;
	}

	public int getSeason() {
		return season;
	}

	public void setSeason(int season) {
		this.season = season;
	}

	public int getSeedLevel() {
		return seedLevel;
	}

	public void setSeedLevel(int seedLevel) {
		this.seedLevel = seedLevel;
	}

	public int getSeedType() {
		return seedType;
	}

	public void setSeedType(int seedType) {
		this.seedType = seedType;
	}

	public int getExperience() {
		return experience;
	}

	public void setExperience(int experience) {
		this.experience = experience;
	}

	public int getMatureTime() {
		return matureTime;
	}

	public void setMatureTime(int matureTime) {
		this.matureTime = matureTime;
	}

	public int getHarvest() {
		return harvest;
	}

	public void setHarvest(int harvest) {
		this.harvest = harvest;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}

	public int getSoil() {
		return soil;
	}

	public void setSoil(int soil) {
		this.soil = soil;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}

	@Override
	public String toString() {
		return "Seed [seedId=" + seedId + ", seedName=" + seedName + ", season=" + season + ", seedLevel=" + seedLevel
				+ ", seedType=" + seedType + ", experience=" + experience + ", matureTime=" + matureTime + ", harvest="
				+ harvest + ", purchasePrice=" + purchasePrice + ", salePrice=" + salePrice + ", soil=" + soil
				+ ", points=" + points + ", prompt=" + prompt + "]";
	}
}
