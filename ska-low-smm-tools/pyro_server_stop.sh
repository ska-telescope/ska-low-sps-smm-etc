#!/bin/bash
for KILLPID in `ps ax | grep 'subrack_monitor.py' | awk '{print $1;}'`; do
kill -9 $KILLPID;
done
rm /run/lock/mngfpgai2c.lock
