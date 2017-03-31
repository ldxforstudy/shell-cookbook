#!/usr/bin/env bash

# 自动部署redis应用
PID=`ps -e -o 'pid,command' | grep 'redis' | grep -v 'grep' | awk ' BEGIN { FS=" "; } { print $1} '`
if [ ! -z "${PID}" ]; then
    echo "PID: ${PID}"
    else
    echo "Redis server not running!!"
    exit 0
fi

echo "Before kill!!"
kill -9 ${PID}
sleep 2