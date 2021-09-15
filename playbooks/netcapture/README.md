# Description

The envsetup `netcapture` group includes all the hosts that will host netcapture instances.

# Prerequisites

The `netcapture` group need on targeted hosts:
- an access to ubicast repository
- an ubicast user

# Usage

## Description

Netcapture rely on LXC, the network can be configured in different ways. 
- Masquerade bridge: independent private bridge, netcapture instances can't reach host network
- Host bridge: host shared network bridge, netcapture instances share the network with the host (allows the use of the NDI protocol)

# Ansible

## Inventory variables

| Type | Name                       | Default                         | Description                                                          |
|------|----------------------------|---------------------------------|----------------------------------------------------------------------|
| All  | lxc_network_type           | masquerade_bridge               | Netcaptures instances network access: masquerade_bridge, host_bridge |
| All  | netcapture_mm_url          | https://mirismanager.ubicast.eu | MiriManager URL for Netcaptures remote access, package download, ... |
| All  | netcapture_mm_ssl          | true                            | MirisManager certificate validation                                  |
| All  | netcapture_conf_folder     | /etc/miris/conf                 | Netcaptures configuration folder on host                             |
| All  | netcapture_media_folder    | /data/netcapture/media          | Netcaptures media folder on host                                     |
| All  | netcapture_pkg_folder      | /data/netcapture/packages       | Netcaptures package folder on host                                   |
| All  | netcapture_hw_acceleration | false                           | Netcaptures hardware acceleration                                    |
| All  | netcapture_miris_user_pwd  | ?                               | Netcaptures authentification on MiriManager                          |
| All  | netcapture_miris_auth      | true                            | Netcaptures authentification on MiriManager                          |   

## Usage examples

* To deploy the netcapture with a global deployment

```
ansible-playbook -i inventory/<inventory name> playbooks/site.yml
```

* To deploy only the netcapture and the Ubicast global tools

```
ansible-playbook -i inventory/<inventory name> playbooks/netcapture/deploy-standalone.yml
```

* To deploy only the netcapture without the Ubicast global tools

```
ansible-playbook -i inventory/<inventory name> playbooks/netcapture/deploy-minimal.yml
```

