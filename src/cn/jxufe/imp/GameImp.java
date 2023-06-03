package cn.jxufe.imp;

import cn.jxufe.bean.GameConfig;
import cn.jxufe.bean.Message;
import cn.jxufe.bean.WebsocketMessage;
import cn.jxufe.dao.*;
import cn.jxufe.entity.*;
import cn.jxufe.service.GameService;
import cn.jxufe.utils.MessageUtils;
import cn.jxufe.websocket.FarmWebsocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import java.util.*;

@Service
public class GameImp implements GameService {
    @Autowired
    private FarmLandStatusDao farmLandStatusDao;
    @Autowired
    private FarmWebsocketHandler farmWebsocketHandler;
    @Autowired
    private SeedGrowthStageDao seedGrowthStageDao;
    @Autowired
    private SeedDao seedDao;
    @Autowired
    private UserBagDao userBagDao;
    @Autowired
    private UserDao userDao;

    /**
     * 获取土地状态列表。
     * 返回指定用户的土地状态列表，固定为24个土地，根据索引补全缺失的土地。
     * 如果数据库中查出的土地状态不足24个，则根据土地索引补全数据，并保存到数据库中。
     *
     * @param username 用户名
     * @return 土地状态列表，固定为24个土地
     */
    @Override
    public List<FarmLandStatus> getLandStatus(String username) {
        List<FarmLandStatus> landStatusList = farmLandStatusDao.findByUsername(username);
        List<FarmLandStatus> completeLandStatusList = new ArrayList<>(GameConfig.__LAND_AMOUNT);
        Map<Integer, FarmLandStatus> existingIndices = new HashMap<>();
        List<FarmLandStatus> newLandStatusList = new ArrayList<>();

        if (landStatusList.size() == GameConfig.__LAND_AMOUNT) {
            return landStatusList;
        }

        for (FarmLandStatus landStatus : landStatusList) {
            existingIndices.put(landStatus.getLandIndex(), landStatus);
        }
        for (int i = 0; i < GameConfig.__LAND_AMOUNT; i++) {
            if (existingIndices.containsKey(i)) {
                completeLandStatusList.add(existingIndices.get(i));
            } else {
                FarmLandStatus landStatus = new FarmLandStatus();
                landStatus.setUsername(username);
                landStatus.setLandIndex(i);
                landStatus.setLandType(i / GameConfig.__AMOUNT_OF_EACH_LAND_TYPE + 1);
                landStatus.setIsCrop(GameConfig.__LAND_UNPLANTED_CODE);
                completeLandStatusList.add(landStatus);
                newLandStatusList.add(landStatus);
            }
        }

        if (!newLandStatusList.isEmpty()) {
            farmLandStatusDao.save(newLandStatusList);
        }

        return completeLandStatusList;
    }

    @Override
    public void gameStart() {
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                checkCropStatus();
                System.out.println("现在服务器时间是：" + new Date());
            }
        }, 0, GameConfig.__LAND_STATUS_CHECK_INTERVAL * 1000);
    }
    /**
     * 清除农田上的枯叶。
     * 如果指定农田不存在，返回错误消息。
     * 如果指定农田未种植作物，返回错误消息。
     * 如果指定农田作物的状态处于成熟阶段或成熟阶段之后，表示无需清除枯叶，返回错误消息。
     * 清除枯叶后，将农田的作物状态设置为未种植状态，并保存到数据库中。
     * @param username 用户名
     * @param landIndex 农田索引
     * @return 操作结果消息，成功返回成功消息，失败返回错误消息
     */
    @Override
    @Transactional
    public Message cleanDeadLeaves(String username, int landIndex) {
        User user = userDao.findByUsername(username);
        if (user == null) {
            return MessageUtils.createErrorMessage("用户不存在");
        }

        FarmLandStatus land = farmLandStatusDao.findByUsernameAndLandIndex(username, landIndex);
        if (land == null) {
            return MessageUtils.createErrorMessage("土地不存在");
        }
        if (land.getIsCrop() == GameConfig.__LAND_UNPLANTED_CODE) {
            return MessageUtils.createErrorMessage("土地未种植");
        }
        if (land.getCropStatus() <= GameConfig.__CROP_MATURITY_CODE ||
            land.getIsWithered() != GameConfig.__LAND_HAS_WITHERED_CODE) {
            return MessageUtils.createErrorMessage("无需清除枯叶");
        }

        user.setExperience(user.getExperience() + GameConfig.__CLEAN_DEAD_LEAVES_ADD_EXP);
        user.setPoints(user.getPoints() + GameConfig.__CLEAN_DEAD_LEAVES_ADD_POINTS);
        land.setIsCrop(GameConfig.__LAND_UNPLANTED_CODE);
        userDao.save(user);
        farmLandStatusDao.save(land);
        return MessageUtils.createSuccessMessage("清除枯叶成功\n经验+" + GameConfig.__CLEAN_DEAD_LEAVES_ADD_EXP +
                                                    "\n积分+" + GameConfig.__CLEAN_DEAD_LEAVES_ADD_POINTS);
    }

    /**
         * 在指定土地上种植作物。
     *
     * @param username  用户名
     * @param landIndex 土地索引
     * @param seedId    种子ID
     * @return 消息对象，包含种植结果信息
     */
    @Override
    @Transactional
    public Message plantCrop(String username, int landIndex, int seedId) {
        if (landIndex >= GameConfig.__LAND_MAX_INDEX) {
            return MessageUtils.createErrorMessage("土地索引超出范围");
        }
        FarmLandStatus land = farmLandStatusDao.findByUsernameAndLandIndex(username, landIndex);
        if (land == null) {
            land = new FarmLandStatus();
        } else if (land.getIsCrop() == GameConfig.__LAND_PLANTED_CODE) {
            return MessageUtils.createErrorMessage("土地已种植");
        }
        Seed seed = seedDao.findBySeedId(seedId);
        SeedGrowthStage seedStage = seedGrowthStageDao.findBySeedIdAndGrowthStage(seedId, GameConfig.__CROP_SEED_CODE);
        UserBag userBag = userBagDao.findByUserNameAndSeedId(username, seedId);
        if (seed == null || seedStage == null) {
            return MessageUtils.createErrorMessage("种子不存在");
        } else if (userBag == null || userBag.getSeedNum() <= 0) {
            return MessageUtils.createErrorMessage("种子数量不足");
        }

        if (seed.getSoil() != (landIndex / GameConfig.__AMOUNT_OF_EACH_LAND_TYPE + 1)) {
            return MessageUtils.createErrorMessage("土地类型不匹配");
        }

        land.setUsername(username);
        land.setLandIndex(landIndex);
        land.setLandType(landIndex / GameConfig.__AMOUNT_OF_EACH_LAND_TYPE + 1);
        land.setIsCrop(GameConfig.__LAND_PLANTED_CODE);
        land.setCropId(seedId);
        land.setCropStatus(GameConfig.__CROP_SEED_CODE);
        land.setCurrentStateHasGrownTime(0);
        land.setStateEndTime(new Date(new Date().getTime() + seedStage.getGrowthTime() * 1000));
        land.setIsInsect(GameConfig.__LAND_NO_INSECT_CODE);
        land.setIsWithered(GameConfig.__LAND_NO_WITHERED_CODE);
        land.setIsMature(GameConfig.__LAND_NO_MATURE_CODE);
        land.setOutput(seed.getHarvest());

        userBag.setSeedNum(userBag.getSeedNum() - 1);

        userBagDao.save(userBag);
        farmLandStatusDao.save(land);
        sendCropStatusUpdateMessage(land);

        return MessageUtils.createSuccessMessage(seed.getSeedName() + "种植成功");
    }

    /****
     * 收获作物。
     * 如果指定用户不存在，返回错误消息。
     * 如果指定农田不存在，返回错误消息。
     * 如果指定农田未种植作物，返回错误消息。
     * 如果指定农田作物的状态不是成熟状态，返回错误消息。
     * 完成收获后，更新用户的经验、积分和金币，并将农田作物的状态设置为干燥状态。
     * 同时向用户发送作物状态更新的消息。
     * @param username 用户名
     * @param landIndex 农田索引
     * @return 操作结果消息，成功返回成功消息，失败返回错误消息
     */
    @Override
    @Transactional
    public Message harvest(String username, int landIndex) {
        if (landIndex >= GameConfig.__LAND_MAX_INDEX) {
            return MessageUtils.createErrorMessage("土地不存在");
        }
        User user = userDao.findByUsername(username);
        if (user == null) {
            return MessageUtils.createErrorMessage("用户不存在");
        }

        FarmLandStatus land = farmLandStatusDao.findByUsernameAndLandIndex(username, landIndex);
        if (land == null) {
            return MessageUtils.createErrorMessage("土地未播种");
        } else if (land.getIsCrop() == GameConfig.__LAND_UNPLANTED_CODE) {
            return MessageUtils.createErrorMessage("土地未种植");
        } else if (land.getCropStatus() != GameConfig.__CROP_MATURITY_CODE
                   || land.getIsMature() != GameConfig.__LAND_HAS_MATURE_CODE) {
            return MessageUtils.createErrorMessage("作物未成熟");
        }

        Seed seed = seedDao.findBySeedId(land.getCropId());
        user.setExperience(user.getExperience() + seed.getExperience());
        user.setPoints(user.getPoints() + seed.getPoints());
        user.setMoney(user.getMoney() + seed.getSalePrice() * land.getOutput());
        land.setIsWithered(GameConfig.__LAND_HAS_WITHERED_CODE);
        land.setCropStatus(GameConfig.__CROP_DRY_CODE);

        sendCropStatusUpdateMessage(land);
        userDao.save(user);
        farmLandStatusDao.save(land);
        return MessageUtils.createSuccessMessage("收获成功\n经验+" + seed.getExperience() +
                                                "、积分+" + seed.getPoints() +
                                                "、金币+" + seed.getSalePrice() * land.getOutput());
    }

    /**
          * 杀虫。
          * 如果指定用户不存在，返回错误消息。
          * 如果指定农田不存在，返回错误消息。
          * 如果指定农田未种植作物，返回错误消息。
          * 如果指定农田没有虫害，返回错误消息。
          * 完成杀虫后，更新用户的经验、积分和金币，并将农田的虫害状态设置为无虫害。
          *同时向用户发送作物状态更新的消息。
     * @param username 用户名
     * @param landIndex 农田索引
     * @return 操作结果消息，成功返回成功消息，失败返回错误消息
     */
    @Override
    @Transactional
    public Message killBug(String username, int landIndex) {
        User user = userDao.findByUsername(username);
        if (user == null) {
            return MessageUtils.createErrorMessage("用户不存在");
        }

        FarmLandStatus land = farmLandStatusDao.findByUsernameAndLandIndex(username, landIndex);
        if (land == null) {
            return MessageUtils.createErrorMessage("土地不存在");
        } else if (land.getIsCrop() == GameConfig.__LAND_UNPLANTED_CODE) {
            return MessageUtils.createErrorMessage("土地未种植");
        } else if (land.getIsInsect() == GameConfig.__LAND_NO_INSECT_CODE) {
            return MessageUtils.createErrorMessage("土地无虫害");
        }

        land.setIsInsect(GameConfig.__LAND_NO_INSECT_CODE);
        user.setExperience(user.getExperience() + GameConfig.__KILL_BUG_ADD_EXP);
        user.setPoints(user.getPoints() + GameConfig.__KILL_BUG_ADD_POINT);
        user.setMoney(user.getMoney() + GameConfig.__KILL_BUG_ADD_MONEY);
        userDao.save(user);
        farmLandStatusDao.save(land);

        sendCropStatusUpdateMessage(land);
        return MessageUtils.createSuccessMessage("杀虫成功\n经验+" + GameConfig.__KILL_BUG_ADD_EXP +
                                                "、积分+" + GameConfig.__KILL_BUG_ADD_POINT +
                                                "、金币+" + GameConfig.__KILL_BUG_ADD_MONEY);
    }


    /**
         * 检查农作物状态，更新需要更新的农田状态。
         * 如果作物的当前状态已经成熟或者超过成熟状态，则不做任何操作。
         * 如果作物的当前状态尚未成熟，根据时间判断是否进入下一个生长阶段，并处理虫害和收获减产。
         * 更新后的农田状态将保存到数据库，并发送更新消息给相关用户。
     */
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

    /**
         * 减少农作物产量。
         * 根据设定的减产值和农田状态的当前产量，计算减产后的产量值。
     * @param farmLandStatus 农田状态对象
     */
    private static void __reduceCropOutput(FarmLandStatus farmLandStatus) {
        int output = GameConfig.__PEST_REDUCE_OUTPUT() < farmLandStatus.getOutput() ?
                farmLandStatus.getOutput() - GameConfig.__PEST_REDUCE_OUTPUT() : 0;
        farmLandStatus.setOutput(output);
    }

    /**
         * 更新农作物的状态。
         * 根据当前农作物状态、当前时间和成长阶段信息，判断是否需要更新农作物的状态，
         * 包括进入下一个生长阶段、处理虫害和收获减产等操作。
         * 更新后的状态将保存到农田状态对象中。
     * @param farmLandStatus 农田状态对象
     * @param now 当前时间
     */
    private void updateCropStatus(FarmLandStatus farmLandStatus, Date now) {
        int cropStatus = farmLandStatus.getCropStatus();
        SeedGrowthStage currStage = seedGrowthStageDao
                .findBySeedIdAndGrowthStage(farmLandStatus.getCropId(), cropStatus);
        Long currStageGrowthEndTime = farmLandStatus.getStateEndTime().getTime();
        float pestProbability = currStage.getPestProbability();

        if (Math.random() < pestProbability && isCropTimeLongEnough(currStageGrowthEndTime, now)) {
            farmLandStatus.setIsInsect(GameConfig.__LAND_HAS_INSECT_CODE);
        }

        if (isCurrentStageFinished(currStageGrowthEndTime, now)) {
            int nextCropStatus = cropStatus + 1;
            SeedGrowthStage nextStage = seedGrowthStageDao.findBySeedIdAndGrowthStage(
                    farmLandStatus.getCropId(), nextCropStatus);
            int nextStageGrowthTime = nextStage.getGrowthTime();

            farmLandStatus.setCropStatus(nextCropStatus);
            farmLandStatus.setStateEndTime(new Date(nextStageGrowthTime * 1000 + currStageGrowthEndTime));
            farmLandStatus.setCurrentStateHasGrownTime(0);
            if (farmLandStatus.getIsInsect() == GameConfig.__LAND_HAS_INSECT_CODE) {
                __reduceCropOutput(farmLandStatus);
            }
            if (nextCropStatus == GameConfig.__CROP_MATURITY_CODE) {
                farmLandStatus.setIsMature(GameConfig.__LAND_HAS_MATURE_CODE);
            }
        }
        farmLandStatus.setCurrentStateHasGrownTime(
                farmLandStatus.getCurrentStateHasGrownTime() + GameConfig.__LAND_STATUS_CHECK_INTERVAL);
    }

    /**
         * 检查作物是否已生长足够长的时间。
         * 用于判断是否应该出现虫害。
     * @param currStageGrowthEndTime 当前生长阶段结束时间
     * @param now 当前时间
     * @return 是否已生长足够长的时间
     */
    private boolean isCropTimeLongEnough(long currStageGrowthEndTime, Date now) {
        return currStageGrowthEndTime - now.getTime() > 1000 * GameConfig.__LAND_STATUS_CHECK_INTERVAL * 2;
    }

    /**
         * 检查当前生长阶段是否已完成。
         * 根据当前时间与当前生长阶段的结束时间进行比较，判断是否已完成该阶段。
     * @param currStageGrowthEndTime 当前生长阶段结束时间
     * @param now 当前时间
     * @return 当前阶段是否已完成
     */
    private boolean isCurrentStageFinished(long currStageGrowthEndTime, Date now) {
        return now.getTime() >= currStageGrowthEndTime;
    }

    /**
         * 发送农田状态更新消息给农田的所有者。
         * 将更新后的农田状态对象封装成消息对象发送给对应的用户。
     * @param farmLandStatus 农田状态对象
     */
    private void sendCropStatusUpdateMessage(FarmLandStatus farmLandStatus) {
        String landOwner = farmLandStatus.getUsername();
        farmWebsocketHandler.sendMessageToUser(landOwner,
                new TextMessage(new WebsocketMessage(1, farmLandStatus).toString()));
    }
}
