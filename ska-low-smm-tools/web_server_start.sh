#!/bin/bash
echo 2 > /sys/bus/platform/devices/8000400.skamngled/parameters/Led_3
/home/mnguser/SubrackMngAPI/venv/bin/python /home/mnguser/SubrackMngAPI/web_server/web_server.py
