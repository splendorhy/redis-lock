#!/bin/bash
#
export SERVICE_MAIN_CLASS="com.splendor.core.DistributedLockApplication"
#配置文件地址
export APP_CONFIG_PATH="/app/war/${SYS_ID}/conf"

#jvm参数
export JAVA_MEM_OPTS=" -Xms1g -Xmx1g  -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseFastAccessorMethods -XX:ParallelCMSThreads=8 -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=80"
export JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote.port=8089 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
#其他配置（如打印日志字符编码）
export JAVA_OPTS="-Djava.net.preferIPv4Stack=true -Dlog.path=/app/logs -Dspring.profiles.default=pro -Dfile.encoding=UTF-8 -Djava.io.tmpdir=/app/temp"

#自动识别PID和lib目录文件
LIB_JARS=$(ls /app/lib | grep ".jar" |awk '{print "'/app/lib'/"$0}'|tr "\n" ":")

java $JAVA_MEM_OPTS $JAVA_JMX_OPTS $JAVA_OPTS -classpath ${APP_CONFIG_PATH}:$LIB_JARS $SERVICE_MAIN_CLASS
