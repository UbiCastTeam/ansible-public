# Description

The envsetup `live` group includes all the hosts that will process lives streams.
In a standard Ubicast case, the host is the same as the mediaserver.
In a HA Ubicast case, the live is usually a cluster of two dedicated servers behind a loadbalancer VIP setup in active/backup.

# Prerequisites

The `live` group playbooks actions **must** be played after the `mediaserver` playbook actions otherwise the `live` playbook will throw an error when configuring nginx on the `mediaserver` hosts.

# Usage

## Description

You can setup a standard case by setting the `ip_live` value to `127.0.0.1` in your inventory (or leave it blank as it is the default value).
For a HA case, you will have to setup the live cluster VIP address in the `ip_live` variable.

# Ansible

## Inventory variables

| Type | Name        | Default      | Description                             |
|------|-------------|--------------|-----------------------------------------|
| Base | ip_live     | 127.0.0.1    | IP/DNS to reach the live server/cluster from the MediaServer point of view |
| HA   | live_domain | live.live.fr | Domain name of the live cluster         |
| HA   | tmpfs_size  | 2048m        | Size of the tmpfs storing the live chunks (unit g or m) |

**Note**: See the [ubicast prerequisites](https://docs.google.com/document/d/1vAfLq1hgPMYoTlcCs9-yGHfaKdwKirSmpfic1DwfnXo/edit#heading=h.6txdj6tamlvd) for details on the tmpfs size (Although 2048m should cover most of the non-intensive cases)

## Usage examples

### Standard case

* To deploy the live cluster with a global deployment

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/site.yml
```

* To deploy only the live cluster and the Ubicast global tools

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/live/deploy-standalone.yml
```

* To deploy only the live cluster without the Ubicast global tools

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/live/deploy-minimal.yml
```

### HA case

* To deploy the live cluster with a global deployment

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/site.yml
```

* To deploy only the live cluster and the Ubicast global tools

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/live/deploy-standalone.yml
```

* To deploy only the live cluster without the Ubicast global tools

```
cd <envsetup dir>/ansible
ansible-playbook -i inventory/<inventory name> playbooks/live/deploy-minimal.yml
```
