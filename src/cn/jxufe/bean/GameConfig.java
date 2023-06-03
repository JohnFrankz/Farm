package cn.jxufe.bean;

import java.util.Random;

public class GameConfig {
    /** session中存放用户的key */
    public static final String __DEFAULT_USER_NAME_SESSION = "user";
    /** 服务器检查作物状态的时间间隔 */
    public static final int __LAND_STATUS_CHECK_INTERVAL = 2;
    /** 作物种子阶段的code */
    public static final int __CROP_SEED_CODE = 1;
    /** 作物成熟阶段的code */
    public static final int __CROP_MATURITY_CODE = 3;
    /** 作物枯草阶段的code */
    public static final int __CROP_DRY_CODE = 4;
    /** 表示土地未种植的code */
    public static final int __LAND_UNPLANTED_CODE = 0;
    /** 表示土地已种植的code */
    public static final int __LAND_PLANTED_CODE = 1;
    /** 表示因为害虫而减少的作物产量 */
    public static int __PEST_REDUCE_OUTPUT() {
        return new Random().nextInt(2) + 1;
    }
    

    /** 土地最大的索引值 */
    public static final int __LAND_MAX_INDEX = 23;
    /** 每种土地类型的拥有的土地数量 */
    public static final int __AMOUNT_OF_EACH_LAND_TYPE = 6;
    /** 表示土地没有害虫的code */
    public static final int __LAND_NO_INSECT_CODE = 0;
    /** 表示土地有害虫的code */
    public static final int __LAND_HAS_INSECT_CODE = 1;
    /** 表示土地没有枯草的code */
    public static final int __LAND_NO_WITHERED_CODE = 0;
    /** 表示土地有枯草的code */
    public static final int __LAND_HAS_WITHERED_CODE = 1;
    /** 表示土地没有成熟的code */
    public static final int __LAND_NO_MATURE_CODE = 0;
    /** 表示土地有成熟的code */
    public static final int __LAND_HAS_MATURE_CODE = 1;


    /** 杀虫增加的经验值 */
    public static final int __KILL_BUG_ADD_EXP = 2;
    /** 杀虫增加的金币 */
    public static final int __KILL_BUG_ADD_MONEY = 1;
    /** 杀虫增加的积分 */
    public static final int __KILL_BUG_ADD_POINT = 2;

    /** 清除枯草增加的经验值 */
    public static final int __CLEAN_DEAD_LEAVES_ADD_EXP = 5;
    /** 清除枯草增加的积分 */
    public static final int __CLEAN_DEAD_LEAVES_ADD_POINTS = 5;

    /** 土地的数量 */
    public static final int __LAND_AMOUNT = 24;
}
