#!/usr/bin/env bash

# 通过传入参数,指定需要展示的列
if [ $# -ne 2 ];
then
echo "Usage: $0 filename"
exit -1
fi

filename=$1
col=$2

cut -f ${col} -d "|" ${filename} 2>/dev/null
last_cmd_code=$?
if [ ${last_cmd_code} -ne 0 ]; then
echo "Error!"
fi