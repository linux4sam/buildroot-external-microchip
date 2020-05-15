#!/bin/bash

how_many_touches=10

touch_detected=0
while [ "$touch_detected" -lt "$how_many_touches" ]; do
timeout 0.1s evtest /dev/input/event0 > touchscreen_log.txt

grep "type 1 (EV_KEY), code 148 (KEY_PROG1), value 1" touchscreen_log.txt &>/dev/null
    if [[ $? != 0 ]]; then &>/dev/null
        echo 'No touch detected' &>/dev/null
    else touch_detected=$[$touch_detected+1] &>/dev/null
        bash photo.sh
        sleep 1
    fi
    echo $touch_detected &>/dev/null
done
