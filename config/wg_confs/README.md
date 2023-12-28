# Wireguard Configuration Directory

This directory will need to contain a wireguard conf file to ensure all traffic in the container goes through the VPN

See the `README.md` file in the root of this repo for examples of wireguard config files.

> :warning: Ensure you change the **HOMENET** var in the Post Up and Pre Down scripts if your docker host is on a different subnet.
