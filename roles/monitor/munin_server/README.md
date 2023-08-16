# Munin_server

The munin_server group is used to configure all hosts for publishing monitoring data  
 * In a standard and HA Ubicast case, the host(s) is(are) the same as mediaserver

## Role Variables

Available variables are listed below, along with the descriptions and the default values.

`ubicast_customer_name`: Short name of the customer, with no spaces. This name is used in munin to group the graphs under the same name.
```
ubicast_customer_name: "example"
```
