package com.splendor.core.annotation;

import java.lang.annotation.*;

/**
 * @author splendor.s
 * @create 2022/8/30 下午5:25
 */
@Documented
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface DistributedLock {

    /**
     * 锁的名称
     */
    String value() default "redisson";

    /**
     * 锁的有效时间
     */
    int leaseTime() default 10;
}