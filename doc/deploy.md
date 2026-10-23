# Deployment

All the commands below are run from the ansible-public directory with virtual environment activated:

```sh
cd /root/ansible-public
source ansible-venv/bin/activate
```

## Check access

Make sure Ansible can reach all the hosts:

```sh
ansible -i inventories/my-inventory -m ping all
```

## Deploy UbiCast solution

Run the `site.yml` playbook:

```sh
ansible-playbook -i inventories/my-inventory playbooks/site.yml
```

**Note:** if you connect to the hosts with a sudoer user instead of `root`, add the `--become` option (see `ansible-playbook --help`).

Each role is split into 3 tags:

- `install`: install the packages required by the application
- `base`: apply the base configuration of the application
- `configure`: deploy the configuration specific to the role

To run only some of them, add `--tags <tag>[,<tag>]` to the command.

To choose which components to install and configure, copy `playbooks/site.yml` and edit the copy to suit your needs.

## Deploy a single role

To deploy one role on a group of hosts without writing a playbook, pass an inline play on stdin:

```sh
ANSIBLE_ROLES_PATH=roles:roles/system:roles/nudgis \
  ansible-playbook -i inventories/my-inventory /dev/stdin <<'EOF'
- hosts: <HOST-GROUP>
  become: true
  roles:
    - <ROLE>
EOF
```

- `ANSIBLE_ROLES_PATH` is required because the playbook is not in the repository, so the roles cannot be found relative to it
- Variables are read from the inventory as usual
- To override add or override variables: add `-e '<variable>=<value>'` (for instance `-e 'postfix_admin=admin@example.com'`).
- The `--tags` and `--limit` options work here too
