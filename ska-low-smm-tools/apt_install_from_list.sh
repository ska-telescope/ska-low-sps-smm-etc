#!/bin/bash
filename=$1

n=1
list_packages=""
while read line; do
	# reading each line
	if [ "$n" -gt 1 ]; then
		package=`echo $line | cut -d/ -f1`
		version=`echo $line | cut -d\  -f2`
		list_packages="$list_packages $package=$version"
	fi
	n=$((n+1))
done < $filename
echo $list_packages
apt install $list_packages

