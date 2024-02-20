# Deployment

Move to ansible-public root directory

```sh
cd /root/ansible-public
```

To test access to all servers, execute:
```sh
ansible -i inventories/customer -m ping all
```

To deploy all components, execute:

```sh
ansible-playbook -i inventories/customer playbooks/site.yml 
```

Additionnaly, each role is splitted into 3 tags:
* "install" to install the application packages required
* "base" to to the base configuration of the application
* "configure" to deploy specific configurations for the role

You can limit your deployment to this tags by using `--tags <tag_name>` to your ansible command.

To personalise components to install/configure during the deployment, the best method is to duplicate and edit the `site.yml` playbook to suit your needs.
