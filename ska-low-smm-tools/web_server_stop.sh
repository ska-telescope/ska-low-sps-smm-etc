#!/bin/bash
for KILLPID in `ps ax | grep 'web_server.py' | awk '{print $1;}'`; do
kill -9 $KILLPID;
done
rm /run/lock/mngfpgai2c.lock
echo 2 > /sys/bus/platform/devices/8000400.skamngled/parameters/Led_3
