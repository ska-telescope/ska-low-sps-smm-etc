#!/bin/bash
log="/tmp/hw_init.log"

if [ ! -f "/etc/ssh/ssh_host_ed25519_key.pub" ]; then
	echo " = SSH server key missing - running reconfigure" 2>&1 | tee -a $log
	dpkg-reconfigure openssh-server
fi

echo " = Running /etc/ska-low-smm-tools/config_ip_from_e2prom.sh" 2>&1 | tee -a $log
/etc/ska-low-smm-tools/config_ip_from_e2prom.sh 2>&1 | tee -a $log

echo " = Running apt list --installed > /etc/apt/packages.list" 2>&1 | tee -a $log
apt list --installed | cut -d[ -f1 > /etc/apt/packages.list | tee -a $log

echo " = Running custom_root restore" 2>&1 | tee -a $log
pushd /etc/ska-low-smm-tools/custom_root
cp -rpv . / 2>&1 | tee -a $log
popd

if [ -f "/etc/ska-low-smm-tools/hw_init_pll_source_internal" ]; then
	echo " = Running subrack_management_board --init --pll_source_internal" 2>&1 | tee -a $log
	/home/mnguser/SubrackMngAPI/venv/bin/python /home/mnguser/SubrackMngAPI/subrack_mng_api/subrack_management_board.py --init --pll_source_internal 2>&1 | tee -a $log
else
	echo " = Running subrack_management_board --init" 2>&1 | tee -a $log
	/home/mnguser/SubrackMngAPI/venv/bin/python /home/mnguser/SubrackMngAPI/subrack_mng_api/subrack_management_board.py --init 2>&1 | tee -a $log
fi

echo " = Finish" 2>&1 | tee -a $log
exit 0

