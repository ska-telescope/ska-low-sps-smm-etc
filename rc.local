#!/bin/bash
log="/tmp/rc.local.log"
echo " = Running /etc/ska-low-smm-tools/config_ip_from_e2prom.sh" 2>&1 | tee -a $log
/etc/ska-low-smm-tools/config_ip_from_e2prom.sh 2>&1 | tee -a $log

echo " = Running apt list --installed > /etc/apt/packages.list" 2>&1 | tee -a $log
apt list --installed | cut -d[ -f1 > /etc/apt/packages.list | tee -a $log

echo " = Running custom_root restore" 2>&1 | tee -a $log
pushd /etc/ska-low-smm-tools/custom_root 2>&1 | tee -a $log
sudo cp -rpv . / 2>&1 | tee -a $log
popd 2>&1 | tee -a $log

echo " = Running subrack_management_board --init" 2>&1 | tee -a $log
/home/mnguser/SubrackMngAPI/venv/bin/python /home/mnguser/SubrackMngAPI/subrack_mng_api/subrack_management_board.py --init 2>&1 | tee -a $log

echo " = Finish" 2>&1 | tee -a $log
exit 0

