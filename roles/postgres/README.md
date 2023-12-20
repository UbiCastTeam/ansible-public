# Postgres
## Description

The postgres group is used to configure the host with a postgresql database.  
 The database can be deployed in standard mode or HA mode (3 servers, 2 configured in active/passive with an automatic switchover and witness).
 The group will determine whether to deploy standard or HA depending on the number of servers in the group (>=2 for the HA case).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`database_host_authentification`: PostgreSQL user/host connection file (Optional)
```
database_host_authentification:
  - method: peer
    type: local
  - address: 127.0.0.1/32
    type: hostssl
  - address: ::1/128
    type: hostssl
  - database: replication
    method: peer
    type: local
  - address: 127.0.0.1/32
    database: replication
    type: hostssl
  - address: ::1/128
    database: replication
    type: hostssl
```

`database_conf`: PostgreSQL configuration key/values (Optional)
```
database_conf:
  - content: ''
    name: main
```

`database_databases`: Dictionnary of extra databases to deploy (with `name` and `owner` keys) (Optional)
```
database_databases: []
```

`database_password`: Password for the postgres admin account
```
database_password: "changeit"
```

`database_users`: Dictionnary of extra PostgreSQL users to deploy (with `name`, `password`, `db`, `priv` and `roles` keys) (Optional)
```
database_users: []
```

`database_role`: [HA only] Define database role on this host. Possible values: primary, standby or witness (Optional)
```
database_role: ""
```

`repmgr_conninfo`: [HA only] Conninfo parameter populated in the repmgr configuration file (Optional)
```
repmgr_conninfo: "host={{ ansible_default_ipv4.address }} dbname={{ repmgr_database }} user={{ repmgr_user }} connect_timeout={{ repmgr_timeout }}"
```

`repmgr_database`: [HA only] Name of the repmgr database (Optional)
```
repmgr_database: "repmgr"
```

`repmgr_password`: [HA only] Password of the repmgr DB user (Optional)
```
repmgr_password: ""
```

`repmgr_repha_port`: [HA only] Listening port for rephacheck (Optional)
```
repmgr_repha_port: 8543
```

`repmgr_roles`: [HA only] List of roles for the repmgr user PostgreSQL pg_hba configuration (Optional)
```
repmgr_roles: "LOGIN,REPLICATION,SUPERUSER"
```

`repmgr_timeout`: [HA only] Timeout value for the repmgr connections (Optional)
```
repmgr_timeout: 5
```

`repmgr_user`: [HA only] Username of the repmgr DB user (Optional)
```
repmgr_user: "repmgr"
```
