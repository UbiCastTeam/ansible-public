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

If you want to limit and deploy specific part, you can add a `tag`:

```sh
ansible-playbook -i inventories/customer -t <tag> playbooks/site.yml 
```

The avalaible tags are:

| Component     | Tag            |
|---------------|----------------|
| mediaserver   | `server`       |
| mediaworker   | `worker`       |
| mirismanager  | `manager`      |
| mediaimport   | `import`       |
| mediavault    | `vault`        |
| celerity      | `celerity`     |
| ...           | ...            |


To view all tags avalaible, run: 
```
awk '/tags:/ && !/always/ {print $2}' ./playbooks/site.yml
```
