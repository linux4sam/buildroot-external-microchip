#!/bin/bash
DATE=$(date +%Y%m%d)
filename="${DATE}.png"
num=0
while [ -f $filename ]; do
    num=$(( $num + 1 ))
    filename="${DATE}-${num}.png"
done
touch $filename

fswebcam -p RGB565 -r 3264x2464 -S 10 $filename
