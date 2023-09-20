# Changelog

## v0.10.0 (2023-09-20)

### Features
 - installed pv to support SubrackMngAPI deploy.py improved output
 - sudores update

## v0.9.0 (2023-07-13)

### Features
 - Heartbeat led (LED3) turns from red to green when web_server running
 - sudores update

## v0.8.0 (2023-06-05)

### Features
 - update script `ska-low-smm-tools/update_os.sh`
 - installed rsync and tcpdump for debug

### Bug Fixes
 - mnguser's home ownership

## v0.7.0 (2023-05-24)

### Features
 - Set PLL source internal mode when `/etc/ska-low-smm-tools/hw_init_pll_source_internal` exists

## v0.6.0 (2023-05-22)

### Features
 - Linux Debian 10
 - Python 3.8.14
 - Network configuration from SMM non-volatile memory at boot (standalone mode) (WARNING, `/etc/network/interfaces` will be overwritten at boot by hw_init.service)
 - Hardware initialization as standard service with PLL configuration (external source) at boot
 - web_server as standard service, enabled at boot
 - custom `.bashrc` for python venv activation (WARNING, this file will be overwritten at boot by hw_init.service)



