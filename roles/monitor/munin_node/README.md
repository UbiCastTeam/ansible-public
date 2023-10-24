# Munin_node
## Description

The munin_node group is used to configure all hosts to send monitoring data back to the monitoring server (munin_server group).  
   * In a standard and HA Ubicast case, the hosts are all those that compose the UbiCast platform

This group is only meant to be used as a meta group (see for instance meta groups section in the [standard example inventory](../../inventories/example/std/hosts) or [HA example inventory](../../inventories/example/ha/hosts)).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ubicast_customer_name`: Short name of the customer, with no spaces. This name is used in munin to group the graphs under the same name.
```
ubicast_customer_name: "example"
```
