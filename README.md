# R1soft Server Backup Manager

![Docker Build Status](https://img.shields.io/docker/build/boro/r1soft-server-backup-manager.svg) ![Docker Automated build](https://img.shields.io/docker/automated/boro/r1soft-server-backup-manager.svg) ![MicroBadger Size](https://img.shields.io/microbadger/image-size/boro/r1soft-server-backup-manager/latest.svg)

![Docker Pulls](https://img.shields.io/docker/pulls/boro/r1soft-server-backup-manager.svg) ![Docker Stars](https://img.shields.io/docker/stars/boro/r1soft-server-backup-manager.svg)

More information on R1soft Server Backup Manager (SBM): [R1soft SBM Wiki](http://wiki.r1soft.com/display/ServerBackupManager/Getting+Started)

## Environment Variables
| Environment Variable | Required? | Example Value | Description |
|----------------------|-----------|---------------|-------------|
| `CDP_USERNAME` | Yes | `humpty` | Sets the username for the CDP Server |
| `CDP_PASSWORD` | Yes | `dumpty` | Sets the password for the CDP Server |
| `CDP_HTTP_PORT` | Yes | `80` | Sets the HTTP Port for the CDP Server |
| `CDP_HTTPS_PORT` | Yes | `443` | Sets the HTTPS Port for the CDP Server |
| `CDP_MAX_MEM` | No | `256m` or `1g` | Sets the maximum memory the server should acquire |

## Important Data Volumes
**IMPORTANT**: You should mount a host directory for all of the following container directories.

| Container Directory Path |
|------|
| `/usr/sbin/r1soft/data` |
| `/usr/sbin/r1soft/conf` |
| `/usr/sbin/r1soft/log` |

## Example Usage
```bash
docker run \
  --restart unless-stopped \
  -p 80:80 \
  -p 443:443 \
  -p 9080:9080 \
  -p 9443:9443 \
  -v /volume/on/host/data:/usr/sbin/r1soft/data \
  -v /volume/on/host/conf:/usr/sbin/r1soft/conf \
  -v /volume/on/host/log:/usr/sbin/r1soft/log \
  boro/r1soft-server-backup-manager:latest
```

## Migration
1. Stop container on the old host
2. Copy the host-attached volumes to your new docker host
3. Start container on new host

## Contribute
Pull Requests are always welcome. Let's connect!

## Donations
Donations are always appreciated but never required.

Monero (XMR): 
`43xXA3AsQVx1nDaoRUQPrSN9xQi6FDU181Dsiz3diUbi9NJUyb8LTy4NisH8uqEML1Se7GuHnhUaSKeuQj3dESUr5jpYFgX`