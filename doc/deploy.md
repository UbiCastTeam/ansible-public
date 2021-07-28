# Deployment

Move to ansible-public root directory

```sh
cd /root/ansible-public
```

To deploy all components, execute:

```sh
make deploy i=inventories/customer
```

If you want to limit and deploy specific part, you can add a `tag`:

```sh
make deploy i=inventories/customer l=<tag>
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
grep 'tags:' ./playbooks/site.yml | grep -v always | sed 's,.*tags: ,,'
```

