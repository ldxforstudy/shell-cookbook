#!/usr/bin/env bash

NUM=10

if ! [ ${NUM} -le 100 ];
then
    echo "Num is ${NUM}"
else
    echo "Num < 100"
fi