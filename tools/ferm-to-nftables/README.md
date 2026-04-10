# Ferm to nftables migration

## Purpose

Debian has slowly migrated to nftables since Debian 10. After several releases, nftables is sufficiently integrated to switch over.  
New deployments already use nftables. For existing ones, this script helps you migrate seamlessly.

## Usage

```
./run.sh
```

**Note:** During the operations, an SSH connection to the target server in a new terminal is requested in order to validate the migration.  
In case of issues, follow the instructions provided by the script.
