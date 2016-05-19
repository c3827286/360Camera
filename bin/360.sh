#!/bin/sh

killall -9 ledCtrl
ledCtrl -t green -m flicker &

#patch for fw version < 2.3.41
/usr/bin/snx_rst -n

ifconfig lo up
ifconfig wlan0 up

mkdir /var/log
mkdir /var/run

cat /etc/SNIP39/default.conf | grep OperationMode=0 > /tmp/is_bind
if [ -s /tmp/is_bind ]; then
	opus_play -i /etc/notify/welcome.opus
else
	opus_play -i /etc/notify/nosound.opus
fi
rm /tmp/is_bind

cp -f /etc/SNIP39/logo80x32.* /tmp
cp -f /etc/SNIP39/logo160x64.* /tmp

killall apsta
/usr/bin/apsta.sh
