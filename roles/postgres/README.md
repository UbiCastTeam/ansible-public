# Postgres
## Description

The postgres group is used to configure the host with a postgresql database.  
 The database can be deployed in standard mode or HA mode (3 servers, 2 configured in active/passive with an automatic switchover and witness).
 The group will determine whether to deploy standard or HA depending on the number of servers in the group (>=2 for the HA case).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`database_password`: Password for the postgres admin account
```
database_password: "changeit"
```
