#!/bin/bash

# 以一台机器作为分发机,此脚本在分发机上执行.
# 前提条件:
#   1.分发机的SSH公钥已经配置到各接收机的~/.ssh/authorized_keys
#   2.root用户操作
#   3.当前只支持单个文件
# 入参:
#   bash $SOME_PATH/scp_sync_all_hosts src_file dest_file
#   src_file: 分发机上的文件
#   dest_file: 接收机放置src_file的位置
#

DEST_HOSTS="l22-232-2 l22-232-3 l22-232-4 l22-232-5 l22-232-6 w22-232-7 l22-232-8 l22-232-9 l22-232-10 l22-232-11
l22-232-13 l22-232-14 l22-232-18 l22-232-19 l22-244-12 l22-244-13 l22-244-14 l22-244-15 l22-244-16
l22-244-17 l22-244-18 l22-244-19 l22-244-20 l22-244-21"
SSH_PORT=30000

if [ $# -ne 2 ];
then
    echo "Invalid input, Usage: $0 src_file dest_file"
    exit 1
fi

src=${1}
dest=${2}
host_arr=($DEST_HOSTS)
len=${#host_arr[*]}

_B=''
_I=0
_F=$(( 100/${len} ))
# echo "len is ${len}, _F is ${_F}"
flag=""
for host in ${host_arr[*]}
do
    printf "progress:[%-50s]%d%%\r" ${_B} ${_I}
    scp -P ${SSH_PORT} ${src} root@${host}:${dest} > /dev/null 2>&1
    if [ $? != 0 ];
    then
        flag=${host}
        break
    fi

    _I=$(( $_I + _F))
    _B="##${_B}"
done
if [ -n "${flag}" ];
then
    printf "Failed, please check [%s] SSH configuration.\n" ${flag}
    exit 1;
fi
printf "progress:[%-50s]%d%%\r" ${_B} 100
echo