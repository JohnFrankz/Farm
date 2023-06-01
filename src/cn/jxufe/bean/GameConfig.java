package cn.jxufe.bean;

import java.util.Random;

public class GameConfig {
    /** session中存放用户的key */
    public static final String __DEFAULT_USER_NAME_SESSION = "user";
    /** 服务器检查作物状态的时间间隔 */
    public static final int __LAND_STATUS_CHECK_INTERVAL = 2;
    /** 作物成熟阶段的code */
    public static final int __CROP_MATURITY_CODE = 3;
    /** 作物枯草阶段的code */
    public static final int __CROP_DRY_CODE = 4;
    /** 表示土地已种植的code */
    public static final int __LAND_PLANTED_CODE = 1;
    /** 表示因为害虫而减少的作物产量 */
    public static int __PEST_REDUCE_OUTPUT() {
        return new Random().nextInt(2) + 1;
    }
}
