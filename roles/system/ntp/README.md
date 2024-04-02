# Ntp
## Description

The group handles the installation and configuration of ntp

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ntp_servers`: List of NTP servers to use on the systems (Optional)
```
ntp_servers:
  - 0.debian.pool.ntp.org
  - 1.debian.pool.ntp.org
  - 2.debian.pool.ntp.org
  - 3.debian.pool.ntp.org
```
