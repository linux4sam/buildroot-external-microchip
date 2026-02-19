#!/bin/bash

line=$(modetest | grep -m1 -oP '#0 (\d+)x(\d+)' | head -1 | sed 's/^#0\s*//')

if [[ -n "$line" ]]; then
  if [ "$line" == "1280x800" ]; then
    /usr/bin/mgs_quickstart_1280x800_design
  elif [ "$line" == "800x480" ]; then
    /usr/bin/mgs_quickstart_800x480_design
  elif [ "$line" == "1024x600" ]; then
    /usr/bin/mgs_quickstart_1024x600_design
  elif [ "$line" == "720x1280" ]; then
    /usr/bin/mgs_quickstart_720x1280_design
  else
    /usr/bin/mgs_quickstart_800x480_design
  fi
fi
