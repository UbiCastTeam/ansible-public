# Munin_server
## Description

The munin_server group is used to configure all hosts for publishing monitoring data  
 * In a standard and HA Ubicast case, the host(s) is(are) the same as mediaserver  
 
 This group is only meant to be used as a meta group (see for instance meta groups section in the [standard example inventory](../../inventories/example/std/hosts) or [HA example inventory](../../inventories/example/ha/hosts)).

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ubicast_customer_name`: Short name of the customer, with no spaces. This name is used in munin to group the graphs under the same name.
```
ubicast_customer_name: "example"
```

`munin_nodes`: List of munin_nodes with their names and IP (each element of the list is a dictionary with a "name" and a "ip" key) (Optional)
```
munin_nodes: []
```
