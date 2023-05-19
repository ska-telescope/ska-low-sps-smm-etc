#!/bin/bash
for KILLPID in `ps ax | grep 'subrack_monitor' | awk '{print $1;}'`; do
kill -9 $KILLPID;
done
