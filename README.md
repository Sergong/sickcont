# sickcont
This repo houses the `Dockerfile` to create a Docker/Podman container for Sickchill with Transmission and Wireguard.
This `Dockerfile` should work on either `x86_64` or `arm64` processor architectures. It has been tested on `arm64`.

This is based on the `docker-wireguard` container created by the folks from linuxserver. Their git repo is [here](https://github.com/linuxserver/docker-wireguard).
The sickchill install in the `Dockerfile` was taken from the folks at linuxserver as well, using relevant parts from the following [`Dockerfile`](https://github.com/linuxserver/docker-sickchill/blob/master/Dockerfile.aarch64) 

It also contains a shell scripts to start the container with docker, tested on Docker on macOS.

The container should create a WireGuard tunnel on startup. based on a WireGuard conf file in the `config/wg_confs` directory. 

The assumption is that you know how to build docker containers from a Dockerfile.

## Directory Structure

Ensure that the directory structure referenced by the `-v` volume mounts in the shell script are  present on your system.

So for the docker shell script example here `start-sickcont.sh`, you'd need to create the following directories under the config directory in this repo:
- `mkdir config/data`
- `mkdir config/tv`

## Shell scripts

The following sections contain example shell scripts to launch the docker/podman container. Make sure you check the following for your particular system/scenario:
- volume mounts
- UID of the user on your docker host system should match the `-e PUID` in the script 
- GID of the primary group of your user on your docker host system should match the `-e PGID` in the script 
- Ensure the name of the docker container matches with the name of the docker container you tagged your container with at build time

### Shell script for podman on Fedora

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

### Shell script for docker

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
