# Script with routing & fw rules to allow access to sickchill and transmission sites from the docker host
#
DROUTE=$(ip route | grep default | awk '{print $3}')
HOMENET=192.168.0.0/16
ip route add $HOMENET via $DROUTE
iptables -I OUTPUT -d $HOMENET -j ACCEPT
