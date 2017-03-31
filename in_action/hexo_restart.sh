#!bin/bash

# 重启使用Github管理的Hexo博客系统
# 基于Github-hooks回调
# git stash
# git pull
# hexo generate
# hexo server -s -p 4001 > luffy.out 2>&1 &

BLOG_HOME="/home/blog/blog/"
PID_HOME="/var/run/blog"
BLOG_NAME="luffy-blog"
PID_FILE="${PID_HOME}/${BLOG_NAME}.pid"
BLOG_PATH="${BLOG_HOME}/${BLOG_NAME}"
BLOG_CHECK_PATH="${BLOG_HOME}/${BLOG_NAME}.update"
BLOG_OUT="${BLOG_HOME}/${BLOG_NAME}.out"
BLOG_PORT=4001

function restart() {
    if [ ! -f ${PID_FILE} ];
    then
        echo "Not exist ${BLOG_NAME} PID_FILE!!"
        start
        exit 0
    fi
    pid=`cat ${PID_FILE}`
    if [ -z "${pid}" ] || [ ${pid} -le 0 ];
    then
        echo "${BLOG_NAME} have not running!!"
        start
        exit 0
    fi

    # 杀掉应用
    kill -9 ${pid}
    wait
    start
}

function start() {
    # 1.获取最新版本
    cd ${BLOG_PATH}
    git stash
    git pull
    wait
    git stash drop

    # 2.启动新应用
    hexo generate
    wait
    hexo server -s -p ${BLOG_PORT} > ${BLOG_OUT} 2>&1 &
    blog_pid=$!
    echo "${BLOG_NAME} running on ${blog_pid}"
    echo "${blog_pid}" > ${PID_FILE}
    echo "" > ${BLOG_CHECK_PATH}
    echo "Restart ${BLOG_NAME} finish!!!"
}

# 当存在更新时,才重启应用
if ! [ -f ${BLOG_CHECK_PATH} ];
then
    echo "Not exist ${BLOG_CHECK_PATH}!!"
    exit 0
fi
event=`cat ${BLOG_CHECK_PATH}`
if [ "${event}" = "push" ];
then
    echo "Reveive ${event} from Github-hooks!!"
    restart
fi