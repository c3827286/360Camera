#!/bin/sh
echo " kill old process...."
echo
killall apsta
killall wpa_supplicant
killall udhcpc
killall cuftpd

killall hostapd
killall udhcpd
killall wlandaemon
killall telnetd
killall searchIp

#ensure wpa_supplicant is killed
sleep 1

ifconfig eth0 down
ifconfig wlan0 up

echo " start WiFi...."
echo
sleep 1


wpa_supplicant -iwlan0 -B -c /etc/SNIP39/wpa_supplicant.conf

while [ 1 ]
do
    echo "waiting wlan connect..."
    sleep 1
    iwconfig wlan0 | grep 'ESSID' > /tmp/debug_wlan_connected
    if [ -s /tmp/debug_wlan_connected ]; then
       break
    fi
done

udhcpc -R -i wlan0 -s /etc/udhcpc.script

echo "starting telnet server...."
telnetd

echo "starting Ftp server...."
echo

cp /usr/bin/cuftpd /tmp
cd /tmp
./cuftpd &

echo "done."
echo


