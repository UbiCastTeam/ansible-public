# Configuration

## SSH

The Ansible deployment will be done through SSH, so you must be able to connect to all the involved hosts by using SSH public key authentication.

To create a key pair:

```sh
ssh-keygen -t ed25519
```

Copy the public key to the root account of all involved hosts:

```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@<SERVER-X>
```

You can also add the content of `~/.ssh/id_ed25519.pub` to `~/.ssh/authorized_keys` of the `root` account of destination hosts.

## Inventory

Move to the ansible-public directory:

```sh
cd /root/ansible-public
```

Make a copy of the `example` inventory:

```sh
# for standard deployment
cp -r inventories/example/std inventories/my-inventory

# for HA deployment
cp -r inventories/example/ha inventories/my-inventory
```

### Hosts and Groups

Edit `inventories/my-inventory/hosts` to match your infrastructure.  
Move, copy and/or delete variable files according to your `hosts` file.

### Variables

If you want to set/override a variable for:

| Target  | File                                              |
| ------- | ------------------------------------------------- |
| all     | `inventories/my-inventory/group_vars/all.yml`     |
| a group | `inventories/my-inventory/group_vars/<group>.yml` |
| a host  | `inventories/my-inventory/host_vars/<host>.yml`   |

The available variables are documented in the `README.md` file of each role (for instance the [nudgis front role](../roles/nudgis/front/README.md)).

### Verify

Make sure Ansible can connect to all the hosts:

```sh
ansible -i inventories/my-inventory -m ping all

<SERVER-X> | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
[...]
```
