package com.splendor.core.strategy;

import com.splendor.core.entity.RedissonProperties;
import org.redisson.config.Config;

/**
 * @author splendor.s
 * @create 2022/8/30 下午5:31
 * @Description: Redisson配置构建接口
 */
public interface RedissonConfigService {

    /**
     * 根据不同的Redis配置策略创建对应的Config
     * @param redissonProperties
     * @return Config
     */
    Config createRedissonConfig(RedissonProperties redissonProperties);
}
