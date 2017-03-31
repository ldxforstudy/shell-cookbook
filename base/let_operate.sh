#!/usr/bin/env bash

# let运算
num1=4
num2=5

echo "let运算"
let res=num1+num2
echo ${res}

let res++
echo "after let++: ${res}"

# (())运算
echo "(())运算"
res1=$(( res + 5 ))
echo "res1: ${res1}"

# []运算
echo "[]运算"
res2=$[ res1 + 5]
echo "res2: ${res2}"
