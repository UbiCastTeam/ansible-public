**Description**

This playbook is deploying `apt-cacher-ng` on the Nudgis Manager to allow other servers from the infrastructure to proxy their `apt` repositories queries through it.
It also configures the `apt` repository files from every host member of the `ubicast` ansible group to proxy their `apt` queries through the `apt-cacher-ng` from the Nudgis Manager.

**Prerequisites**

You should provide a working inventory (with one member in the `manager` groups).
The `manager` host should have a direct access to the repositories it proxies.

**Note:** If you have a mandatory proxy, it is recommended to operate the `playbooks/system/proxy` after this one, as it configures `apt-cacher-ng` when it is installed.

**Usage**

```bash
ansible-playbook -i inventories/<inventory> playbooks/nudgis/apt_cacher/deploy.yml
```
