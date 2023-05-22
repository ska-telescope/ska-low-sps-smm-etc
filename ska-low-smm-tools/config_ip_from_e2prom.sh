int2ip()
{
    result=""
    local ui32=$1; shift
    local ip n
    for n in 1 2 3 4; do
        result=$((ui32 & 0xff))${result:+.}$result
        ui32=$((ui32 >> 8))
    done
#    echo $result
}

reg=`cat /sys/bus/platform/devices/8000100.skamngethregs/parameters/IP`
int2ip $reg
cpld_ip=$result
reg="$(($reg-6))"
int2ip $reg
cpu_ip=$result
reg=`cat /sys/bus/platform/devices/8000100.skamngethregs/parameters/Netmask`
int2ip $reg
netmask=$result
reg=`cat /sys/bus/platform/devices/8000100.skamngethregs/parameters/Gateway`
int2ip $reg
gateway=$result

echo -e "cpld_ip: " $cpld_ip
echo "Network configuration:"
echo -e "cpu_ip:  " $cpu_ip
echo -e "netmask: " $netmask
echo -e "gateway: " $gateway

conf="/etc/network/interfaces"
echo "# interfaces(5) file used by ifup(8) and ifdown(8)" | tee $conf
echo "# Include files from /etc/network/interfaces.d:" | tee -a $conf
echo "# WARNING!!! This file will be overwritten at boot by hw_init.service" | tee -a $conf
echo "source-directory /etc/network/interfaces.d" | tee -a $conf
echo "" | tee -a $conf
echo "auto eth0" | tee -a $conf
echo "allow-hotplug eth0" | tee -a $conf
echo "iface eth0 inet static" | tee -a $conf
echo "	address $cpu_ip" | tee -a $conf
echo "	netmask $netmask" | tee -a $conf

sleep 1
systemctl restart networking
ip route add default via $gateway dev eth0
echo nameserver 8.8.8.8 | tee /etc/resolv.conf 
echo nameserver 8.8.4.4 | tee -a /etc/resolv.conf 

sleep 3
ntpdate $gateway
