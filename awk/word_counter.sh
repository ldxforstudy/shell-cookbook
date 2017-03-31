#!/usr/bin/env bash

# 统计文件中单词出现频次
if [ $# -ne 1 ]; then
    echo "Usage: $0 filename"
    exit -1
fi

filename=$1
# 使用 egrep 来辨识出单词，并使用 -o 选项使输出内容按照换行符切割
egrep -o "\b[[:alpha:]]+\b" ${filename} |
awk '{ count[$0]++ } END { printf("%-14s%s\n", "Word", "Count"); for(ind in count) { printf("%-14s%d\n", ind, count[ind]);}}'