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
cp -r inventories/example inventories/customer

# for HA deployement
cp -r inventories/example-ha inventories/customer
```

There are also inventories for local deployment, you can use one of these lines:
```sh
cp -r inventories/local-full        inventories/customer
cp -r inventories/local-mediaserver inventories/customer
cp -r inventories/local-mediaworker inventories/customer
```

### Hosts and Groups

Edit `inventories/customer/hosts` to match your inrastructure.

### Variables

If you use a local-\* inventory, copy `inventories/customer/host_vars/localhost.dist.yml` to `inventories/customer/host_vars/localhost.yml`.

You **must at least** configure:
- `skyreach_system_key` values in `inventories/customer/host_vars/<host>.yml`

If you want to set/override a variable for:
- all: `inventories/my-customer/group_vars/all.yml`.
- a group:`inventories/my-customer/group_vars/<group>.yml`.
- a host: `inventories/my-customer/host_vars/<host>.yml`.

If hosts have a proxy you have to set the proxy settings in the inventory variables, in `inventories/mcustomer/group_vars/all.yml`:

```yaml
proxy_http: http://proxy.my-customer.net:3128
proxy_https: http://proxy.my-customer.net:3128
```

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

