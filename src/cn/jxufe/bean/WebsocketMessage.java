package cn.jxufe.bean;

import cn.jxufe.entity.FarmLandStatus;

public class WebsocketMessage {
    private int code;
    private FarmLandStatus farmLandStatus;

    public WebsocketMessage(int code, FarmLandStatus farmLandStatus) {
        this.code = code;
        this.farmLandStatus = farmLandStatus;
    }

    public WebsocketMessage() {}

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public FarmLandStatus getFarmLandStatus() {
        return farmLandStatus;
    }

    public void setFarmLandStatus(FarmLandStatus farmLandStatus) {
        this.farmLandStatus = farmLandStatus;
    }

    @Override
    public String toString() {
        return "WebSocketMessage{" +
                "code=" + code +
                ", farmLandStatus=" + farmLandStatus +
                '}';
    }
}
