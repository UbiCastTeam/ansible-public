# Base
## Description

The base group is a meta-group used only to group together the various dependencies required by UbiCast solutions.  
 
This group is only meant to be used as a meta group (see for instance meta groups section in the [standard example inventory](../../inventories/example/std/hosts) or [HA example inventory](../../inventories/example/ha/hosts)).  
You should also look at the metagroups of base to fill out the variables in your inventory: [init](../init/README.md), [sysconfig](../sysconfig/README.md), [sysuser](../sysuser/README.md), [postfix](../postfix/README.md), [ferm-install](../ferm-install/README.md), [ferm-configure](../ferm-configure/README.md), [fail2ban](../fail2ban/README.md).
