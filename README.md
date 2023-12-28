# sickcont
This repo houses the Dockerfile to create a Docker/Podman container for Sickchill with Transmission and Wireguard.
This `Dockerfile` should work on either x86_64 or arm64 processor architectures. It has been tested on arm64.

This is based on the docker_wireguard container created by the folks from linuxserver. Git repo is [here](https://github.com/linuxserver/docker-wireguard).
The sickchill install in the `Dockerfile` was taken from the folks at linuxserver as well, using relevant parts from the following [`Dockerfile`](https://github.com/linuxserver/docker-sickchill/blob/master/Dockerfile.aarch64) 

It also contains a shell script to start the container with docker, tested on Docker on macOS.

The container should create a WireGuard tunnel on startup. based on a WireGuard conf file in the `config/wg_confs` directory. 

## Shell script for podman on Fedora

The following is a shell script that will work with podman on Fedora:

```
[Interface]
Address = [client_ip_address]
PrivateKey = [client privkey]
DNS = [dns_server_ip_list delimited with comma]
[Peer]
PublicKey = [endpoint_pubkey]
AllowedIPs = 0.0.0.0/0
Endpoint = [wg_endpoint:port]
```

## Shell script for docker

The following is a shell script that work with docker (only tested on macOS with Apple Silicon).

```
[Interface]
Address = [client_ip_address]
PrivateKey = [client privkey]
DNS = [dns_server_ip_list delimited with comma]
PostUp = /etc/wireguard/post-up.sh
PreDown = /etc/wireguard/pre-down.s

[Peer]
PublicKey = [endpoint_pubkey]
AllowedIPs = 0.0.0.0/0
Endpoint = [wg_endpoint:port]
```
