#!/bin/bash
for KILLPID in `ps ax | grep 'web_server' | awk '{print $1;}'`; do
kill -9 $KILLPID;
done
