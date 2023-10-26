# Configuration

## SSH

The Ansible deployment will be done through SSH, so you must be able to connect to all the involved hosts by using SSH public key authentication.

To create a key pair:

```sh
ssh-keygen -t ed25519
```

Copy the public key to the root account of all involved hosts:

```
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@<SERVER-X>
```

You can also add the content of `~/.ssh/id_ed25519.pub` to `~/.ssh/authorized_keys` of the `root` account of destination hosts.

## Inventory

Move to ansible directory

```
cd ./ansible
```

Make a copy of the `example` inventory and eventually customize it with the customer informations.

```sh
# for standard deployment
cp -r inventories/example/std inventories/my-inventory

# for HA deployement
cp -r inventories/example/ha inventories/my-inventory
```

### Hosts and Groups

Edit `inventories/my-inventory/hosts` to match your infrastructure.  
Move, copy and/or delete variables files according to your `hosts` file.

### Variables

If you want to set/override a variable for:

| Target  | File                                              |
| ------- | ------------------------------------------------- |
| all     | `inventories/my-inventory/group_vars/all.yml`     |
| a group | `inventories/my-inventory/group_vars/<group>.yml` |
| a host  | `inventories/my-inventory/host_vars/<host>.yml`   |

All variables needed are defined in ansible roles `README.md` files (for instance for [nudgis frontend role](../roles/mediaserver/README.md))

### Verify

Make sure Ansible can connect to all the hosts:

```sh
ansible -i inventories/customer -m ping all

mymediaserver | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
[...]
```
