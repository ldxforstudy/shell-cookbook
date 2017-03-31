#!/usr/bin/env bash

# 数组和关联数组
arr1=(4 2 3 "x" 5 10)
echo "arr1: ${arr1}"
echo "arr1.length: ${#arr1[@]}"

for arr_item in ${arr1[@]}
do
    printf "%s " ${arr_item}
done
printf "\n"
