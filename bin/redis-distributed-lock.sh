#!/bin/bash
#
#
export PATH="/usr/java/latest/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
export SYS_ID="redis-distributed-lock"
SERVICE_MAIN_CLASS="com.splendor.core.DistributedLockApplication"

# 配置文件地址
export APP_CONFIG_PATH="/app/war/${SYS_ID}/conf"

export JAVA_OPTS="-Xms1g -Xmx1g -Xmn536m -XX:PermSize=256m -Dfile.encoding=UTF-8  -XX:MaxPermSize=256m -Xss512k -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseFastAccessorMethods -XX:ParallelCMSThreads=8 -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=80"
export JAVA_OTHER_OPTS="-Djava.net.preferIPv4Stack=true -Dlog.path=/app/war/$SYS_ID/package/logs -Dspring.profiles.active=pro"

#自动识别PID和lib目录文件
PID=`jps -l |grep "$SERVICE_MAIN_CLASS"|grep -v grep  |awk '{print $1}'`
#PID=`netstat -ntpl 2>/dev/null|grep "$SYS_PORT"|grep -v grep  |awk '{print $7}' |awk -F/ '{print $1}'`
LIB_JARS=$(ls /app/war/$SYS_ID/package/lib | grep ".jar" |awk '{print "'/app/war/$SYS_ID/package/lib'/"$0}'|tr "\n" ":")

#控制台日志
STDOUT_FILE=/app/war/$SYS_ID/package/logs/stdout.log
#STDOUT_FILE="/dev/null"

case "$1" in
    start)
         if [ -z "$PID" ];then
           echo "Start jar $SYS_ID"
           eval java $JAVA_OPTS $JAVA_JMX_OPTS $JAVA_OTHER_OPTS -classpath /app/war/$SYS_ID/conf:$LIB_JARS $SERVICE_MAIN_CLASS &>> $STDOUT_FILE &
           sleep 5
           PID=`jps -l |grep "$SERVICE_MAIN_CLASS"|grep -v grep  |awk '{print $1}'`
#           PID=`netstat -ntpl 2>/dev/null |grep "$SYS_PORT"|grep -v grep  |awk '{print $7}' |awk -F/ '{print $1}'`
           echo "jar $SYS_ID  running pid:${PID}"
         else
            echo $"$SYS_ID already running:${PID}"
            exit 0
         fi
    ;;

    stop)
        if [ -n "$PID" ];then
           echo "Stop jar $SYS_ID $PID"
          kill  $PID
          sleep 5
        else
          echo "jar $SYS_ID is not running!"
        fi
    ;;
    restart)
       echo "restart jar ${SYS_ID} ..."
       $0 stop
       sleep 3
       $0 start
    ;;
    *)
       echo $"Usage: $0 {start|stop|restart}"
        exit 1
    ;;
 esac
 exit 0
