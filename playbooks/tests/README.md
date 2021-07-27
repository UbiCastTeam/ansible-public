# Description

Theses playbooks are used to check the prerequisites before deployement.

# Prerequisites

- A complete inventory of the planned deployment (mediaserver, mediaworker, ...)
- The proxy URL if there is applicable

# Ansible

## Usage examples

* To test firewall rules

```
cd <envsetup dir>/ansible
ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook -i inventory/<inventory name> playbooks/tests/firewall-rules.yml
```

* To test /data partiton 

```
cd <envsetup dir>/ansible
ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook -i inventory/<inventory name> playbooks/tests/data-partition.yml
```

