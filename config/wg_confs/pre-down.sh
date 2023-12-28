# script to remove the routing and fw rules when wireguard tunnel goes down
#
DROUTE=$(ip route | grep default | awk '{print $3}')
HOMENET=192.168.0.0/16
ip route del $HOMENET via $DROUTE
iptables -D OUTPUT -d $HOMENET -j ACCEPT
