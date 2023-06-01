package cn.jxufe.imp;

import cn.jxufe.bean.GameConfig;
import cn.jxufe.bean.WebsocketMessage;
import cn.jxufe.dao.FarmLandStatusDao;
import cn.jxufe.dao.SeedGrowthStageDao;
import cn.jxufe.entity.FarmLandStatus;
import cn.jxufe.entity.SeedGrowthStage;
import cn.jxufe.service.GameService;
import cn.jxufe.websocket.FarmWebsocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;

import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

@Service
public class GameImp implements GameService {
    @Autowired
    private FarmLandStatusDao farmLandStatusDao;
    @Autowired
    private FarmWebsocketHandler farmWebsocketHandler;
    @Autowired
    private SeedGrowthStageDao seedGrowthStageDao;

    @Override
    public List<FarmLandStatus> getLandStatus(String username) {
        return farmLandStatusDao.findByUsername(username);
    }

    @Override
    public void gameStart() {
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                checkCropStatus();
                System.out.println("现在服务器时间是：" + new Date());
            }
        }, 0, GameConfig.__LAND_STATUS_CHECK_INTERVAL * 10000);
    }

    public void checkCropStatus() {
        System.out.println("检查农作物状态");
        List<FarmLandStatus> farmLandNeedUpdate = farmLandStatusDao.findByIsCropAndCropStatusLessThan(
                GameConfig.__LAND_PLANTED_CODE, GameConfig.__CROP_MATURITY_CODE);
        if (farmLandNeedUpdate.size() == 0) {
            System.out.println("没有需要更新的农田状态");
            return;
        }

        Date now = new Date();
        for (FarmLandStatus farmLandStatus : farmLandNeedUpdate) {
            updateCropStatus(farmLandStatus, now);
            farmLandStatusDao.save(farmLandStatus);
            sendCropStatusUpdateMessage(farmLandStatus);
        }
    }

    private static void __reduceCropOutput(FarmLandStatus farmLandStatus) {
        int output = GameConfig.__PEST_REDUCE_OUTPUT() < farmLandStatus.getOutput() ?
                farmLandStatus.getOutput() - GameConfig.__PEST_REDUCE_OUTPUT() : 0;
        farmLandStatus.setOutput(output);
    }

    private void updateCropStatus(FarmLandStatus farmLandStatus, Date now) {
        int cropStatus = farmLandStatus.getCropStatus();
        SeedGrowthStage currStage = seedGrowthStageDao
                .findBySeedIdAndGrowthStage(farmLandStatus.getCropId(), cropStatus);
        Long currStageGrowthEndTime = farmLandStatus.getStateEndTime().getTime();
        float pestProbability = currStage.getPestProbability();

        if (Math.random() < pestProbability && isCropTimeLongEnough(currStageGrowthEndTime, now)) {
            farmLandStatus.setIsInsect(1);
        }

        if (isCurrentStageFinished(currStageGrowthEndTime, now)) {
            int nextCropStatus = cropStatus + 1;
            SeedGrowthStage nextStage = seedGrowthStageDao.findBySeedIdAndGrowthStage(
                    farmLandStatus.getCropId(), nextCropStatus);
            int nextStageGrowthTime = nextStage.getGrowthTime();

            farmLandStatus.setCropStatus(nextCropStatus);
            farmLandStatus.setStateEndTime(new Date(nextStageGrowthTime * 1000 + currStageGrowthEndTime));
            farmLandStatus.setCurrentStateHasGrownTime(0);
            if (farmLandStatus.getIsInsect() == 1) {
                __reduceCropOutput(farmLandStatus);
            }
            if (nextCropStatus == GameConfig.__CROP_MATURITY_CODE) {
                farmLandStatus.setIsMature(1);
            }
        }
        farmLandStatus.setCurrentStateHasGrownTime(
                farmLandStatus.getCurrentStateHasGrownTime() + GameConfig.__LAND_STATUS_CHECK_INTERVAL);
    }

    private boolean isCropTimeLongEnough(long currStageGrowthEndTime, Date now) {
        return currStageGrowthEndTime - now.getTime() > 1000 * GameConfig.__LAND_STATUS_CHECK_INTERVAL * 2;
    }

    private boolean isCurrentStageFinished(long currStageGrowthEndTime, Date now) {
        return now.getTime() >= currStageGrowthEndTime;
    }

    private void sendCropStatusUpdateMessage(FarmLandStatus farmLandStatus) {
        String landOwner = farmLandStatus.getUsername();
        farmWebsocketHandler.sendMessageToUser(landOwner,
                new TextMessage(new WebsocketMessage(1, farmLandStatus).toString()));
    }
}
