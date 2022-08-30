package com.splendor.core;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author splendor.s
 * @create 2022/8/30 下午9:54
 */
@Slf4j
@EnableScheduling
@SpringBootApplication
public class DistributedLockApplication {

    public static void main(String[] args) {
        SpringApplication.run(DistributedLockApplication.class, args);
        log.info("redis-distributed-lock 项目启动成功!");
    }

}
