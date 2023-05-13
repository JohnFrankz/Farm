package cn.jxufe.entity;

import cn.jxufe.bean.EntityID;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "T_User")
public class User extends EntityID {
    // 用户名
    private String username;
    // 昵称
    private String nickname;
    // 用户经验
    private int experience;
    // 积分
    private int points;
    // 头像
    private String avatar;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", nickname='" + nickname + '\'' +
                ", experience=" + experience +
                ", points=" + points +
                ", avatar='" + avatar + '\'' +
                '}';
    }
}
