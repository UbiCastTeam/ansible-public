# Description

The envsetup `mediacache` group includes all the hosts that will be installed as cache servers for the Ubicast solution medias.
These hosts should be dedicated to the MediaCache solution.

# Prerequisites

The `mediacache` playbooks **must** be played after the `mediaserver` and `live` playbooks actions.

# Ansible

## Inventory variables

| Mandatory | Name                   | Default                          | Description                                    |
|-----------|------------------------|----------------------------------|------------------------------------------------|
| Yes       | mediacache_url         |                                  | Domain name of the cache server                |
| Yes       | ms_url                 |                                  | Domain name of the mediaserver cluster/server  |
| Yes       | mediacache_vod_folder  | /var/cache/nginx/mediacache-vod  | Folder for the VOD cache storage               |
| Yes       | mediacache_vod_size    |                                  | Size of the VOD cache storage in GB            |
| No        | live_url               |                                  | Domain name of the live cluster/server         |
| No        | mediacache_live_folder | /var/cache/nginx/mediacache-live | Folder for the live cache storage              |
| No        | mediacache_live_size   | 1                                | Size of the live cache storage in GB           |

**Note**: The `live_url`, `mediacache_live_folder` and `mediacache_live_size` becomes mandatory if you want to configure a cache on the live medias

## Usage examples

* To deploy the live cluster with a global deployment

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/site.yml
```

* To deploy only the live cluster and the Ubicast global tools

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/mediacache.yml
```
