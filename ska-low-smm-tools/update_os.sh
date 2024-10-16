#!/bin/bash

PRINT_HELP=false
BRANCH="master"

ROOT=/etc

# Function to display installer help
function display_help(){
    echo "This script will update SubrackMngAPI software in /home/mnguser/SubrackMngAPI."
    echo
    echo "Arguments:"
    echo "-b <branch> specifies branch to be installed [default $BRANCH]"
    echo "-h             Print this message"
    echo ""
    }

# Process command-line arguments
while getopts "hb:uv" flag
do
    case "${flag}" in
        h) PRINT_HELP=true ;;
        b) BRANCH=${OPTARG} ;;
        u) UPDATE=false ;;
        v) CLEAN_VENV=false ;;
        \?)                                    # If expected argument omitted:
           echo "Error: missing argument."
           exit 1                   # Exit abnormally.
           ;;
    esac
done

# Check if printing help
if [ $PRINT_HELP == true ]; then
    display_help
    exit
fi

echo "Updating repository with online version"
git -C $ROOT checkout $BRANCH || { echo 'cmd failed' ; exit 1; }
git -C $ROOT pull || { echo 'cmd failed' ; exit 1; }


echo "Install configured version of packages"
/etc/ska-low-smm-tools/apt_install_from_list.sh /etc/apt/packages.list

echo "Restore /etc/ssl/certs from archive"
tar -xvzf /etc/ssl/certs.tgz -C /etc

echo ""
echo "System reboot required to apply changes"
