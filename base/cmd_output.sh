#!/usr/bin/env bash

ls_out1=$(ls -al | cat -n)
printf "ls_out1:\n ${ls_out1} \n"

sleep 5

ls_out2=`ls -al | cat -n`
printf "ls_out2:\n ${ls_out2} \n",
wait